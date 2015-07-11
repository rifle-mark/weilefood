//
//  UIGestureRecognizer+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizer+GCDelegateBlock.h"

#import "GCMacro.h"
#import "NSObject+GCAccessor.h"
#import "UIGestureRecognizerDelegateImplementProxy.h"
#import "NSObject+GCProxyRegister.h"








@implementation UIGestureRecognizer (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIGestureRecognizerDelegateImplementProxy class]];
}


@dynamic blockForShouldBegin;
@dynamic blockForShouldReceiveTouch;
@dynamic blockForShouldSimultaneous;
@dynamic blockForShouldRequireFailureOf;
@dynamic blockForShouldBeRequireToFailureBy;


+ (void)load {
    [self extensionAccessorGenerator];
}

@end
