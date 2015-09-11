#!/bin/sh

OPTIONS="可用参数：release|dis"

if [ $# -eq 0 ]; then
    echo "缺少参数。${OPTIONS}"
    exit 1
fi

case $1 in
    release)
        P12FILE_PATH="`pwd`/mci企业证书.p12"
        P12FILE_PASW=""
        PROVISION_PATH="`pwd`/MCI_Enterprise_Distribution.mobileprovision"
        ;;
    dis)
        P12FILE_PATH="`pwd`/dis_weile.p12"
        P12FILE_PASW="duangduangwei"
        PROVISION_PATH="`pwd`/dis_weile.mobileprovision"
        ;;
    *)
        echo "不支持此参数 $1。${OPTIONS}"
        exit 1
        ;;
esac

IPAFILES_PATH="`pwd`/IPAFiles"
if [ ! -d "$IPAFILES_PATH" ]; then
    mkdir -p "${IPAFILES_PATH}"
fi
IPAFILE_NAME="Weilefood_$1_`date +%m%d%H`"

./_buildProj.sh \
    -p "${P12FILE_PATH}" \
    -w "${P12FILE_PASW}" \
    -m "${PROVISION_PATH}" \
    -x "`pwd`/../Weilefood.xcworkspace" \
    -s "Weilefood" \
    -i "${IPAFILES_PATH}/${IPAFILE_NAME}.ipa" \
    -d "${IPAFILES_PATH}/${IPAFILE_NAME}.dSYM" \