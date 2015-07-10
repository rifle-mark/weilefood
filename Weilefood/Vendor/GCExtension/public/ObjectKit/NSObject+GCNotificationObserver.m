//
//  NSObject+GCNotificationObserver.m
//  GCExtension
//
//  Created by njgarychow on 14-8-4.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCNotificationObserver.h"

#import <objc/runtime.h>


@interface GCNotificationObserverWrapper : NSObject {
    __weak id _object;
}

@property (nonatomic, readonly) id object;
@property (nonatomic, readonly) GCNotificationObserverBlock handleBlock;

- (instancetype)initWithObserverForNotificationName:(NSString *)name
                                             object:(id)object
                                       handlerBlock:(GCNotificationObserverBlock)block;

@end

@implementation GCNotificationObserverWrapper

- (instancetype)initWithObserverForNotificationName:(NSString *)name
                                             object:(id)object
                                       handlerBlock:(GCNotificationObserverBlock)block {
    if (self = [self init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_observerHandlerAction:)
                                                     name:name
                                                   object:object];
        _handleBlock = [block copy];
        _object = object;
    }
    return self;
}

- (void)_observerHandlerAction:(NSNotification *)noti {
    _handleBlock(noti);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end




@implementation NSObject (GCNotificationObserver)


#pragma mark - class public method

+ (void)addObserverForNotificationName:(NSString *)name
                                object:(id)anObject
                            usingBlock:(GCNotificationObserverBlock)block {
    NSParameterAssert(name);
    NSParameterAssert(block);
    
    GCNotificationObserverWrapper* wrapper = [[GCNotificationObserverWrapper alloc] initWithObserverForNotificationName:name object:anObject handlerBlock:block];
    
    [[self _observerWrappersForNotificationName:name] addObject:wrapper];
}
+ (void)addObserverForNotificationName:(NSString *)name usingBlock:(GCNotificationObserverBlock)block {
    [self addObserverForNotificationName:name object:nil usingBlock:block];
}
+ (void)removeObserverForNotificationName:(NSString *)name {
    [self removeObserverForNotificationName:name object:nil];
}
+ (void)removeObserverForNotificationName:(NSString *)name object:(id)anObject {
    NSParameterAssert(name);
    
    NSMutableArray* observerWrappers = [self _observerWrappersForNotificationName:name];
    [self _removeWrappersUsingObject:anObject fromAllWrappers:observerWrappers];
}


#pragma mark - class private method
+ (NSMutableArray *)_observerWrappersForNotificationName:(NSString *)name {
    return [self _observerWrappersForNotificationName:name object:self];
}



+ (void)_removeWrappersUsingObject:(id)object fromAllWrappers:(NSMutableArray *)observerWrappers {
    if (object) {
        NSMutableArray* wrappers = [NSMutableArray new];
        [observerWrappers enumerateObjectsUsingBlock:^(GCNotificationObserverWrapper* wrapper, NSUInteger idx, BOOL *stop) {
            if (wrapper.object == object) {
                [wrappers addObject:wrapper];
            }
        }];
        [observerWrappers removeObjectsInArray:wrappers];
    }
    else {
        [observerWrappers removeAllObjects];
    }
}
+ (NSMutableArray *)_observerWrappersForNotificationName:(NSString *)name object:(id)object {
    static char const observersMapKey;
    NSMutableDictionary* observersMap = objc_getAssociatedObject(object, &observersMapKey);
    if (!observersMap) {
        observersMap = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(object, &observersMapKey, observersMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray* observersArr = observersMap[name];
    if (!observersArr) {
        observersArr = [NSMutableArray array];
        observersMap[name] = observersArr;
    }
    
    return observersArr;
}



#pragma mark - instance public method
- (void)addObserverForNotificationName:(NSString *)name
                                object:(id)anObject
                            usingBlock:(GCNotificationObserverBlock)block {
    NSParameterAssert(name);
    NSParameterAssert(block);
    
    GCNotificationObserverWrapper* wrapper = [[GCNotificationObserverWrapper alloc] initWithObserverForNotificationName:name object:anObject handlerBlock:block];
    
    [[self _observerWrappersForNotificationName:name] addObject:wrapper];
}
- (void)addObserverForNotificationName:(NSString *)name usingBlock:(GCNotificationObserverBlock)block {
    [self addObserverForNotificationName:name object:nil usingBlock:block];
}
- (void)removeObserverForNotificationName:(NSString *)name {
    [self removeObserverForNotificationName:name object:nil];
}
- (void)removeObserverForNotificationName:(NSString *)name object:(id)anObject {
    NSParameterAssert(name);
    
    NSMutableArray* observerWrappers = [self _observerWrappersForNotificationName:name];
    [[self class] _removeWrappersUsingObject:anObject fromAllWrappers:observerWrappers];
}


#pragma mark - instance private method
- (NSMutableArray *)_observerWrappersForNotificationName:(NSString *)name {
    return [[self class] _observerWrappersForNotificationName:name object:self];
}

@end
