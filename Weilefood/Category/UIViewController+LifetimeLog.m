//
//  UIViewController+LifetimeLog.m
//  LawyerCenter
//
//  Created by kelei on 15/7/7.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIViewController+LifetimeLog.h"

@implementation UIViewController (LifetimeLog)

- (instancetype)init {
    if (self = [super init]) {
        DLog(@"%@ 被创建", self);
    }
    return self;
}

- (void)dealloc {
    DLog(@"%@ 被销毁", self);
}

@end
