//
//  UITabBarController+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UITabBarController (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |tabBarController:shouldSelectViewController:|
 */
GCBlockProperty BOOL (^blockForShouldSelectViewController)(UITabBarController* tab, UIViewController* viewController);

/**
 *  equal to -> |tabBarController:didSelectViewController:|
 */
GCBlockProperty void (^blockForDidSelectViewController)(UITabBarController* tab, UIViewController* viewController);

/**
 *  equal to -> |tabBarController:willBeginCustomizingViewControllers:|
 */
GCBlockProperty void (^blockForWillBeginCustomizingViewControllers)(UITabBarController* tab, NSArray* viewControllers);

/**
 *  equal to -> |tabBarController:willEndCustomizingViewControllers:changed:|
 */
GCBlockProperty void (^blockForWillEndCustomizingViewControllersChanged)(UITabBarController* tab, NSArray* viewControllers, BOOL changed);

/**
 *  equal to -> |tabBarController:didEndCustomizingViewControllers:changed:|
 */
GCBlockProperty void (^blockForDidEndCustomizingViewControllersChanged)(UITabBarController* tab, NSArray* viewControllrs, BOOL changed);

/**
 *  equal to -> |tabBarControllerSupportedInterfaceOrientations:|
 */
GCBlockProperty NSUInteger (^blockForSupportedInterfaceOrientations)(UITabBarController* tab);

/**
 *  equal to -> |tabBarControllerPreferredInterfaceOrientationForPresentation:|
 */
GCBlockProperty UIInterfaceOrientation (^blockForPreferredInterfaceOrientation)(UITabBarController* tab);

/**
 *  equal to -> |tabBarController:animationControllerForTransitionFromViewController:toViewController:|
 */
GCBlockProperty id<UIViewControllerAnimatedTransitioning> (^blockForAnimationForTransitionController)(UITabBarController* tab, UIViewController* fromVC, UIViewController* toVC);

/**
 *  equal to -> |tabBarController:interactionControllerForAnimationController:|
 */
GCBlockProperty id<UIViewControllerInteractiveTransitioning> (^blockForInteractiveForAnimationController)(UITabBarController* tab, id<UIViewControllerAnimatedTransitioning> viewController);

@end
