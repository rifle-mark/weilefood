//
//  UINavigationControllerDelegateImplementionProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UINavigationControllerDelegateImplementionProxy.h"

#import "UINavigationController+GCDelegateBlock.h"


@implementation UINavigationControllerDelegateImplementation

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.blockForWillShowViewController(navigationController, viewController, animated);
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.blockForDidShowViewController(navigationController, viewController, animated);
}

- (NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    return navigationController.blockForSupportedInterfaceOrientation(navigationController);
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
    return navigationController.blockForPreferedInterfaceOrientation(navigationController);
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return navigationController.blockForInteractionController(navigationController, animationController);
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    return navigationController.blockForAnimationForOperation(navigationController, operation, fromVC, toVC);
}

@end







@implementation UINavigationControllerDelegateImplementionProxy

+ (Class)realObjectClass {
    return [UINavigationControllerDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"navigationController:willShowViewController:animated:" : @"blockForWillShowViewController",
                            @"navigationController:didShowViewController:animated:" : @"blockForDidShowViewController",
                            @"navigationController:animationControllerForOperation:fromViewController:toViewController:" : @"blockForAnimationForOperation",
                            @"navigationController:interactionControllerForAnimationController:" : @"blockForInteractionController",
                            @"navigationControllerPreferredInterfaceOrientationForPresentation:" : @"blockForPreferedInterfaceOrientation",
                            @"navigationControllerSupportedInterfaceOrientations:" : @"blockForSupportedInterfaceOrientation",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
