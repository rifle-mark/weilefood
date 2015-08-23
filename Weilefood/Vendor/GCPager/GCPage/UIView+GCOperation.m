//
//  UIView+GCOperation.m
//  GCPagerExtension
//
//  Created by njgarychow on 1/14/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import "UIView+GCOperation.h"

@implementation UIView (GCOperation)

@dynamic x;
- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

@dynamic y;
- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

@dynamic width;
- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

@dynamic height;
- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

@dynamic origin;
- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}
- (CGPoint)origin {
    return self.frame.origin;
}

@dynamic size;
- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
- (CGSize)size {
    return self.frame.size;
}







- (void)removeAllSubviews {
    [self.subviews enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
}

@end
