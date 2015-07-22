//
//  WLServerHelper+User.m
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+User.h"
#import "WLModelHeader.h"
#import "WLDictionaryHelper.h"

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

- (void)user_updateWithNickName:(NSString *)nickName avatar:(NSString *)avatar callback:(void (^)(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"update"]];
    NSDictionary *parameters = @{@"userInfo": @{@"NickName"   : nickName,
                                                @"Avatar"     : avatar,
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

- (void)user_getPhoneCodeWithPhoneNum:(NSString *)phoneNum callback:(void (^)(WLApiInfoModel *apiInfo, NSString *phoneCode, NSError *error))callback {
    AFHTTPRequestOperationManager *manager = [self httpManager];
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"phonecode"]];
    NSDictionary *parameters = @{@"phonenum" : phoneNum};
    [manager POST:apiUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        NSString *phoneCode = nil;
        if (apiInfo.isSuc) {
            phoneCode = responseDic[API_RESULT_KEYNAME];
        }
        GCBlockInvoke(callback, apiInfo, phoneCode, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, nil, error);
    }];
}

@end
