//
//  GCImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/17/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "GCImplementationProxy.h"

@interface GCImplementationProxy ()

@property (nonatomic, strong) id realObject;

@end

@implementation GCImplementationProxy

+ (Class)realObjectClass {
    NSAssert(NO, @"Override this method");
    return nil;
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    return nil;
}

- (id)init {
    self.realObject = [[[[self class] realObjectClass] alloc] init];
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* selectorString = NSStringFromSelector(aSelector);
    NSString* blockGetterName = [[self class] blockNamesForSelectorString:selectorString];
    if (!blockGetterName) {
        return NO;
    }
    SEL selector = NSSelectorFromString(blockGetterName);
    return !!((id (*)(id, SEL))[self.owner methodForSelector:selector])(self.owner, selector);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realObject];
}

@end
