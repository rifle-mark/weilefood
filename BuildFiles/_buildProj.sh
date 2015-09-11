#!/bin/sh

SYSTEM_USER_PASW="mci123"
RED_COLOR="\033[0;31;40m"
GREEN_COLOR="\033[0;32;40m"
END_COLOR="\033[0m"


#======================================================================================================================
# 参数部分
P12_FILE_PATH=""
P12_FILE_PASW=""
PROVISION_FILE_PATH=""
XCODEPROJ_FILE_PATH=""
XCODEPROJ_SCHEME=""
IPA_FILE_PATH=""
dSYM_FILE_PATH=""
while getopts p:w::m:x:s:i:d: opt
do
    case $opt in
        p)
            P12_FILE_PATH=$OPTARG
            ;;
        w)
            P12_FILE_PASW=$OPTARG
            ;;
        m)
            PROVISION_FILE_PATH=$OPTARG
            ;;
        x)
            XCODEPROJ_FILE_PATH=$OPTARG
            ;;
        s)
            XCODEPROJ_SCHEME=$OPTARG
            ;;
        i)
            IPA_FILE_PATH=$OPTARG
            ;;
        d)
            dSYM_FILE_PATH=$OPTARG
            ;;
    esac
done
if [ -z "$P12_FILE_PATH" ]; then
    echo "缺少参数-p"
    exit 1
fi
if [ -z "$PROVISION_FILE_PATH" ]; then
    echo "缺少参数-m"
    exit 1
fi
if [ -z "$XCODEPROJ_FILE_PATH" ]; then
    echo "缺少参数-x"
    exit 1
fi
if [ -z "$XCODEPROJ_SCHEME" ]; then
    echo "缺少参数-s"
    exit 1
fi
if [ -z "$IPA_FILE_PATH" ]; then
    echo "缺少参数-i"
    exit 1
fi
if [ -z $dSYM_FILE_PATH ]; then
    echo "缺少参数-d"
    exit 1
fi


#======================================================================================================================
# 获取证书名称
P12NAME=`
    openssl pkcs12 -in "${P12_FILE_PATH}" -nodes -passin pass:"${P12_FILE_PASW}" |
    openssl x509 -noout -subject |
    sed "s/^subject= \/UID=[^\/]*\/CN=\([^\/]*\).*$/\1/"`
# 获取配置文件UUID
PROVISION_XML=`openssl smime -inform der -verify -noverify -in "${PROVISION_FILE_PATH}"`
PROVISION_ExpirationDate=`echo $PROVISION_XML | sed "s/^.*<key>ExpirationDate<\/key> *<date>\([^<]*\).*/\1/"`
PROVISION_UUID=`echo $PROVISION_XML | sed "s/^.*<key>UUID<\/key> *<string>\([^<]*\).*/\1/"`

# 导入证书
TEMP_V=`security find-certificate -a -c "${P12NAME}" -Z | grep ^SHA-1`
if [ -z "$TEMP_V" ]; then
    echo "导入证书${P12NAME}"
    KEYCHAIN_FILE_PATH="/Users/BuildServer/Library/Keychains/login.keychain"
    `security unlock-keychain -p "${SYSTEM_USER_PASW}" "${KEYCHAIN_FILE_PATH}"`
    security import "${P12_FILE_PATH}" -k "${KEYCHAIN_FILE_PATH}" -P "${P12_FILE_PASW}" –A
else
    echo "证书已存在${P12NAME}"
fi

# 导入配置文件
CURRENT_DIR=`pwd`
cd ~
CURRENT_USER_DIR=`pwd`
cd "${CURRENT_DIR}"
PROVISION_FILE_DIR="${CURRENT_USER_DIR}/Library/MobileDevice/Provisioning Profiles"
PROVISION_FILE_TO_PATH="${PROVISION_FILE_DIR}/${PROVISION_UUID}.mobileprovision"
if [ -f "${PROVISION_FILE_TO_PATH}" ]; then
    echo "文件已存在${PROVISION_UUID}.mobileprovision"
else
    echo "导入${PROVISION_UUID}.mobileprovision"
    mkdir -p "${PROVISION_FILE_DIR}"
    cp "${PROVISION_FILE_PATH}" "${PROVISION_FILE_TO_PATH}"
fi

#======================================================================================================================
# 是否已经安装了xctool
hash xctool 2>/dev/null || { echo >&2 "${RED_COLOR}xctool${END_COLOR} is not installed, installed using '${GREEN_COLOR}brew install xctool${END_COLOR}'"; exit 1; }

# 编译工程
xctool \
    -workspace "${XCODEPROJ_FILE_PATH}" \
    -scheme $XCODEPROJ_SCHEME \
    -configuration Release \
    -sdk iphoneos8.4 \
    CODE_SIGN_IDENTITY="${P12NAME}" \
    PROVISIONING_PROFILE="${PROVISION_UUID}" \
    clean \
    build \

if [ $? -ne 0 ]; then
    exit 1
fi


#======================================================================================================================
# 确定app,ipa文件位置
BUILT_PRODUCTS_DIR=`xctool -workspace "${XCODEPROJ_FILE_PATH}" -scheme ${XCODEPROJ_SCHEME} -showBuildSettings | grep '\bBUILT_PRODUCTS_DIR'`
BUILT_PRODUCTS_DIR=${BUILT_PRODUCTS_DIR#* = }
APP_FILE_PATH=$BUILT_PRODUCTS_DIR/$XCODEPROJ_SCHEME.app
APPdSYM_FILE_PATH=$BUILT_PRODUCTS_DIR/$XCODEPROJ_SCHEME.app.dSYM

# 生成ipa包
if [ -a "$APP_FILE_PATH" ]; then
    xcrun \
        -sdk iphoneos PackageApplication \
        -v $APP_FILE_PATH \
        -o $IPA_FILE_PATH \

    if [ $? -ne 0 ]; then
        echo "${RED_COLOR}create ipa file fail!!{END_COLOR}"
        exit 1
    fi

    echo "${GREEN_COLOR}create ipa file SUCCESS!!${END_COLOR}"
else
    echo "${RED_COLOR}.app file $APP_FILE_PATH not exist!!${END_COLOR}"
fi

# 复制dSYM文件，方便以后好排查应用问题
cp -r "${APPdSYM_FILE_PATH}" "${dSYM_FILE_PATH}"
