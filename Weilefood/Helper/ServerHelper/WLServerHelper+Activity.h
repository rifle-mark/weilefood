//
//  WLServerHelper+Activity.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLActivityModel;

/// 活动相关
@interface WLServerHelper (Activity)

/**
 *  获取活动详细信息
 *
 *  @param activityId 活动ID
 *  @param callback
 */
- (void)activity_getInfoWithActivityId:(NSUInteger)activityId callback:(void (^)(WLApiInfoModel *apiInfo, WLActivityModel *apiResult, NSError *error))callback;

/**
 *  首页推荐活动列表。(NSArray<WLActivityModel>)apiResult
 *
 *  @param pageIndex 第几页数据，从1开始
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)activity_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取活动列表。(NSArray<WLActivityModel>)apiResult
 *
 *  @param city      活动城市(中文字符串)
 *  @param maxDate   加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)activity_getListWithCity:(NSString *)city maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取活动已开通城市列表。(NSArray<WLActivityCityModel>)apiResult
 *
 *  @param callback
 */
- (void)activity_getCityListWithCallback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
