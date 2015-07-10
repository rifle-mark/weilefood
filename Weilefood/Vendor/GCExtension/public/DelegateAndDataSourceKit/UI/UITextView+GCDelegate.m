//
//  UITextView+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITextView+GCDelegate.h"
#import "UITextView+GCDelegateBlock.h"

@implementation UITextView (GCDelegate)

- (instancetype)withBlockForShouldBeginEditing:(BOOL (^)(UITextView* view))block {
    self.blockForShouldBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidBeginEditing:(void (^)(UITextView* view))block {
    self.blockForDidBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldEndEditing:(BOOL (^)(UITextView* view))block {
    self.blockForShouldEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndEditing:(void (^)(UITextView* view))block {
    self.blockForDidEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldChangeText:(BOOL (^)(UITextView* view, NSRange range, NSString* text))block {
    self.blockForShouldChangeText = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidChanged:(void (^)(UITextView* view))block {
    self.blockForDidChanged = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidChangeSelection:(void (^)(UITextView* view))block {
    self.blockForDidChangeSelection = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldInteractAttachment:(BOOL (^)(UITextView* view, NSTextAttachment* attachment, NSRange range))block {
    self.blockForShouldInteractAttachment = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldInteractURL:(BOOL (^)(UITextView* view, NSURL* url, NSRange range))block {
    self.blockForShouldInteractURL = block;
    [self usingBlocks];
    return self;
}

@end
