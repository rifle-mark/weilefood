//
//  UtilsMacro.h
//  LawyerCenter
//
//  Created by kelei on 15/6/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#ifndef Weilefood_UtilsMacro_h
#define Weilefood_UtilsMacro_h

/*
 *  System Versioning Preprocessor Macros
 */

/**
 *  设备版本号 == v
 *
 *  @param v 版本号字符串
 *
 *  @return BOOL
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

/**
 *  设备版本号 > v
 *
 *  @param v 版本号字符串
 *
 *  @return BOOL
 */
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

/**
 *  设备版本号 >= v
 *
 *  @param v 版本号字符串
 *
 *  @return BOOL
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

/**
 *  设备版本号 < v
 *
 *  @param v 版本号字符串
 *
 *  @return BOOL
 */
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/**
 *  设备版本号 <= v
 *
 *  @param v 版本号字符串
 *
 *  @return BOOL
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 *  只在DEBUG时输出日志，同时输入调用的类名、方法名和代码所在行数
 *
 *  @param format
 *  @param ...
 *
 *  @return
 */
#ifdef DEBUG
#define DLog(format, ...) NSLog((@"%@ | %@ | %d | " format), NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__, ## __VA_ARGS__)
#else
#define DLog(format, ...)
#endif

#define _weak(x)                __weak typeof(x) weak##x = x
#define _strong(x)              typeof(weak##x) x = weak##x
#define _strong_check(x, ...)   typeof(weak##x) x = weak##x; if (!weak##x) return __VA_ARGS__

/**
 *  将属性名着字母大写。对应MJExtension setupReplacedKeyFromPropertyName121方法的block
 */
#define CapitalizedPropertyName ^NSString *(NSString *propertyName) { \
    return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]]; \
}

/**
 *  网络API接口回调中对错误的标准处理过程
 */
#define ServerHelperErrorHandle \
if (error) {\
    DLog(@"%@", error);\
    return;\
}\
if (!apiInfo.isSuc) {\
    if (apiInfo.message && apiInfo.message.length > 0) {\
        [MBProgressHUD showErrorWithMessage:apiInfo.message];\
    }\
    return;\
}

/**
 *  修复iOS7在viewDidLayoutSubviews中设置约束后会闪退问题。在viewDidLayoutSubviews最后调用此代码
 */
#define FixesViewDidLayoutSubviewsiOS7Error \
if (SYSTEM_VERSION_LESS_THAN(@"8")) {\
    [self.view layoutSubviews];\
}

#endif
