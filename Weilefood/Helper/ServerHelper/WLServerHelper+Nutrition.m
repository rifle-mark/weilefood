//
//  WLServerHelper+Nutrition.m
//  Weilefood
//
//  Created by kelei on 15/8/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Nutrition.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Nutrition)

- (void)nutrition_getInfoWithNutritionId:(NSUInteger)nutritionId callback:(void (^)(WLApiInfoModel *apiInfo, WLNutritionModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"classroom", @"detail", @(nutritionId)]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLNutritionModel class] callback:callback];
}

- (void)nutrition_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"classroom", @"reclist", @(pageIndex), @(pageSize)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLNutritionModel class] callback:callback];
}

- (void)nutrition_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"classroom", @"list"]];
    NSDictionary *parameters = @{@"pageindex"   : @1,
                                 @"pagesize"    : @(pageSize),
                                 @"type"        : @1,
                                 @"maxdate"     : @([maxDate millisecondIntervalSince1970]),
                                 };
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLNutritionModel class] callback:callback];
}

@end
