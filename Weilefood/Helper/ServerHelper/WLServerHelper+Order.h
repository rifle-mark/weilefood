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
 *  @param address     收货人信息，不需要收货人信息传nil
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

/**
 *  营养师服务订单，提交用户资料
 *
 *  @param orderId       营养师服务订单ID
 *  @param trueName      姓名
 *  @param sex           性别
 *  @param age           年龄
 *  @param tel           电话
 *  @param height        身高
 *  @param weight        体重
 *  @param waist         腰围
 *  @param address       地址
 *  @param secondName    第二联系人姓名
 *  @param secondTel     第二联系人电话
 *  @param isChronic     是否慢性病
 *  @param chronicName   慢性病名称，多个以逗号隔开
 *  @param sickDesc      患病程度概述
 *  @param demand        调理诉求
 *  @param forbiddenFood 忌口食物
 *  @param breakfast     早餐
 *  @param lunch         午餐
 *  @param dinner        晚餐
 *  @param otherDesc     其他
 *  @param remark        备注
 *  @param callback
 */
- (void)order_submitUserHealthInfoWithOrderId:(long long)orderId
                                     trueName:(NSString *)trueName
                                          sex:(NSString *)sex
                                          age:(NSString *)age
                                          tel:(NSString *)tel
                                       height:(NSString *)height
                                       weight:(NSString *)weight
                                        waist:(NSString *)waist
                                      address:(NSString *)address
                                   secondName:(NSString *)secondName
                                    secondTel:(NSString *)secondTel
                                    isChronic:(NSString *)isChronic
                                  chronicName:(NSString *)chronicName
                                     sickDesc:(NSString *)sickDesc
                                       demand:(NSString *)demand
                                forbiddenFood:(NSString *)forbiddenFood
                                    breakfast:(NSString *)breakfast
                                        lunch:(NSString *)lunch
                                       dinner:(NSString *)dinner
                                    otherDesc:(NSString *)otherDesc
                                       remark:(NSString *)remark
                                     callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

@end
