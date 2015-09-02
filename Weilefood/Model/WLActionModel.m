//
//  WLActionModel.m
//  Weilefood
//
//  Created by kelei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLActionModel.h"

@implementation WLActionModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        if ([propertyName isEqualToString:@"actionId"]) {
            return @"Id";
        }
        return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }];
}

@end
