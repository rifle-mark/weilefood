//
//  WLDoctorModel.m
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDoctorModel.h"

@implementation WLDoctorModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        if ([propertyName isEqualToString:@"desc"]) {
            return @"Description";
        }
        if ([propertyName isEqualToString:@"service"]) {
            return propertyName;
        }
        return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }];
}

+ (NSDictionary *)objectClassInArray{
    return @{@"service" : [WLDoctorServiceModel class]};
}

@end


@implementation WLDoctorServiceModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:CapitalizedPropertyName];
}

@end
