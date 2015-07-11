//
//  GCAOPProxy.h
//  GCExtension
//
//  Created by njgarychow on 14-9-8.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GCAOPInterceptorBlock)();

typedef NS_ENUM(NSInteger, GCAOPInterceptMode) {
    GCAOPInterceptModeBefore,
    GCAOPInterceptModeAfter,
    GCAOPInterceptModeInstead
};

@interface GCAOPProxy : NSProxy

+ (instancetype)createAOPProxyObjectWithClass:(Class)cls;
+ (instancetype)createAOPProxyObjectWithObject:(id)object;

- (void)interceptSelector:(SEL)selector
                   onMode:(GCAOPInterceptMode)mode
               usingBlock:(GCAOPInterceptorBlock)interceptor;

@end
