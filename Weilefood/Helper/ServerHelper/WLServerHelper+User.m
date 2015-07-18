//
//  WLServerHelper+User.m
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+User.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (User)

- (void)user_regWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"reg"]];
    NSDictionary *parameters = @{@"regUser": @{@"UserName": userName,
                                               @"Password": password,
                                               }};
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLUserModel class] callback:callback];
}

- (void)user_loginWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"login"]];
    NSDictionary *parameters = @{@"userName": userName,
                                 @"password": password,
                                 };
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLUserModel class] callback:callback];
}

- (void)user_socialLoginWithPlatform:(WLUserPlatform)platform openId:(NSString *)openId token:(NSString *)token avatar:(NSString *)avatar appId:(NSString *)appId nickName:(NSString *)nickName callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"social", @"login"]];
    NSDictionary *parameters = @{@"socialuser": @{@"Platform"   : @(platform),
                                                  @"OpenId"     : openId,
                                                  @"Token"      : token,
                                                  @"Avatar"     : avatar,
                                                  @"AppId"      : appId,
                                                  @"NickName"   : nickName,
                                                  }};
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLUserModel class] callback:callback];
}

- (void)user_resetPasswordWithUserName:(NSString *)userName password:(NSString *)password callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"setpass"]];
    NSDictionary *parameters = @{@"username": userName,
                                 @"password": password,
                                 };
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

@end
