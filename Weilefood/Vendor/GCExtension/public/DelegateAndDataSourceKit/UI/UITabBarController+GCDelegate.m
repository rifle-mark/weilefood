//
//  UITabBarController+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabBarController+GCDelegate.h"
#import "UITabBarController+GCDelegateBlock.h"

@implementation UITabBarController (GCDelegate)

- (instancetype)withBlockForShouldSelectViewController:(BOOL (^)(UITabBarController* tab, UIViewController* viewController))block {
    self.blockForShouldSelectViewController = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidSelectViewController:(void (^)(UITabBarController* tab, UIViewController* viewController))block {
    self.blockForDidSelectViewController = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillBeginCustomizingViewControllers:(void (^)(UITabBarController* tab, NSArray* viewControllers))block {
    self.blockForWillBeginCustomizingViewControllers = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillEndCustomizingViewControllersChanged:(void (^)(UITabBarController* tab, NSArray* viewControllers, BOOL changed))block {
    self.blockForWillEndCustomizingViewControllersChanged = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndCustomizingViewControllersChanged:(void (^)(UITabBarController* tab, NSArray* viewControllrs, BOOL changed))block {
    self.blockForDidEndCustomizingViewControllersChanged = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSupportedInterfaceOrientations:(NSUInteger (^)(UITabBarController* tab))block {
    self.blockForSupportedInterfaceOrientations = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForPreferredInterfaceOrientation:(UIInterfaceOrientation (^)(UITabBarController* tab))block {
    self.blockForPreferredInterfaceOrientation = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForAnimationForTransitionController:(id<UIViewControllerAnimatedTransitioning> (^)(UITabBarController* tab, UIViewController* fromVC, UIViewController* toVC))block {
    self.blockForAnimationForTransitionController = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForInteractiveForAnimationController:(id<UIViewControllerInteractiveTransitioning> (^)(UITabBarController* tab, id<UIViewControllerAnimatedTransitioning> viewController))block {
    self.blockForInteractiveForAnimationController = block;
    [self usingBlocks];
    return self;
}

@end
