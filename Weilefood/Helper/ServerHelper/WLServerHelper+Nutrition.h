//
//  WLServerHelper+Nutrition.h
//  Weilefood
//
//  Created by kelei on 15/8/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLNutritionModel;

/// 营养推荐相关
@interface WLServerHelper (Nutrition)

/**
 *  获取营养推荐详细信息
 *
 *  @param nutritionId 营养推荐ID
 *  @param callback
 */
- (void)nutrition_getInfoWithNutritionId:(NSUInteger)nutritionId callback:(void (^)(WLApiInfoModel *apiInfo, WLNutritionModel *apiResult, NSError *error))callback;

/**
 *  首页推荐营养列表。(NSArray<WLNutritionModel>)apiResult
 *
 *  @param pageIndex 第几页数据，从1开始
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)nutrition_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取营养列表。(NSArray<WLNutritionModel>)apiResult
 *
 *  @param maxDate   加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)nutrition_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
