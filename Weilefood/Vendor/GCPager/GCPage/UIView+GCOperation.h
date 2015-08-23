//
//  UIView+GCOperation.h
//  GCPagerExtension
//
//  Created by njgarychow on 1/14/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GCOperation)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (void)removeAllSubviews;

@end
