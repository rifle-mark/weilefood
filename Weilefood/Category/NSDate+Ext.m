//
//  NSDate+Ext.m
//  Weilefood
//
//  Created by kelei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "NSDate+Ext.h"

@implementation NSDate (Ext)

- (NSTimeInterval)millisecondIntervalSince1970 {
    return [self timeIntervalSince1970] * 1000;
}

- (NSTimeInterval)millisecondIntervalSince1970_Beijing {
    return ([self timeIntervalSince1970] + 8 * 60 * 60) * 1000;
}

@end
