//
//  GCScrollView.m
//  GCPagerExtension
//
//  Created by njgarychow on 1/13/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import "GCScrollView.h"

@interface GCScrollView () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint previousTouchPoint;

@end

@implementation GCScrollView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint currentTouchPoint = [gestureRecognizer locationInView:self];
    if ((self.previousTouchPoint.x < currentTouchPoint.x)   &&
        (self.contentOffset.x <= 0)                         &&
        (self.borderMask & GCScrollViewBorderMaskLeft)) {
        return NO;
    }
    if ((self.previousTouchPoint.x > currentTouchPoint.x)                           &&
        ((self.contentOffset.x + self.bounds.size.width) >= self.contentSize.width) &&
        (self.borderMask & GCScrollViewBorderMaskRight)) {
        return NO;
    }
    if ((self.previousTouchPoint.y > currentTouchPoint.y)   &&
        (self.contentOffset.y <= 0)                         &&
        (self.borderMask & GCScrollViewBorderMaskTop)) {
        return NO;
    }
    if ((self.previousTouchPoint.y < currentTouchPoint.y)                               &&
        ((self.contentOffset.y + self.bounds.size.height) >= self.contentSize.height)   &&
        (self.borderMask & GCScrollViewBorderMaskBottom)) {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    self.previousTouchPoint = [touch locationInView:self];
    return YES;
}

@end
