//
//  UIPopoverController+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIPopoverController (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |popoverController:willRepositionPopoverToRect:inView:|
 */
GCBlockProperty void (^blockForWillRepositionToRectInView)(UIPopoverController* popover, CGRect* rect, UIView** view);

/**
 *  equal to -> |popoverControllerShouldDismissPopover:|
 */
GCBlockProperty BOOL (^blockForShouldDismiss)(UIPopoverController* popover);

/**
 *  equal to -> |popoverControllerDidDismissPopover:|
 */
GCBlockProperty void (^blockForDidDismiss)(UIPopoverController* popover);

@end
