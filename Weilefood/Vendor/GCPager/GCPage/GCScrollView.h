//
//  GCScrollView.h
//  GCPagerExtension
//
//  Created by njgarychow on 1/13/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSInteger, GCScrollViewBorderMask) {
    GCScrollViewBorderMaskTop    = 1 << 1,
    GCScrollViewBorderMaskLeft   = 1 << 2,
    GCScrollViewBorderMaskRight  = 1 << 3,
    GCScrollViewBorderMaskBottom = 1 << 4,
};

@interface GCScrollView : UIScrollView

@property (nonatomic, assign) NSInteger borderMask;

@end
