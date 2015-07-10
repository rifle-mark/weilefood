//
//  UITabbarControllerDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabbarControllerDelegateImplementationProxy.h"
#import "UITabBarController+GCDelegateBlock.h"


@interface UITabbarControllerDelegateImplementation : NSObject <UITabBarControllerDelegate>
@end

@implementation UITabbarControllerDelegateImplementation

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return tabBarController.blockForShouldSelectViewController(tabBarController, viewController);
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    tabBarController.blockForDidSelectViewController(tabBarController, viewController);
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers {
    tabBarController.blockForWillBeginCustomizingViewControllers(tabBarController, viewControllers);
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    tabBarController.blockForWillEndCustomizingViewControllersChanged(tabBarController, viewControllers, changed);
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    tabBarController.blockForDidEndCustomizingViewControllersChanged(tabBarController, viewControllers, changed);
}

- (NSUInteger)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return tabBarController.blockForSupportedInterfaceOrientations(tabBarController);
}
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController {
    return tabBarController.blockForPreferredInterfaceOrientation(tabBarController);
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return tabBarController.blockForInteractiveForAnimationController(tabBarController, animationController);
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC {
    return tabBarController.blockForAnimationForTransitionController(tabBarController, fromVC, toVC);
}

@end







@implementation UITabbarControllerDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UITabbarControllerDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"tabBarController:shouldSelectViewController:" : @"blockForShouldSelectViewController",
                            @"tabBarController:didSelectViewController:" : @"blockForDidSelectViewController",
                            @"tabBarController:willBeginCustomizingViewControllers:" : @"blockForWillBeginCustomizingViewControllers",
                            @"tabBarController:willEndCustomizingViewControllers:changed:" : @"blockForWillEndCustomizingViewControllersChanged",
                            @"tabBarController:didEndCustomizingViewControllers:changed:" : @"blockForDidEndCustomizingViewControllersChanged",
                            @"blockForSupportedInterfaceOrientations:" : @"blockForSupportedInterfaceOrientations",
                            @"tabBarControllerPreferredInterfaceOrientationForPresentation:" : @"blockForPreferredInterfaceOrientation",
                            @"tabBarController:animationControllerForTransitionFromViewController:toViewController:" : @"blockForAnimationForTransitionController",
                            @"tabBarController:interactionControllerForAnimationController:" : @"blockForInteractiveForAnimationController",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
