//
//  WLServerHelper+Points.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Points.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Points)

- (void)points_addWithType:(WLPointsType)type callback:(void (^)(WLApiInfoModel *apiInfo, WLPointsModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"points", @"add"]];
    NSDictionary *parameters = @{@"type" : @(type)};
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLPointsModel class] callback:callback];
}

- (void)points_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"points", @"list", @(pageSize), @([maxDate timeIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLPointsModel class] callback:callback];
}

@end
