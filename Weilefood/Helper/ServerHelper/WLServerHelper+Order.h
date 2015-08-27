//
//  WLServerHelper+Order.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLOrderAddressModel, WLOrderModel;

@interface WLServerHelper (Order)

/**
 *  生成订单
 *
 *  @param address     收货人信息
 *  @param productList 购买的商品列表<WLOrderProductModel>
 *  @param callback
 */
- (void)order_createWithAddress:(WLOrderAddressModel *)address productList:(NSArray *)productList callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback;

/**
 *  确认收货
 *
 *  @param orderId  订单ID
 *  @param callback
 */
- (void)order_confirmWithOrderId:(long long)orderId callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback;

/**
 *  获取订单详细信息
 *
 *  @param orderId  订单ID
 *  @param callback
 */
- (void)order_getDetailWithOrderId:(long long)orderId callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback;

/**
 *  获取 我的营养师订单列表。(NSArray<WLOrderModel>)apiResult
 *
 *  @param maxDate  加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)order_getDoctorListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取 我的预购订单列表。(NSArray<WLOrderModel>)apiResult
 *
 *  @param maxDate  加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)order_getForwardbuyListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取 我的活动订单列表。(NSArray<WLOrderModel>)apiResult
 *
 *  @param maxDate  加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)order_getActivityListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取 我的集市商品订单列表。(NSArray<WLOrderModel>)apiResult
 *
 *  @param maxDate  加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)order_getProductListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
