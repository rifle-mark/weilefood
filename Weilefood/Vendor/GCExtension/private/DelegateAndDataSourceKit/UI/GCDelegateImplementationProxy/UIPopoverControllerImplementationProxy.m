//
//  UIPopoverControllerImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPopoverControllerImplementationProxy.h"
#import "UIPopoverController+GCDelegateBlock.h"

@interface UIPopoverControllerImplementation : NSObject <UIPopoverControllerDelegate>

@end

@implementation UIPopoverControllerImplementation

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return popoverController.blockForShouldDismiss(popoverController);
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    popoverController.blockForDidDismiss(popoverController);
}

- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view {
    popoverController.blockForWillRepositionToRectInView(popoverController, rect, view);
}

@end







@implementation UIPopoverControllerImplementationProxy

+ (Class)realObjectClass {
    return [UIPopoverControllerImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"popoverController:willRepositionPopoverToRect:inView:" : @"blockForWillRepositionToRectInView",
                            @"popoverControllerShouldDismissPopover:" : @"blockForShouldDismiss",
                            @"popoverControllerDidDismissPopover:" : @"blockForDidDismiss",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
