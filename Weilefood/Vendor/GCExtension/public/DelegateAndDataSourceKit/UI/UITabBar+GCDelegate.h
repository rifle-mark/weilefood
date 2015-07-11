//
//  UITabBar+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (GCDelegate)

/**
 *  equal to -> |tabBar:willBeginCustomizingItems:|
 */
- (instancetype)withBlockForWillBeginCustomizingItems:(void (^)(UITabBar* tabbar, NSArray* items))block;

/**
 *  equal to -> |tabBar:didBeginCustomizingItems:|
 */
- (instancetype)withBlockForDidBeginCustomzingItems:(void (^)(UITabBar* tabbar, NSArray* items))block;

/**
 *  equal to -> |tabBar:willEndCustomizingItems:changed:|
 */
- (instancetype)withBlockForWillEndCustomizingItems:(void (^)(UITabBar* tabbar, NSArray* items, BOOL changed))block;

/**
 *  equal to -> |tabBar:didEndCustomizingItems:changed:|
 */
- (instancetype)withBlockForDidEndCustomzingItems:(void (^)(UITabBar* tabbar, NSArray* items, BOOL changed))block;

/**
 *  equal to -> |tabBar:didSelectItem:|
 */
- (instancetype)withBlockForDidSelectItem:(void (^)(UITabBar* tabbar, UITabBarItem* item))block;

@end
