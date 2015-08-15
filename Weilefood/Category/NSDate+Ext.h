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

@end
