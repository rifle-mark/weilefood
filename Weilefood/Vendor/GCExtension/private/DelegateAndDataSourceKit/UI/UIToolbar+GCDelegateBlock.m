//
//  UIToolbar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIToolbar+GCDelegateBlock.h"
#import "UIToolbarDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"


@implementation UIToolbar (GCDelegateBlock)


- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIToolbarDelegateImplementationProxy class]];
}

@dynamic blockForPosition;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
