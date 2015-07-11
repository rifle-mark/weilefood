//
//  UINavigationController+GCDelegate.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UINavigationController+GCDelegate.h"
#import "UINavigationController+GCDelegateBlock.h"

@implementation UINavigationController (GCDelegate)

- (instancetype)withBlockForWillShowViewController:(void (^)(UINavigationController* navi, UIViewController* vc, BOOL animated))block {
    self.blockForWillShowViewController = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidShowViewController:(void (^)(UINavigationController* navi, UIViewController* vc, BOOL animated))block {
    self.blockForDidShowViewController = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForAnimationForOperation:(id<UIViewControllerAnimatedTransitioning> (^)(UINavigationController* navi, UINavigationControllerOperation operation, UIViewController* fromVC, UIViewController* toVC))block {
    self.blockForAnimationForOperation = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForInteractionController:(id<UIViewControllerInteractiveTransitioning> (^)(UINavigationController* navi, id<UIViewControllerAnimatedTransitioning> animateionController))block {
    self.blockForInteractionController = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForPreferedInterfaceOrientation:(UIInterfaceOrientation (^)(UINavigationController* navi))block {
    self.blockForPreferedInterfaceOrientation = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSupportedInterfaceOrientation:(NSUInteger (^)(UINavigationController* navi))block {
    self.blockForSupportedInterfaceOrientation = block;
    [self usingBlocks];
    return self;
}

@end
