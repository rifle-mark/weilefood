//
//  NSDate+Ext.h
//  Weilefood
//
//  Created by kelei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ext)

/**
 *  实例时间相对与1970年的毫秒数
 *
 *  @return 毫秒数
 */
- (NSTimeInterval)millisecondIntervalSince1970;

/**
 *  实例时间相对与1970年的毫秒数，并加上北京时区+8小时
 *
 *  @return 北京时区+8小时毫秒数
 */
- (NSTimeInterval)millisecondIntervalSince1970_Beijing;

@end
