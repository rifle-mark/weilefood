//
//  UIControl+GCEventBlock.m
//  GCExtension
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIControl+GCEvent.h"

#import <objc/runtime.h>


@interface UIControlEventBlockWrapper : NSObject

@property (nonatomic, weak) UIControl* control;
@property (nonatomic, assign) UIControlEvents events;
@property (nonatomic, copy) GCControlEventActionBlock eventActionBlock;

- (instancetype)initWithControl:(UIControl *)control
                  controlEvents:(UIControlEvents)event
               eventActionBlock:(GCControlEventActionBlock)eventActionBlock;

@end

@implementation UIControlEventBlockWrapper

- (instancetype)initWithControl:(UIControl *)control
                  controlEvents:(UIControlEvents)event
               eventActionBlock:(GCControlEventActionBlock)eventActionBlock {
    if (self = [self init]) {
        [control addTarget:self action:@selector(_executeActionBlockByControl:touches:) forControlEvents:event];
        _control = control;
        _events = event;
        _eventActionBlock = eventActionBlock;
    }
    return self;
}

- (void)_executeActionBlockByControl:(UIControl *)control touches:(id/*UITouchesEvent*/)touches {
    id allTouches = nil;
    if ([touches respondsToSelector:@selector(allTouches)]) {
        allTouches = [touches allTouches];
    }
    _eventActionBlock(control, allTouches);
}

- (void)dealloc {
    [_control removeTarget:self
                    action:@selector(_executeActionBlockByControl:touches:)
          forControlEvents:_events];
}

@end






@implementation UIControl (GCEvent)

- (void)addControlEvents:(UIControlEvents)event action:(GCControlEventActionBlock)action {
    NSParameterAssert(action);
    
    /**
     *  |wrapper| created by using class method will release delay at the end of the
     *  method which invoke the |removeAllControlEventsAction:|. why??
     */
    UIControlEventBlockWrapper* wrapper = [[UIControlEventBlockWrapper alloc]
                                           initWithControl:self
                                           controlEvents:event
                                           eventActionBlock:action];
    
    [[self _controlEventsBlockWrappersForControlEvents:event] addObject:wrapper];
}

- (void)removeAllControlEventsAction:(UIControlEvents)event {
    [[self _controlEventsBlockWrappersForControlEvents:event] removeAllObjects];
}


#pragma mark - instance private method
- (NSMutableArray *)_controlEventsBlockWrappersForControlEvents:(UIControlEvents)event {
    static char const wrappersDicKey;
    NSMutableDictionary* wrapperDic = objc_getAssociatedObject(self, &wrappersDicKey);
    if (!wrapperDic) {
        wrapperDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &wrappersDicKey, wrapperDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray* wrapperArr = wrapperDic[@(event)];
    if (!wrapperArr) {
        wrapperArr = [NSMutableArray array];
        wrapperDic[@(event)] = wrapperArr;
    }
    
    return wrapperArr;
}


@end
