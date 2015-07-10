//
//  UITextField+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UITextField (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |textFieldShouldBeginEditing:|
 */
GCBlockProperty BOOL (^blockForShouldBeginEditing)(UITextField* textField);

/**
 *  equal to -> |textFieldDidBeginEditing:|
 */
GCBlockProperty void (^blockForDidBeginEditing)(UITextField* textField);

/**
 *  equal to -> |textFieldShouldEndEditing:|
 */
GCBlockProperty BOOL (^blockForShouldEndEditing)(UITextField* textField);

/**
 *  equal to -> |textFieldDidEndEditing:|
 */
GCBlockProperty void (^blockForDidEndEditing)(UITextField* textField);

/**
 *  equal to -> |textField:shouldChangeCharactersInRange:replacementString:|
 */
GCBlockProperty BOOL (^blockForShouldReplacementString)(UITextField* textField, NSRange range, NSString* replacementString);

/**
 *  equal to -> |textFieldShouldClear:|
 */
GCBlockProperty BOOL (^blockForShouldClear)(UITextField* textField);

/**
 *  equal to -> |textFieldShouldReturn:|
 */
GCBlockProperty BOOL (^blockForShouldReturn)(UITextField* textField);

@end
