//
//  NSTimer+GCBlock.m
//  GCExtension
//
//  Created by njgarychow on 9/23/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "NSTimer+GCBlock.h"

#import "NSObject+GCAccessor.h"
#import "GCMacro.h"

@interface NSTimer (GCBlockAccessor)

GCBlockProperty GCTimerActionBlock action;

@end

@implementation NSTimer (GCBlockAccessor)

@dynamic action;
+ (void)load {
    [self extensionAccessorGenerator];
}

@end





@implementation NSTimer (GCBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                    repeats:(BOOL)yesOrNo
                                     action:(GCTimerActionBlock)action {
    
    NSTimer* timer = [NSTimer
                      scheduledTimerWithTimeInterval:ti
                      target:self
                      selector:@selector(autoAction:)
                      userInfo:nil
                      repeats:yesOrNo];
    timer.action = action;
    return timer;
}

+ (void)autoAction:(NSTimer *)timer {
    GCBlockInvoke(timer.action, timer);
}

@end
