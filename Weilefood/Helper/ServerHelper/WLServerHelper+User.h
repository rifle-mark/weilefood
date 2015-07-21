//
//  WLServerHelper+User.h
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLUserModel;

/// 第三方账号平台
typedef NS_ENUM(NSUInteger, WLUserPlatform){
    /// 新浪微博
    WLUserPlatformSinaWeibo         = 1,
    /// 腾讯微博
    WLUserPlatformTencentWeibo      = 2,
    /// QQ空间
    WLUserPlatformQZone             = 3,
    /// 微信
    WLUserPlatformWechat            = 4,
    /// 微信朋友圈
    WLUserPlatformWechatmoments     = 5,
    /// 微信收藏
    WLUserPlatformWechatFavorite    = 6,
    /// QQ
    WLUserPlatformQQ                = 7,
};

@interface WLServerHelper (User)

/**
 *  用户注册
 *
 *  @param userName 登录名
 *  @param password 密码明文
 *  @param callback 完成时回调
 */
- (void)user_regWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback;

/**
 *  用户登录
 *
 *  @param userName 登录名
 *  @param password 密码明文
 *  @param callback 完成时回调
 */
- (void)user_loginWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback;

/**
 *  第三方账号登录
 *
 *  @param platform 账号平台
 *  @param openId   账号OpenId或者UID
 *  @param token    账号登陆后的Token(注意非本系统Token)
 *  @param avatar   头像地址
 *  @param appId    应用ID,第三方社交账号申请的APPID
 *  @param nickName 昵称
 *  @param callback 完成时回调
 */
- (void)user_socialLoginWithPlatform:(WLUserPlatform)platform openId:(NSString *)openId token:(NSString *)token avatar:(NSString *)avatar appId:(NSString *)appId nickName:(NSString *)nickName callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback;

/**
 *  修改用户昵称和头像
 *
 *  @param nickName 昵称
 *  @param avatar   头像URL
 *  @param callback 完成时回调
 */
- (void)user_updateWithNickName:(NSString *)nickName avatar:(NSString *)avatar callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback;

/**
 *  重置密码
 *
 *  @param userName 登录名
 *  @param password 新密码
 *  @param callback 完成时回调
 */
- (void)user_resetPasswordWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

@end
