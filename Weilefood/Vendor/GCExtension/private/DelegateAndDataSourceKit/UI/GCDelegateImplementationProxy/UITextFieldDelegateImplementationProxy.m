//
//  UITextFieldDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextFieldDelegateImplementationProxy.h"
#import "UITextField+GCDelegateBlock.h"

@interface UITextFieldDelegateImplementation : NSObject <UITextFieldDelegate>

@end

@implementation UITextFieldDelegateImplementation

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return textField.blockForShouldBeginEditing(textField);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.blockForDidBeginEditing(textField);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return textField.blockForShouldEndEditing(textField);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.blockForDidEndEditing(textField);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return textField.blockForShouldReplacementString(textField, range, string);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return textField.blockForShouldClear(textField);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return textField.blockForShouldReturn(textField);
}

@end







@implementation UITextFieldDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UITextFieldDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"textFieldShouldBeginEditing:" : @"blockForShouldBeginEditing",
                            @"textFieldDidBeginEditing:" : @"blockForDidBeginEditing",
                            @"textFieldShouldEndEditing:" : @"blockForShouldEndEditing",
                            @"textFieldDidEndEditing:" : @"blockForDidEndEditing",
                            @"textField:shouldChangeCharactersInRange:replacementString:" : @"blockForShouldReplacementString",
                            @"textFieldShouldClear:" : @"blockForShouldClear",
                            @"textFieldShouldReturn:" : @"blockForShouldReturn",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end

