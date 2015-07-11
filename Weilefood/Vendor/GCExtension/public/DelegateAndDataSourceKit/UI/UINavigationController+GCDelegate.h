//
//  UINavigationController+GCDelegate.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GCDelegate)

/**
 *  equal to -> |navigationController:willShowViewController:animated:|
 */
- (instancetype)withBlockForWillShowViewController:(void (^)(UINavigationController* navi, UIViewController* vc, BOOL animated))block;

/**
 *  equal to -> |navigationController:didShowViewController:animated:|
 */
- (instancetype)withBlockForDidShowViewController:(void (^)(UINavigationController* navi, UIViewController* vc, BOOL animated))block;

/**
 *  equal to -> |navigationController:animationControllerForOperation:fromViewController:toViewController:|
 */
- (instancetype)withBlockForAnimationForOperation:(id<UIViewControllerAnimatedTransitioning> (^)(UINavigationController* navi, UINavigationControllerOperation operation, UIViewController* fromVC, UIViewController* toVC))block;

/**
 *  equal to -> |navigationController:interactionControllerForAnimationController:|
 */
- (instancetype)withBlockForInteractionController:(id<UIViewControllerInteractiveTransitioning> (^)(UINavigationController* navi, id<UIViewControllerAnimatedTransitioning> animateionController))block;

/**
 *  equal to -> |navigationControllerPreferredInterfaceOrientationForPresentation:|
 */
- (instancetype)withBlockForPreferedInterfaceOrientation:(UIInterfaceOrientation (^)(UINavigationController* navi))block;

/**
 *  equal to -> |navigationControllerSupportedInterfaceOrientations:|
 */
- (instancetype)withBlockForSupportedInterfaceOrientation:(NSUInteger (^)(UINavigationController* navi))block;

@end
