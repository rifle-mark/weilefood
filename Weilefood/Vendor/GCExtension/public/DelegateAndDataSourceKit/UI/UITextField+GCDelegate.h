//
//  UITextField+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (GCDelegate)

/**
 *  equal to -> |textFieldShouldBeginEditing:|
 */
- (instancetype)withBlockForShouldBeginEditing:(BOOL (^)(UITextField* view))block;

/**
 *  equal to -> |textFieldDidBeginEditing:|
 */
- (instancetype)withBlockForDidBeginEditing:(void (^)(UITextField* view))block;

/**
 *  equal to -> |textFieldShouldEndEditing:|
 */
- (instancetype)withBlockForShouldEndEditing:(BOOL (^)(UITextField* view))block;

/**
 *  equal to -> |textFieldDidEndEditing:|
 */
- (instancetype)withBlockForDidEndEditing:(void (^)(UITextField* view))block;

/**
 *  equal to -> |textField:shouldChangeCharactersInRange:replacementString:|
 */
- (instancetype)withBlockForShouldReplecementString:(BOOL (^)(UITextField* view, NSRange range, NSString* replecementString))block;

/**
 *  equal to -> |textFieldShouldClear:|
 */
- (instancetype)withBlockForShouldClear:(BOOL (^)(UITextField* view))block;

/**
 *  equal to -> |textFieldShouldReturn:|
 */
- (instancetype)withBlockForShouldReturn:(BOOL (^)(UITextField* view))block;

@end
