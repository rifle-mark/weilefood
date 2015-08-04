//
//  WLNutritionModel.m
//  Weilefood
//
//  Created by kelei on 15/8/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLNutritionModel.h"

@implementation WLNutritionModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        if ([propertyName isEqualToString:@"desc"]) {
            return @"Description";
        }
        return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }];
}

@end
