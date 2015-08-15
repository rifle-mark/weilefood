//
//  WLForwardBuyModel.m
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLForwardBuyModel.h"
#import "WLPictureModel.h"

@implementation WLForwardBuyModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        if ([propertyName isEqualToString:@"desc"]) {
            return @"Description";
        }
        return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }];
}

+ (NSDictionary *)objectClassInArray {
    return @{@"pictures":[WLPictureModel class],
             @"Pictures":[WLPictureModel class]};
}

@end
