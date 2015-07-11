//
//  UINavigationBar+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (GCDelegate)

/**
 *  equal to -> |navigationBar:shouldPushItem:|
 */
- (instancetype)withBlockForShouldPushItem:(BOOL (^)(UINavigationBar* bar, UINavigationItem* item))block;

/**
 *  equal to -> |navigationBar:didPushItem:|
 */
- (instancetype)withBlockForDidPushItem:(void (^)(UINavigationBar* bar, UINavigationItem* item))block;

/**
 *  equal to -> |navigationBar:shouldPopItem:|
 */
- (instancetype)withBlockForShouldPopItem:(BOOL (^)(UINavigationBar* bar, UINavigationItem* item))block;

/**
 *  equal to -> |navigationBar:didPopItem:|
 */
- (instancetype)withBlockForDidPopItem:(void (^)(UINavigationBar* bar, UINavigationItem* item))block;

/**
 *  equal to -> |positionForBar:|
 */
- (instancetype)withBlockForPosition:(UIBarPosition (^)(UINavigationBar* bar))block;

@end
