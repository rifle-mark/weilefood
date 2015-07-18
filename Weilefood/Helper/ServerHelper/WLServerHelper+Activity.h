//
//  WLServerHelper+Activity.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLActivityModel;

/// 活动类型
typedef NS_ENUM(NSUInteger, WLActivityType) {
    /// 线上活动
    WLActivityTypeOnline    = 1,
    /// 线下活动
    WLActivityTypeOffline   = 2,
};

@interface WLServerHelper (Activity)

/**
 *  获取活动详细信息
 *
 *  @param activityId 预购ID
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
 *  @param type      活动类型
 *  @param maxDate   加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)activity_getListWithType:(WLActivityType)type maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
