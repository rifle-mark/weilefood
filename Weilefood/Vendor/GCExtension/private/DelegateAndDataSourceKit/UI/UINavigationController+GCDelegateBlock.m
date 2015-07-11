//
//  UINavigationController+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UINavigationController+GCDelegateBlock.h"
#import "UINavigationControllerDelegateImplementionProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UINavigationController (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UINavigationControllerDelegateImplementionProxy class]];
}


@dynamic blockForWillShowViewController;
@dynamic blockForDidShowViewController;
@dynamic blockForAnimationForOperation;
@dynamic blockForInteractionController;
@dynamic blockForPreferedInterfaceOrientation;
@dynamic blockForSupportedInterfaceOrientation;


+ (void)load {
    [self extensionAccessorGenerator];
}

@end
