//
//  UINavigationController+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UINavigationController (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |navigationController:willShowViewController:animated:|
 */
GCBlockProperty void (^blockForWillShowViewController)(UINavigationController* navi, UIViewController* vc, BOOL animated);

/**
 *  equal to -> |navigationController:didShowViewController:animated:|
 */
GCBlockProperty void (^blockForDidShowViewController)(UINavigationController* navi, UIViewController* vc, BOOL animated);

/**
 *  equal to -> |navigationController:animationControllerForOperation:fromViewController:toViewController:|
 */
GCBlockProperty id<UIViewControllerAnimatedTransitioning> (^blockForAnimationForOperation)(UINavigationController* navi, UINavigationControllerOperation operation, UIViewController* fromVC, UIViewController* toVC);

/**
 *  equal to -> |navigationController:interactionControllerForAnimationController:|
 */
GCBlockProperty id<UIViewControllerInteractiveTransitioning> (^blockForInteractionController)(UINavigationController* navi, id<UIViewControllerAnimatedTransitioning> animateionController);

/**
 *  equal to -> |navigationControllerPreferredInterfaceOrientationForPresentation:|
 */
GCBlockProperty UIInterfaceOrientation (^blockForPreferedInterfaceOrientation)(UINavigationController* navi);

/**
 *  equal to -> |navigationControllerSupportedInterfaceOrientations:|
 */
GCBlockProperty NSUInteger (^blockForSupportedInterfaceOrientation)(UINavigationController* navi);

@end
