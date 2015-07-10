//
//  UIScrollView+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (GCDelegate)

/**
 *  equal to -> |scrollViewDidScroll:|
 */
- (instancetype)withBlockForDidScroll:(void (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewWillBeginDragging:|
 */
- (instancetype)withBlockForWillBeginDragging:(void (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewWillEndDragging:withVelocity:targetContentOffset:|
 */
- (instancetype)withBlockForWillEndDragging:(void (^)(UIScrollView* view, CGPoint velocity, CGPoint* targetContentOffset))block;

/**
 *  equal to -> |scrollViewDidEndDragging:willDecelerate:|
 */
- (instancetype)withBlockForDidEndDragging:(void (^)(UIScrollView* view, BOOL decelerate))block;

/**
 *  equal to -> |scrollViewShouldScrollToTop:|
 */
- (instancetype)withBlockForShouldScrollToTop:(BOOL (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewDidScrollToTop:|
 */
- (instancetype)withBlockForDidScrollToTop:(void (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewWillBeginDecelerating:|
 */
- (instancetype)withBlockForWillBeginDecelerating:(void (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewDidEndDecelerating:|
 */
- (instancetype)withBlockForDidEndDecelerating:(void (^)(UIScrollView* view))block;

/**
 *  equal to -> |viewForZoomingInScrollView:|
 */
- (instancetype)withBlockForViewForZooming:(UIView* (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewWillBeginZooming:withView:|
 */
- (instancetype)withBlockForWillBeginZooming:(void (^)(UIScrollView* view, UIView* zoomingView))block;

/**
 *  equal to -> |scrollViewDidEndZooming:withView:atScale:|
 */
- (instancetype)withBlockForDidEndZooming:(void (^)(UIScrollView* view, UIView* zoomingView, CGFloat scale))block;

/**
 *  equal to -> |scrollViewDidZoom:|
 */
- (instancetype)withBlockForDidZoom:(void (^)(UIScrollView* view))block;

/**
 *  equal to -> |scrollViewDidEndScrollingAnimation:|
 */
- (instancetype)withBlockForDidEndScrollingAnimation:(void (^)(UIScrollView* view))block;

@end
