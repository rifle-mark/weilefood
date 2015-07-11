//
//  UITextView+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14/11/14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextView+GCDelegateBlock.h"
#import "NSObject+GCAccessor.h"
#import "UITextViewDelegateImplementationProxy.h"

#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"



@implementation UITextView (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UITextViewDelegateImplementationProxy class]];
}

+ (void)load {
    [self extensionAccessorGenerator];
}

@dynamic blockForShouldBeginEditing;
@dynamic blockForDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForDidEndEditing;
@dynamic blockForShouldChangeText;
@dynamic blockForDidChanged;
@dynamic blockForDidChangeSelection;
@dynamic blockForShouldInteractAttachment;
@dynamic blockForShouldInteractURL;

@end
