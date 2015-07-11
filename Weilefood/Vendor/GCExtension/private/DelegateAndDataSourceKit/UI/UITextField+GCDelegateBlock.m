//
//  UITextField+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextField+GCDelegateBlock.h"
#import "NSObject+GCAccessor.h"
#import "UITextFieldDelegateImplementationProxy.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UITextField (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UITextFieldDelegateImplementationProxy class]];
}


@dynamic blockForShouldBeginEditing;
@dynamic blockForDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForDidEndEditing;
@dynamic blockForShouldReplacementString;
@dynamic blockForShouldClear;
@dynamic blockForShouldReturn;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
