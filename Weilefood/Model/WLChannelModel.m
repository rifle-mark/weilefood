//
//  WLChannelModel.m
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLChannelModel.h"

@implementation WLChannelModel

+ (void)initialize {
    [self setupObjectClassInArray:^NSDictionary *{
        return @{@"childChannel": @"WLChannelModel"};
    }];
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
}

+ (NSDictionary *)objectClassInArray {
    return @{@"childChannel":[WLChannelModel class],
             @"ChildChannel":[WLChannelModel class]};
}

@end
