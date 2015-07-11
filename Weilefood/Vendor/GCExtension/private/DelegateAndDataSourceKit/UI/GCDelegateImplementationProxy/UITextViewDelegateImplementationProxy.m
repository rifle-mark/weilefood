//
//  UITextViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14/11/14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextViewDelegateImplementationProxy.h"
#import "UITextView+GCDelegateBlock.h"



@interface UITextViewDelegateImplementation : UIScrollViewDelegateImplementation <UITextViewDelegate>


@end

@implementation UITextViewDelegateImplementation

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return textView.blockForShouldBeginEditing(textView);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.blockForDidBeginEditing(textView);
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return textView.blockForShouldEndEditing(textView);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.blockForDidEndEditing(textView);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.blockForShouldChangeText(textView, range, text);
}

- (void)textViewDidChange:(UITextView *)textView {
    textView.blockForDidChanged(textView);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    textView.blockForDidChangeSelection(textView);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    return textView.blockForShouldInteractAttachment(textView, textAttachment, characterRange);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    return textView.blockForShouldInteractURL(textView, URL, characterRange);
}

@end



@implementation UITextViewDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UITextViewDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"textViewShouldBeginEditing:" : @"blockForShouldBeginEditing",
                            @"textViewDidBeginEditing:" : @"blockForDidBeginEditing",
                            @"textViewShouldEndEditing:" : @"blockForShouldEndEditing",
                            @"textViewDidEndEditing:" : @"blockForDidEndEditing",
                            @"textView:shouldChangeTextInRange:replacementText:" : @"blockForShouldChangeText",
                            @"textViewDidChange:" : @"blockForDidChanged",
                            @"textViewDidChangeSelection:" : @"blockForDidChangeSelection",
                            @"textView:shouldInteractWithTextAttachment:inRange:" : @"blockForShouldInteractAttachment",
                            @"textView:shouldInteractWithURL:inRange:" : @"blockForShouldInteractURL",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
