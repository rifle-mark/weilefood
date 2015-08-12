//
//  WLServerHelper+Activity.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Activity.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Activity)

- (void)activity_getInfoWithActivityId:(NSUInteger)activityId callback:(void (^)(WLApiInfoModel *apiInfo, WLActivityModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"activity", @"detail", @(activityId)]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLActivityModel class] callback:callback];
}

- (void)activity_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"activity", @"reclist", @(pageIndex), @(pageSize)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLActivityModel class] callback:callback];
}

- (void)activity_getListWithCity:(NSString *)city maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"activity", @"list"]];
    NSDictionary *parameters = @{@"pageindex"   : @1,
                                 @"pagesize"    : @(pageSize),
                                 @"city"        : city,
                                 @"maxdate"     : @([maxDate millisecondIntervalSince1970]),
                                 };
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLActivityModel class] callback:callback];
}

- (void)activity_getCityListWithCallback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"activity", @"citylist"]];
    [self httpGET:apiUrl parameters:nil resultArrayClass:[WLActivityCityModel class] callback:callback];
}

@end
