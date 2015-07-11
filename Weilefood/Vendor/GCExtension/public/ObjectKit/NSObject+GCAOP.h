//
//  NSObject+GCAOP.h
//  GCExtension
//
//  Created by njgarychow on 14-9-9.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GCAOPProxy.h"

@interface NSObject (GCAOP)

+ (instancetype)AOPObject;
- (instancetype)AOPObject;

- (void)interceptSelector:(SEL)selector
                   onMode:(GCAOPInterceptMode)mode
               usingBlock:(GCAOPInterceptorBlock)interceptor;

@end
