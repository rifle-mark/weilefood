//
//  WLServerHelper+Order.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Order.h"
#import "WLModelHeader.h"
#import "WLDictionaryHelper.h"

@implementation WLServerHelper (Order)

- (void)order_createWithAddress:(WLOrderAddressModel *)address productList:(NSArray *)productList callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback {
    
    NSMutableArray *detailList = [NSMutableArray array];
    for (WLOrderProductModel *product in productList) {
        [detailList addObject:@{@"Type" : @(product.type),
                                @"RefId": @(product.refId),
                                @"Count": @(product.count),
                                }];
    }
    NSDictionary *orderAddress = nil;
    if (address) {
        orderAddress = @{@"UserName" : address.userName,
                         @"Tel"      : address.tel,
                         @"Address"  : address.address,
                         @"PostCode" : address.postCode,
                         };
    }
    NSDictionary *parameters = @{@"orderDetail"  : detailList,
                                 @"orderAddress" : orderAddress ?: [NSNull null]};
    
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"order"]];
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLOrderModel class] callback:callback];
}

- (void)order_confirmWithOrderId:(long long)orderId callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"confirmorder"]];
    NSDictionary *parameters = @{@"orderid":@(orderId)};
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLOrderModel class] callback:callback];
}

- (void)order_getDetailWithOrderId:(long long)orderId callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"detail", @(orderId)]];
    [[self httpManager] GET:apiUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        WLOrderModel *apiResult = nil;
        if (apiInfo.isSuc) {
            NSDictionary *dic = responseDic[API_RESULT_KEYNAME];
            apiResult = [WLOrderModel objectWithKeyValues:dic];
            
            NSDictionary *orderForm = [dic valueForKey:@"OrderForm"];
            if (orderForm) {
                apiResult.orderDate = [orderForm valueForKey:@"OrderDate"];
                apiResult.orderId = [[orderForm valueForKey:@"OrderId"] longLongValue];
                apiResult.orderNum = [orderForm valueForKey:@"OrderNum"];
                apiResult.orderType = [[orderForm valueForKey:@"OrderType"] integerValue];
                apiResult.paymentDate = [orderForm valueForKey:@"PaymentDate"];
                apiResult.paymentId = [[orderForm valueForKey:@"PaymentId"] longLongValue];
                apiResult.state = [[orderForm valueForKey:@"State"] integerValue];
                apiResult.totalMoney = [[orderForm valueForKey:@"TotalMoney"] floatValue];
                apiResult.userId = [[orderForm valueForKey:@"UserId"] longLongValue];
                apiResult.postAge = [[orderForm valueForKey:@"PostAge"] floatValue];
            }
        }
        GCBlockInvoke(callback, apiInfo, apiResult, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, nil, error);
    }];
}

- (void)order_getDoctorListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"mydoctororder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0)};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

- (void)order_getForwardbuyListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"myforwardbuyorder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0)};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

- (void)order_getActivityListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"myactivityorder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0)};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

- (void)order_getProductListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"myproductorder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0)};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

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
                                     callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"customerneed", @"add"]];
    NSDictionary *parameters = @{@"customerNeed" : @{@"OrderId" : @(orderId),
                                                     @"TrueName" : trueName,
                                                     @"Sex" : sex,
                                                     @"Age" : age,
                                                     @"Tel" : tel,
                                                     @"Height" : height,
                                                     @"Weight" : weight,
                                                     @"Waist" : waist,
                                                     @"Address" : address,
                                                     @"SecondName" : secondName,
                                                     @"SecondTel" : secondTel,
                                                     @"IsChronic" : isChronic,
                                                     @"ChronicName" : chronicName,
                                                     @"SickDesc" : sickDesc,
                                                     @"Demand" : demand,
                                                     @"ForbiddenFood" : forbiddenFood,
                                                     @"Breakfast" : breakfast,
                                                     @"Lunch" : lunch,
                                                     @"Dinner" : dinner,
                                                     @"OtherDesc" : otherDesc,
                                                     @"Remark" : remark,
                                                     }};
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}
@end
