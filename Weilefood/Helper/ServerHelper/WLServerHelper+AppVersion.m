//
//  WLServerHelper+AppVersion.m
//  Weilefood
//
//  Created by kelei on 15/9/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+AppVersion.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (AppVersion)

- (void)appVersion_getWithCallback:(void(^)(WLApiInfoModel* apiInfo, WLAppVersionModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"appversion", @"version", @"1"]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLAppVersionModel class] callback:callback];
}

@end
