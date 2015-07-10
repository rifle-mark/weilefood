//
//  UIPopoverController+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPopoverController+GCDelegate.h"
#import "UIPopoverController+GCDelegateBlock.h"

@implementation UIPopoverController (GCDelegate)

- (instancetype)withBlockForWillRepositionToRectInView:(void (^)(UIPopoverController* popover, CGRect* rect, UIView** view))block {
    self.blockForWillRepositionToRectInView = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldDismiss:(BOOL (^)(UIPopoverController* popover))block {
    self.blockForShouldDismiss = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidDismiss:(void (^)(UIPopoverController* popover))block {
    self.blockForDidDismiss = block;
    [self usingBlocks];
    return self;
}

@end
