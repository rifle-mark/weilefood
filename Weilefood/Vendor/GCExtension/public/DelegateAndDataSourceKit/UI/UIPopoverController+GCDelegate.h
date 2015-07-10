//
//  UIPopoverController+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPopoverController (GCDelegate)

/**
 *  equal to -> |popoverController:willRepositionPopoverToRect:inView:|
 */
- (instancetype)withBlockForWillRepositionToRectInView:(void (^)(UIPopoverController* popover, CGRect* rect, UIView** view))block;

/**
 *  equal to -> |popoverControllerShouldDismissPopover:|
 */
- (instancetype)withBlockForShouldDismiss:(BOOL (^)(UIPopoverController* popover))block;

/**
 *  equal to -> |popoverControllerDidDismissPopover:|
 */
- (instancetype)withBlockForDidDismiss:(void (^)(UIPopoverController* popover))block;

@end
