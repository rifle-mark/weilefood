//
//  UIGestureRecognizer+GCActionBlock.h
//  GCExtension
//
//  Created by njgarychow on 14-8-5.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GCGestureActionBlock)(UIGestureRecognizer* gesture);

/**
 *  This extension use a block instead of Gesture's target and action's selector.
 */
@interface UIGestureRecognizer (GCAction)

/**
 *  initializer using a |actionBlock| instead of |initWithTarget:action:|.
 *
 *  @param actionBlock  use a |actionBlock| instead of |target| and |action|. must be not nil.
 *
 *  @return             a instance of UIGestureRegconizer.
 */
- (instancetype)initWithActionBlock:(GCGestureActionBlock)actionBlock;

/**
 *  add a |actionBlock|. you can invoke this method multiple times to add many implements of |actionBlock|.
 *
 *  @param actionBlock  the block implements. can't be nil.
 */
- (void)addActionBlock:(GCGestureActionBlock)actionBlock;

/**
 *  remove all |actionBlock| which are added before.
 */
- (void)removeAllActionBlocks;

@end
