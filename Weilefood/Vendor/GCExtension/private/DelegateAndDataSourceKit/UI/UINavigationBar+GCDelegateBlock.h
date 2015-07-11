//
//  UINavigationBar+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UINavigationBar (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |navigationBar:shouldPushItem:|
 */
GCBlockProperty BOOL (^blockForShouldPushItem)(UINavigationBar* bar, UINavigationItem* item);

/**
 *  equal to -> |navigationBar:didPushItem:|
 */
GCBlockProperty void (^blockForDidPushItem)(UINavigationBar* bar, UINavigationItem* item);

/**
 *  equal to -> |navigationBar:shouldPopItem:|
 */
GCBlockProperty BOOL (^blockForShouldPopItem)(UINavigationBar* bar, UINavigationItem* item);

/**
 *  equal to -> |navigationBar:didPopItem:|
 */
GCBlockProperty void (^blockForDidPopItem)(UINavigationBar* bar, UINavigationItem* item);

/**
 *  equal to -> |positionForBar:|
 */
GCBlockProperty UIBarPosition (^blockForPosition)(UINavigationBar* bar);

@end
