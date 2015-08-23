//
//  GCPageScrollView.h
//  GCPagerExtension
//
//  Created by zhoujinqiang on 15/1/20.
//  Copyright (c) 2015年 njgarychow. All rights reserved.
//

#import "GCScrollView.h"

@interface GCPageScrollView : GCScrollView

@property (nonatomic, assign) BOOL contentPagingEnabled;
@property (nonatomic, assign) CGFloat contentMaximumZoomScale;
@property (nonatomic, assign) CGFloat contentMinimumZoomScale;
@property (nonatomic, copy) NSUInteger (^blockForPageViewCount)(GCPageScrollView* view);

- (instancetype)withBlockForPageViewCount:(NSUInteger (^)(GCPageScrollView* view))block;
- (instancetype)withBlockForPageViewForDisplay:(UIView* (^)(GCPageScrollView* view, NSUInteger index))block;
- (instancetype)withBlockForPageViewDidEndDisplay:(void (^)(GCPageScrollView* view, NSUInteger index, UIView* displayView))block;
- (instancetype)withBlockForPageViewDidUndisplay:(void (^)(GCPageScrollView* view, NSUInteger index, UIView* undisplayView))block;
- (instancetype)withBlockForPageViewDidScroll:(void (^)(GCPageScrollView* view, UIView* contentView, CGFloat position))block;

- (void)reloadData;

- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation;
- (void)showPageAtIndexWithoutCallbacks:(NSUInteger)index;

- (NSUInteger)currentPageIndex;
- (NSUInteger)totalPageCount;

@end
