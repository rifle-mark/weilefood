//
//  UIScrollView+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIScrollView (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |scrollViewDidScroll:|
 */
GCBlockProperty void (^blockForDidScroll)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillBeginDragging:|
 */
GCBlockProperty void (^blockForWillBeginDragging)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillEndDragging:withVelocity:targetContentOffset:|
 */
GCBlockProperty void (^blockForWillEndDragging)(UIScrollView* scrollView, CGPoint velocity, CGPoint* targetContentOffset);

/**
 *  equal to -> |scrollViewDidEndDragging:willDecelerate:|
 */
GCBlockProperty void (^blockForDidEndDragging)(UIScrollView* scrollView, BOOL decelerate);

/**
 *  equal to -> |scrollViewShouldScrollToTop:|
 */
GCBlockProperty BOOL (^blockForShouldScrollToTop)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewDidScrollToTop:|
 */
GCBlockProperty void (^blockForDidScrollToTop)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillBeginDecelerating:|
 */
GCBlockProperty void (^blockForWillBeginDecelerating)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewDidEndDecelerating:|
 */
GCBlockProperty void (^blockForDidEndDecelerating)(UIScrollView* scrollView);

/**
 *  equal to -> |viewForZoomingInScrollView:|
 */
GCBlockProperty UIView* (^blockForViewForZooming)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewWillBeginZooming:withView:|
 */
GCBlockProperty void (^blockForWillBeginZooming)(UIScrollView* scrollView, UIView* zoomingView);

/**
 *  equal to -> |scrollViewDidEndZooming:withView:atScale:|
 */
GCBlockProperty void (^blockForDidEndZooming)(UIScrollView* scrollView, UIView* zoomingView, CGFloat scale);

/**
 *  equal to -> |scrollViewDidZoom:|
 */
GCBlockProperty void (^blockForDidZoom)(UIScrollView* scrollView);

/**
 *  equal to -> |scrollViewDidEndScrollingAnimation:|
 */
GCBlockProperty void (^blockForDidEndScrollingAnimation)(UIScrollView* scrollView);

@end
