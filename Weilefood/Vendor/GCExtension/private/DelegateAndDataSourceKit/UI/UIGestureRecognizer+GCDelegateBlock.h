//
//  UIGestureRecognizer+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIGestureRecognizer (GCDelegateBlock)

/**
 *  equal to -> |gestureRecognizerShouldBegin:|
 */
GCBlockProperty BOOL (^blockForShouldBegin)(UIGestureRecognizer* gesture);

/**
 *  equal to -> |gestureRecognizer:shouldReceiveTouch:|
 */
GCBlockProperty BOOL (^blockForShouldReceiveTouch)(UIGestureRecognizer* gesture, UITouch* touch);

/**
 *  equal to -> |gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:|
 */
GCBlockProperty BOOL (^blockForShouldSimultaneous)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture);

/**
 *  equal to -> |gestureRecognizer:shouldRequireFailureOfGestureRecognizer:|
 */
GCBlockProperty BOOL (^blockForShouldRequireFailureOf)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture) NS_AVAILABLE_IOS(7_0);

/**
 *  equal to -> |gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:|
 */
GCBlockProperty BOOL (^blockForShouldBeRequireToFailureBy)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture) NS_AVAILABLE_IOS(7_0);

- (void)usingBlocks;

@end
