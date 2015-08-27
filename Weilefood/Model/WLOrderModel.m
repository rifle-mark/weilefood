//
//  WLOrderModel.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLOrderModel.h"
#import "WLOrderProductModel.h"

@implementation WLOrderModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
}

+ (NSDictionary *)objectClassInArray{
    return @{@"orderDetail" : [WLOrderProductModel class],
             @"OrderDetail" : [WLOrderProductModel class],
             };
}

@end

@implementation WLOrderDeliverModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
}

@end

@implementation WLOrderAddressModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
}

@end
