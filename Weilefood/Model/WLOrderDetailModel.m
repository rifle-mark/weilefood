//
//  WLOrderDetailModel.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLOrderDetailModel.h"

@implementation WLOrderDetailModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
    [self setupObjectClassInArray:^NSDictionary *{
        return @{@"orderDetail" : @"WLOrderProductModel"};
    }];
}

@end
