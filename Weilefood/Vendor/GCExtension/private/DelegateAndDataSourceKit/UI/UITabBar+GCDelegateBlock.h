//
//  UITabBar+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UITabBar (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |tabBar:willBeginCustomizingItems:|
 */
GCBlockProperty void (^blockForWillBeginCustomizingItems)(UITabBar* tabbar, NSArray* items);

/**
 *  equal to -> |tabBar:didBeginCustomizingItems:|
 */
GCBlockProperty void (^blockForDidBeginCustomzingItems)(UITabBar* tabbar, NSArray* items);

/**
 *  equal to -> |tabBar:willEndCustomizingItems:changed:|
 */
GCBlockProperty void (^blockForWillEndCustomizingItems)(UITabBar* tabbar, NSArray* items, BOOL changed);

/**
 *  equal to -> |tabBar:didEndCustomizingItems:changed:|
 */
GCBlockProperty void (^blockForDidEndCustomzingItems)(UITabBar* tabbar, NSArray* items, BOOL changed);

/**
 *  equal to -> |tabBar:didSelectItem:|
 */
GCBlockProperty void (^blockForDidSelectItem)(UITabBar* tabbar, UITabBarItem* item);

@end
