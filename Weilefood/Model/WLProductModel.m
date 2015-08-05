//
//  WLProductModel.m
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLProductModel.h"

@implementation WLProductModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        if ([propertyName isEqualToString:@"desc"]) {
            return @"Description";
        }
        return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }];
}

+ (NSDictionary *)objectClassInArray {
    return @{@"pictures":[WLProductPictureModel class],
             @"Pictures":[WLProductPictureModel class]};
}

@end

@implementation WLProductPictureModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
}

@end
