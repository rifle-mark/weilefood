//
//  UIScrollViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIScrollViewDelegateImplementationProxy.h"
#import "UIScrollView+GCDelegateBlock.h"

@implementation UIScrollViewDelegateImplementation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.blockForDidScroll(scrollView);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    scrollView.blockForWillBeginDragging(scrollView);
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    scrollView.blockForWillEndDragging(scrollView, velocity, targetContentOffset);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.blockForDidEndDragging(scrollView, decelerate);
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return scrollView.blockForShouldScrollToTop(scrollView);
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    scrollView.blockForDidScrollToTop(scrollView);
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    scrollView.blockForWillBeginDecelerating(scrollView);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrollView.blockForDidEndDecelerating(scrollView);
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.blockForViewForZooming(scrollView);
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.blockForWillBeginZooming(scrollView, view);
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    scrollView.blockForDidEndZooming(scrollView, view, scale);
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    scrollView.blockForDidZoom(scrollView);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    scrollView.blockForDidEndScrollingAnimation(scrollView);
}

@end






@implementation UIScrollViewDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UIScrollViewDelegateImplementation class];
}
+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"scrollViewDidScroll:" : @"blockForDidScroll",
                            @"scrollViewWillBeginDragging:" : @"blockForWillBeginDragging",
                            @"scrollViewWillEndDragging:withVelocity:targetContentOffset:" : @"blockForWillEndDragging",
                            @"scrollViewDidEndDragging:willDecelerate:" : @"blockForDidEndDragging",
                            @"scrollViewShouldScrollToTop:" : @"blockForShouldScrollToTop",
                            @"scrollViewDidScrollToTop:" : @"blockForDidScrollToTop",
                            @"scrollViewWillBeginDecelerating:" : @"blockForWillBeginDecelerating",
                            @"scrollViewDidEndDecelerating:" : @"blockForDidEndDecelerating",
                            @"viewForZoomingInScrollView:" : @"blockForViewForZooming",
                            @"scrollViewWillBeginZooming:withView:" : @"blockForWillBeginZooming",
                            @"scrollViewDidEndZooming:withView:atScale:" : @"blockForDidEndZooming",
                            @"scrollViewDidZoom:" : @"blockForDidZoom",
                            @"scrollViewDidEndScrollingAnimation:" : @"blockForDidEndScrollingAnimation",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
