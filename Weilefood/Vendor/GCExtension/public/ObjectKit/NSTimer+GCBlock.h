//
//  NSTimer+GCBlock.h
//  GCExtension
//
//  Created by njgarychow on 9/23/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GCTimerActionBlock)(NSTimer* timer);

@interface NSTimer (GCBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(GCTimerActionBlock)action;

@end
