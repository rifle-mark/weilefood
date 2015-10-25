//
//  WLServerHelper+Points.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLPointsModel;
@class WLPointRulerModel;

/// 积分类型
typedef NS_ENUM(NSUInteger, WLPointsType);

@interface WLServerHelper (Points)

- (void)points_getRulerListCallback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  增加积分
 *
 *  @param type     积分类型
 *  @param callback
 */
- (void)points_addWithType:(WLPointsType)type callback:(void (^)(WLApiInfoModel *apiInfo, WLPointsModel *apiResult, NSError *error))callback;

/**
 *  获取积分列表
 *
 *  @param maxDate  加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)points_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
