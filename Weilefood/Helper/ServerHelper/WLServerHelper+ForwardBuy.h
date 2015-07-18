//
//  WLServerHelper+ForwardBuy.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLForwardBuyModel;

@interface WLServerHelper (ForwardBuy)

/**
 *  获取预购详细信息
 *
 *  @param forwardBuylId 预购ID
 *  @param callback
 */
- (void)forwardBuy_getInfoWithForwardBuylId:(NSUInteger)forwardBuylId callback:(void (^)(WLApiInfoModel *apiInfo, WLForwardBuyModel *apiResult, NSError *error))callback;

/**
 *  首页推荐预购列表。(NSArray<WLForwardBuyModel>)apiResult
 *
 *  @param pageIndex 第几页数据，从1开始
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)forwardBuy_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  根据栏目获取预购列表。(NSArray<WLForwardBuyModel>)apiResult
 *
 *  @param channelId 栏目ID
 *  @param maxDate   加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)forwardBuy_getListWithChannelId:(NSUInteger)channelId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
