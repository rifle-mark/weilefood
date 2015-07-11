//
//  NSObject+GCProxyGetter.m
//  GCExtension
//
//  Created by njgarychow on 2/18/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCProxyRegister.h"

#import "GCImplementationProxy.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSObject (GCProxyRegister)

- (void)registerBlockProxyWithClass:(Class)proxyClass {
    static char const NSObjectImplementationProxyKey;
    GCImplementationProxy* proxy = nil;
    proxy = objc_getAssociatedObject(self, &NSObjectImplementationProxyKey);
    if (object_getClass(proxy) != proxyClass) {
        proxy = [[proxyClass alloc] init];
        objc_setAssociatedObject(self, &NSObjectImplementationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        proxy.owner = self;
    }
    if ([self respondsToSelector:@selector(setDelegate:)]) {
        [((id)self) setDelegate:nil];
        [((id)self) setDelegate:(id)proxy];
    }
    if ([self respondsToSelector:@selector(setDataSource:)]) {
        [((id)self) setDataSource:nil];
        [((id)self) setDataSource:(id)proxy];
    }
}

@end
