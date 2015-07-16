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
    AFHTTPRequestOperationManager *manager = [self httpManager];
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"user", @"reg"]];
    NSDictionary *parameters = @{@"regUser": @{@"UserName": userName,
                                               @"Password": password,
                                               }};
    [manager POST:apiUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        WLUserModel *apiResult = nil;
        if (apiInfo.isSuc) {
            NSDictionary *dic = responseDic[kServerResultKey];
            apiResult = [WLUserModel objectWithKeyValues:dic];
        }
        GCBlockInvoke(callback, apiInfo, apiResult, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, nil, error);
    }];
}

@end
