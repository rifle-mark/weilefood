//
//  WLServerHelper+User.h
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLApiInfoModel, WLUserModel;

@interface WLServerHelper (User)

/**
 *  用户注册
 *
 *  @param userName 登录名
 *  @param password 密码明文
 *  @param callback 完成时回调
 */
- (void)regUserWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback;

@end
