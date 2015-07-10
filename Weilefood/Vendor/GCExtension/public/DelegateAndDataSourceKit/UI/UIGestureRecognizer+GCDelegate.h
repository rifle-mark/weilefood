//
//  UIGestureRecognizer+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (GCDelegate)

/**
 *  equal to -> |gestureRecognizerShouldBegin:|
 */
- (instancetype)withBlockForShouldBegin:(BOOL (^)(UIGestureRecognizer* gesture))block;

/**
 *  equal to -> |gestureRecognizer:shouldReceiveTouch:|
 */
- (instancetype)withBlockForShouldReceiveTouch:(BOOL (^)(UIGestureRecognizer* gesture, UITouch* touch))block;

/**
 *  equal to -> |gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:|
 */
- (instancetype)withBlockForShouldSimultaneous:(BOOL (^)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture))block;

/**
 *  equal to -> |gestureRecognizer:shouldRequireFailureOfGestureRecognizer:|
 */
- (instancetype)withBlockForShouldRequireFailureOf:(BOOL (^)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture))block;

/**
 *  equal to -> |gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:|
 */
- (instancetype)withBlockForShouldBeRequireToFailureBy:(BOOL (^)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture))block;

@end
