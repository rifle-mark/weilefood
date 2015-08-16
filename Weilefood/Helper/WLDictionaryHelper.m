//
//  WLDictionaryHelper.m
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDictionaryHelper.h"

@implementation WLDictionaryHelper

+ (NSDictionary *)validModelDictionary:(NSDictionary *)dic {
    NSMutableDictionary* validDictionary = [dic mutableCopy];
    for (NSString* key in [dic allKeys]) {
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSString class]] && [value hasPrefix:@"/Date("]) {
            NSRange range = NSMakeRange(6, 10);
            unsigned long int timeValue = [[value substringWithRange:range] integerValue];
            timeValue -= 8 * 60 * 60;// 服务端返回的+8北京时间，所以这里减8小时。
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeValue];
            [validDictionary setObject:date forKey:key];
        }
        else if ([value isKindOfClass:[NSDictionary class]]) {
            [validDictionary setObject:[self validModelDictionary:value] forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [value mutableCopy];
            for (NSUInteger i = 0; i < array.count; i++) {
                id item = array[i];
                if ([item isKindOfClass:[NSDictionary class]]) {
                    array[i] = [self validModelDictionary:item];
                }
            }
            [validDictionary setObject:array forKey:key];
        }
        else if ([NSNull null] == value) {
            [validDictionary removeObjectForKey:key];
        }
    }
    return validDictionary;
}

@end
