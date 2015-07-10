//
//  UITextView+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (GCDelegate)

/**
 *  equal to -> |textViewShouldBeginEditing:|
 */
- (instancetype)withBlockForShouldBeginEditing:(BOOL (^)(UITextView* view))block;

/**
 *  equal to -> |textViewDidBeginEditing:|
 */
- (instancetype)withBlockForDidBeginEditing:(void (^)(UITextView* view))block;

/**
 *  equal to -> |textViewShouldEndEditing:|
 */
- (instancetype)withBlockForShouldEndEditing:(BOOL (^)(UITextView* view))block;

/**
 *  equal to -> |textViewDidEndEditing:|
 */
- (instancetype)withBlockForDidEndEditing:(void (^)(UITextView* view))block;

/**
 *  equal to -> |textView:shouldChangeTextInRange:replacementText:|
 */
- (instancetype)withBlockForShouldChangeText:(BOOL (^)(UITextView* view, NSRange range, NSString* text))block;

/**
 *  equal to -> |textViewDidChange:|
 */
- (instancetype)withBlockForDidChanged:(void (^)(UITextView* view))block;

/**
 *  equal to -> |textViewDidChangeSelection:|
 */
- (instancetype)withBlockForDidChangeSelection:(void (^)(UITextView* view))block;

/**
 *  equal to -> |textView:shouldInteractWithTextAttachment:inRange:|
 */
- (instancetype)withBlockForShouldInteractAttachment:(BOOL (^)(UITextView* view, NSTextAttachment* attachment, NSRange range))block;

/**
 *  equal to -> |textView:shouldInteractWithURL:inRange:|
 */
- (instancetype)withBlockForShouldInteractURL:(BOOL (^)(UITextView* view, NSURL* url, NSRange range))block;

@end
