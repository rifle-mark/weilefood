//
//  WLServerHelper+Order.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Order.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Order)

- (void)order_createWithAddress:(WLOrderAddressModel *)address productList:(NSArray *)productList callback:(void (^)(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error))callback {
    
    NSMutableArray *detailList = [NSMutableArray array];
    for (WLOrderProductModel *product in productList) {
        [detailList addObject:@{@"Type" : @(product.type),
                                @"RefId": @(product.refId),
                                @"Count": @(product.count),
                                }];
    }
    NSDictionary *parameters = @{@"orderDetail": detailList,
                                 @"orderAddress": @{@"UserName" : address.userName,
                                                    @"Tel"      : address.tel,
                                                    @"Address"  : address.address,
                                                    @"PostCode" : address.postCode,
                                                    }};
    
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
    [self httpGET:apiUrl parameters:nil resultClass:[WLOrderModel class] callback:callback];
}

- (void)order_getDoctorListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"mydoctororder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @([maxDate millisecondIntervalSince1970])};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

- (void)order_getForwardbuyListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"myforwardbuyorder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @([maxDate millisecondIntervalSince1970])};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

- (void)order_getActivityListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"myactivityorder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @([maxDate millisecondIntervalSince1970])};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

- (void)order_getProductListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"orderform", @"myproductorder"]];
    NSDictionary *parameters = @{@"pagesize"  : @(pageSize),
                                 @"orderDate" : @([maxDate millisecondIntervalSince1970])};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLOrderModel class] callback:callback];
}

@end
