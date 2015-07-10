//
//  UITabBarController+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (GCDelegate)

/**
 *  equal to -> |tabBarController:shouldSelectViewController:|
 */
- (instancetype)withBlockForShouldSelectViewController:(BOOL (^)(UITabBarController* tab, UIViewController* viewController))block;

/**
 *  equal to -> |tabBarController:didSelectViewController:|
 */
- (instancetype)withBlockForDidSelectViewController:(void (^)(UITabBarController* tab, UIViewController* viewController))block;

/**
 *  equal to -> |tabBarController:willBeginCustomizingViewControllers:|
 */
- (instancetype)withBlockForWillBeginCustomizingViewControllers:(void (^)(UITabBarController* tab, NSArray* viewControllers))block;

/**
 *  equal to -> |tabBarController:willEndCustomizingViewControllers:changed:|
 */
- (instancetype)withBlockForWillEndCustomizingViewControllersChanged:(void (^)(UITabBarController* tab, NSArray* viewControllers, BOOL changed))block;

/**
 *  equal to -> |tabBarController:didEndCustomizingViewControllers:changed:|
 */
- (instancetype)withBlockForDidEndCustomizingViewControllersChanged:(void (^)(UITabBarController* tab, NSArray* viewControllrs, BOOL changed))block;
/**
 *  equal to -> |tabBarControllerSupportedInterfaceOrientations:|
 */
- (instancetype)withBlockForSupportedInterfaceOrientations:(NSUInteger (^)(UITabBarController* tab))block;

/**
 *  equal to -> |tabBarControllerPreferredInterfaceOrientationForPresentation:|
 */
- (instancetype)withBlockForPreferredInterfaceOrientation:(UIInterfaceOrientation (^)(UITabBarController* tab))block;

/**
 *  equal to -> |tabBarController:animationControllerForTransitionFromViewController:toViewController:|
 */
- (instancetype)withBlockForAnimationForTransitionController:(id<UIViewControllerAnimatedTransitioning> (^)(UITabBarController* tab, UIViewController* fromVC, UIViewController* toVC))block;

/**
 *  equal to -> |tabBarController:interactionControllerForAnimationController:|
 */
- (instancetype)withBlockForInteractiveForAnimationController:(id<UIViewControllerInteractiveTransitioning> (^)(UITabBarController* tab, id<UIViewControllerAnimatedTransitioning> viewController))block;

@end
