//
//  UIWebView+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UIWebView+GCDelegateBlock.h"

#import "NSObject+GCAccessor.h"
#import "UIWebViewDelegateImplementationProxy.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UIWebView (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIWebViewDelegateImplementationProxy class]];
}


@dynamic blockForShouldStartLoadRequest;
@dynamic blockForDidStartLoad;
@dynamic blockForDidFinishLoad;
@dynamic blockForDidFailLoad;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
