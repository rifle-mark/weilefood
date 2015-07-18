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

- (void)activity_getListWithType:(WLActivityType)type maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"activity", @"list", @(1), @(pageSize), @(type), @([maxDate timeIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLActivityModel class] callback:callback];
}

@end
