//
//  UIScrollView+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIScrollView+GCDelegate.h"

#import "UIScrollView+GCDelegateBlock.h"

@implementation UIScrollView (GCDelegate)

- (instancetype)withBlockForDidScroll:(void (^)(UIScrollView* view))block {
    self.blockForDidScroll = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillBeginDragging:(void (^)(UIScrollView* view))block {
    self.blockForWillBeginDragging = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillEndDragging:(void (^)(UIScrollView* view, CGPoint velocity, CGPoint* targetContentOffset))block {
    self.blockForWillEndDragging = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndDragging:(void (^)(UIScrollView* view, BOOL decelerate))block {
    self.blockForDidEndDragging = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldScrollToTop:(BOOL (^)(UIScrollView* view))block {
    self.blockForShouldScrollToTop = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidScrollToTop:(void (^)(UIScrollView* view))block {
    self.blockForDidScrollToTop = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillBeginDecelerating:(void (^)(UIScrollView* view))block {
    self.blockForWillBeginDecelerating = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndDecelerating:(void (^)(UIScrollView* view))block {
    self.blockForDidEndDecelerating = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForViewForZooming:(UIView* (^)(UIScrollView* view))block {
    self.blockForViewForZooming = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillBeginZooming:(void (^)(UIScrollView* view, UIView* zoomingView))block {
    self.blockForWillBeginZooming = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndZooming:(void (^)(UIScrollView* view, UIView* zoomingView, CGFloat scale))block {
    self.blockForDidEndZooming = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidZoom:(void (^)(UIScrollView* view))block {
    self.blockForDidZoom = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndScrollingAnimation:(void (^)(UIScrollView* view))block {
    self.blockForDidEndScrollingAnimation = block;
    [self usingBlocks];
    return self;
}

@end
