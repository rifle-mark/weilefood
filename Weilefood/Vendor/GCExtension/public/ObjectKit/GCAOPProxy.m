//
//  GCAOPProxy.m
//  GCExtension
//
//  Created by njgarychow on 14-9-8.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "GCAOPProxy.h"

#import "GCMacro.h"



@interface GCAOPProxyInterceptorStore : NSObject

- (NSArray *)getInterceptBlocksWithSelector:(SEL)selector onMode:(GCAOPInterceptMode)mode;

- (void)addInterceptBlock:(GCAOPInterceptorBlock)interceptorBlock
                 selector:(SEL)selector
                   onMode:(GCAOPInterceptMode)mode;

@end


@implementation GCAOPProxyInterceptorStore {
    NSMutableDictionary* _interceptors;
}

- (NSString *)_identifierWithSelector:(SEL)selector
                               onMode:(GCAOPInterceptMode)mode {
    
    return [NSString stringWithFormat:@"%@_%@", NSStringFromSelector(selector), @(mode)];
}

- (NSMutableArray *)_interceptorBlocksWithSelector:(SEL)selector
                                            onMode:(GCAOPInterceptMode)mode {
    
    NSString* identifier = [self _identifierWithSelector:selector onMode:mode];
    if (!_interceptors) {
        _interceptors = [NSMutableDictionary dictionary];
    }
    NSMutableArray* wrappers = _interceptors[identifier];
    if (!wrappers) {
        wrappers = [NSMutableArray array];
        _interceptors[identifier] = wrappers;
    }
    return wrappers;
}

- (NSArray *)getInterceptBlocksWithSelector:(SEL)selector
                                     onMode:(GCAOPInterceptMode)mode {
    
    return [[self _interceptorBlocksWithSelector:selector onMode:mode] copy];
}

- (void)addInterceptBlock:(GCAOPInterceptorBlock)interceptorBlock
                 selector:(SEL)selector
                   onMode:(GCAOPInterceptMode)mode {
    
    NSMutableArray* interceptors = [self _interceptorBlocksWithSelector:selector onMode:mode];
    if (mode == GCAOPInterceptModeInstead) {
        [interceptors removeAllObjects];
    }
    [interceptors addObject:interceptorBlock];
}

@end
















@interface GCAOPProxy ()

@property (nonatomic, strong) id realObject;
@property (nonatomic, strong) GCAOPProxyInterceptorStore* store;

@end

@implementation GCAOPProxy

+ (instancetype)createAOPProxyObjectWithClass:(Class)cls {
    id object = [[cls alloc] init];
    return [self createAOPProxyObjectWithObject:object];
}

+ (instancetype)createAOPProxyObjectWithObject:(id)object {
    GCAOPProxy* proxyObject = [[self alloc] init];
    proxyObject.realObject = object;
    return proxyObject;
}

- (instancetype)init {
    _store = [[GCAOPProxyInterceptorStore alloc] init];
    return self;
}

- (void)interceptSelector:(SEL)selector
                   onMode:(GCAOPInterceptMode)mode
               usingBlock:(GCAOPInterceptorBlock)interceptor {
    NSParameterAssert(selector != nil);
    NSParameterAssert(interceptor != nil);
    
    [_store addInterceptBlock:interceptor selector:selector onMode:mode];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    
    //  before
    [[_store
      getInterceptBlocksWithSelector:selector
      onMode:GCAOPInterceptModeBefore]
     enumerateObjectsUsingBlock:^(GCAOPInterceptorBlock block, NSUInteger idx, BOOL *stop) {
        GCBlockInvoke(block);
    }];
    
    //  instead or origin invocation
    NSArray* interceptorsInstead = [_store
                                    getInterceptBlocksWithSelector:selector
                                    onMode:GCAOPInterceptModeInstead];
    if ([interceptorsInstead count] > 0) {
        GCAOPInterceptorBlock block = [interceptorsInstead lastObject];
        GCBlockInvoke(block);
    }
    else {
        [invocation setTarget:_realObject];
        [invocation invoke];
    }
    
    //  after
    [[_store
      getInterceptBlocksWithSelector:selector
      onMode:GCAOPInterceptModeAfter]
     enumerateObjectsUsingBlock:^(GCAOPInterceptorBlock block, NSUInteger idx, BOOL *stop) {
         GCBlockInvoke(block);
     }];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}


@end
