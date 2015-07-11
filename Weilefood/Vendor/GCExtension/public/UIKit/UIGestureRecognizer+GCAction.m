//
//  UIGestureRecognizer+GCActionBlock.m
//  GCExtension
//
//  Created by njgarychow on 14-8-5.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizer+GCAction.h"

#import <objc/runtime.h>


@interface GCGestureActionBlockWrapper : NSObject

@property (nonatomic, strong, readonly) GCGestureActionBlock actionBlock;

- (instancetype)initWithGestureRecognizer:(UIGestureRecognizer *)gesture
                              actionBlock:(GCGestureActionBlock)actionBlock;

@end


@implementation GCGestureActionBlockWrapper

- (instancetype)initWithGestureRecognizer:(UIGestureRecognizer *)gesture
                              actionBlock:(GCGestureActionBlock)actionBlock {
    if (self = [self init]) {
        [gesture addTarget:self action:@selector(_gestureSelector:)];
        _actionBlock = actionBlock;
    }
    return self;
}

- (void)_gestureSelector:(id)sender {
    _actionBlock(sender);
}

@end
















@implementation UIGestureRecognizer (GCAction)

- (instancetype)initWithActionBlock:(GCGestureActionBlock)actionBlock {
    if (self = [self init]) {
        [self addActionBlock:actionBlock];
    }
    return self;
}

- (void)addActionBlock:(GCGestureActionBlock)actionBlock {
    NSParameterAssert(actionBlock);
    
    GCGestureActionBlockWrapper* wrapper = [[GCGestureActionBlockWrapper alloc]
                                            initWithGestureRecognizer:self
                                            actionBlock:actionBlock];
    [[self _actionBlocksWrappers] addObject:wrapper];
}
- (void)removeAllActionBlocks {
    [[self _actionBlocksWrappers] removeAllObjects];
}


#pragma mark - instance private method
- (NSMutableArray *)_actionBlocksWrappers {
    static char const actionBlockWrappersKey;
    NSMutableArray* wrappers = objc_getAssociatedObject(self, &actionBlockWrappersKey);
    if (!wrappers) {
        wrappers = [NSMutableArray array];
        objc_setAssociatedObject(self, &actionBlockWrappersKey, wrappers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return wrappers;
}


@end
