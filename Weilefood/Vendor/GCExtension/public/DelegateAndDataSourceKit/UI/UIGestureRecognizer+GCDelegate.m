//
//  UIGestureRecognizer+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizer+GCDelegate.h"

#import "UIGestureRecognizer+GCDelegateBlock.h"

@implementation UIGestureRecognizer (GCDelegate)

- (instancetype)withBlockForShouldBegin:(BOOL (^)(UIGestureRecognizer* gesture))block {
    self.blockForShouldBegin = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldReceiveTouch:(BOOL (^)(UIGestureRecognizer* gesture, UITouch* touch))block {
    self.blockForShouldReceiveTouch = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldSimultaneous:(BOOL (^)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture))block {
    self.blockForShouldSimultaneous = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldRequireFailureOf:(BOOL (^)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture))block {
    self.blockForShouldRequireFailureOf = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldBeRequireToFailureBy:(BOOL (^)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture))block {
    self.blockForShouldBeRequireToFailureBy = block;
    [self usingBlocks];
    return self;
}

@end
