//
//  UITabBarController+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabBarController+GCDelegateBlock.h"
#import "UITabbarControllerDelegateImplementationProxy.h"

#import <objc/runtime.h>
#import "NSObject+GCAccessor.h"
#import "NSObject+GCProxyRegister.h"

@implementation UITabBarController (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UITabbarControllerDelegateImplementationProxy class]];
}


@dynamic blockForShouldSelectViewController;
@dynamic blockForDidSelectViewController;
@dynamic blockForWillBeginCustomizingViewControllers;
@dynamic blockForWillEndCustomizingViewControllersChanged;
@dynamic blockForDidEndCustomizingViewControllersChanged;
@dynamic blockForSupportedInterfaceOrientations;
@dynamic blockForPreferredInterfaceOrientation;
@dynamic blockForAnimationForTransitionController;
@dynamic blockForInteractiveForAnimationController;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
