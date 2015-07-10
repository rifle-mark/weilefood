//
//  UITextView+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14/11/14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UITextView (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |textViewShouldBeginEditing:|
 */
GCBlockProperty BOOL (^blockForShouldBeginEditing)(UITextView* textView);

/**
 *  equal to -> |textViewDidBeginEditing:|
 */
GCBlockProperty void (^blockForDidBeginEditing)(UITextView* textView);

/**
 *  equal to -> |textViewShouldEndEditing:|
 */
GCBlockProperty BOOL (^blockForShouldEndEditing)(UITextView* textView);

/**
 *  equal to -> |textViewDidEndEditing:|
 */
GCBlockProperty void (^blockForDidEndEditing)(UITextView* textView);

/**
 *  equal to -> |textView:shouldChangeTextInRange:replacementText:|
 */
GCBlockProperty BOOL (^blockForShouldChangeText)(UITextView* textView, NSRange range, NSString* text);

/**
 *  equal to -> |textViewDidChange:|
 */
GCBlockProperty void (^blockForDidChanged)(UITextView* textView);

/**
 *  equal to -> |textViewDidChangeSelection:|
 */
GCBlockProperty void (^blockForDidChangeSelection)(UITextView* textView);

/**
 *  equal to -> |textView:shouldInteractWithTextAttachment:inRange:|
 */
GCBlockProperty BOOL (^blockForShouldInteractAttachment)(UITextView* textView, NSTextAttachment* attachment, NSRange range);

/**
 *  equal to -> |textView:shouldInteractWithURL:inRange:|
 */
GCBlockProperty BOOL (^blockForShouldInteractURL)(UITextView* textView, NSURL* url, NSRange range);

@end
