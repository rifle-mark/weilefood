//
//  NSObject+GCAOP.m
//  GCExtension
//
//  Created by njgarychow on 14-9-9.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCAOP.h"

@implementation NSObject (GCAOP)

+ (instancetype)AOPObject {
    return (id)[GCAOPProxy createAOPProxyObjectWithClass:self];
}

- (instancetype)AOPObject {
    return (id)[GCAOPProxy createAOPProxyObjectWithObject:self];
}

- (void)interceptSelector:(SEL)selector onMode:(GCAOPInterceptMode)mode usingBlock:(GCAOPInterceptorBlock)interceptor {
    
    NSAssert(NO, @"This is an aop proxy object's method. Please use AOPObject method to create one");
}

@end
