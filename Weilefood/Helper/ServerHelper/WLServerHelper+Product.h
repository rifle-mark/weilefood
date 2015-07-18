//
//  WLServerHelper+Product.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLProductModel;

@interface WLServerHelper (Product)

/**
 *  获取市集产品详细信息
 *
 *  @param productId 产品ID
 *  @param callback
 */
- (void)product_getInfoWithProductId:(NSUInteger)productId callback:(void (^)(WLApiInfoModel *apiInfo, WLProductModel *apiResult, NSError *error))callback;

/**
 *  获取市集首页推荐产品列表
 *
 *  @param pageIndex 获取第几页数据，从1开始
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)product_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  根据市集栏目获取市集产品列表。(NSArray<WLProductModel>)apiResult
 *
 *  @param channelId 市集栏目ID
 *  @param maxDate   加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)product_getListWithChannelId:(NSUInteger)channelId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
