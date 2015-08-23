//
//  GCPageScrollView.m
//  GCPagerExtension
//
//  Created by zhoujinqiang on 15/1/20.
//  Copyright (c) 2015年 njgarychow. All rights reserved.
//

#import "GCPageScrollView.h"
#import "UIView+GCOperation.h"

#pragma mark - GCPageContentScrollView

@interface GCPageContentScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIView* contentView;

@end

@implementation GCPageContentScrollView

- (void)setContentView:(UIView *)contentView {
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self addSubview:_contentView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.contentView;
}

@end


#pragma mark - GCPageContentScrollViewStoreHelper

@interface GCPageContentScrollViewStoreHelper : NSObject {
    NSMutableDictionary* _inuseViewDictionary;
    NSMutableArray* _reuseViewArray;
}

- (NSArray *)storedPageContentScrollViewsIndexesInorder;
- (GCPageContentScrollView *)pageContentScrollViewAtIndex:(NSUInteger)index;
- (GCPageContentScrollView *)createPageContentScrollViewAtIndex:(NSUInteger)index;
- (void)deletePageContentScrollViewAtIndex:(NSUInteger)index;

@end


@implementation GCPageContentScrollViewStoreHelper

- (instancetype)init {
    if (self = [super init]) {
        _inuseViewDictionary = [NSMutableDictionary dictionary];
        _reuseViewArray = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)storedPageContentScrollViewsIndexesInorder {
    return [[_inuseViewDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 unsignedIntegerValue] <= [obj2 unsignedIntegerValue] ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (GCPageContentScrollView *)createPageContentScrollViewAtIndex:(NSUInteger)index {
    GCPageContentScrollView* view = nil;
    view = [_reuseViewArray lastObject];
    [_reuseViewArray removeLastObject];
    if (!view) {
        view = [[GCPageContentScrollView alloc] init];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    _inuseViewDictionary[@(index)] = view;
    return view;
}
- (GCPageContentScrollView *)pageContentScrollViewAtIndex:(NSUInteger)index {
    return _inuseViewDictionary[@(index)];
}
- (void)deletePageContentScrollViewAtIndex:(NSUInteger)index {
    GCPageContentScrollView* view = _inuseViewDictionary[@(index)];
    view.zoomScale = 1.0f;
    [_inuseViewDictionary removeObjectForKey:@(index)];
    [view removeAllSubviews];
    view.frame = CGRectZero;
    [_reuseViewArray addObject:view];
}

@end





#pragma mark - GCPageScrollView


@interface GCPageScrollView () <UIScrollViewDelegate>


@property (nonatomic, copy) UIView* (^blockForPageViewForDisplay)(GCPageScrollView* view, NSUInteger index);
@property (nonatomic, copy) void (^blockForPageViewDidEndDisplay)(GCPageScrollView* view, NSUInteger index, UIView* displayView);
@property (nonatomic, copy) void (^blockForPageViewDidUndisplay)(GCPageScrollView* view, NSUInteger index, UIView* undisplayView);
@property (nonatomic, copy) void (^blockForPageViewDidScroll)(GCPageScrollView* view, UIView* contentView, CGFloat position);

@property (nonatomic, strong) GCPageContentScrollViewStoreHelper* storeHelper;

@property (nonatomic, assign) CGPoint startDraggingOffsetPoint;

@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign) NSUInteger totalPageCount;

@property (nonatomic, assign) BOOL shouldCallback;

@end


@implementation GCPageScrollView
- (void)setContentPagingEnabled:(BOOL)contentPagingEnabled {
    _contentPagingEnabled = contentPagingEnabled;
    self.decelerationRate = _contentPagingEnabled ? UIScrollViewDecelerationRateNormal : UIScrollViewDecelerationRateFast;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.storeHelper = [[GCPageContentScrollViewStoreHelper alloc] init];
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
        self.decelerationRate = UIScrollViewDecelerationRateNormal;
        
        self.shouldCallback = YES;
        self.contentMaximumZoomScale = 1.0f;
        self.contentMinimumZoomScale = 1.0f;
    }
    return self;
}

- (instancetype)withBlockForPageViewCount:(NSUInteger (^)(GCPageScrollView *))block {
    self.blockForPageViewCount = block;
    return self;
}
- (instancetype)withBlockForPageViewForDisplay:(UIView *(^)(GCPageScrollView *, NSUInteger))block {
    self.blockForPageViewForDisplay = block;
    return self;
}
- (instancetype)withBlockForPageViewDidUndisplay:(void (^)(GCPageScrollView *, NSUInteger, UIView *))block {
    self.blockForPageViewDidUndisplay = block;
    return self;
}
- (instancetype)withBlockForPageViewDidEndDisplay:(void (^)(GCPageScrollView* view, NSUInteger index, UIView* displayView))block {
    self.blockForPageViewDidEndDisplay = block;
    return self;
}
- (instancetype)withBlockForPageViewDidScroll:(void (^)(GCPageScrollView* view, UIView* contentView, CGFloat position))block {
    self.blockForPageViewDidScroll = block;
    return self;
}

- (void)reloadData {
    NSParameterAssert(self.blockForPageViewCount != NULL);
    NSParameterAssert(self.blockForPageViewForDisplay != NULL);
    
    self.totalPageCount = self.blockForPageViewCount(self);
    if (self.currentPageIndex >= self.totalPageCount) {
        self.currentPageIndex = (self.totalPageCount >= 1) ? self.totalPageCount - 1 : 0;
    }
    self.contentSize = CGSizeMake(self.width * self.totalPageCount, self.bounds.size.height);
    [self _refreshContentPageViews];
    [self _checkContentIfDidEndDiplay];
}

- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation {
    if (animation) {
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
    }
    [self setContentOffset:[self _originForContentViewAtIndex:index] animated:animation];
}

- (void)showPageAtIndexWithoutCallbacks:(NSUInteger)index {
    self.shouldCallback = NO;
    [self showPageAtIndex:index animation:NO];
    self.shouldCallback = YES;
}


#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self _refreshContentPageViews];
    self.currentPageIndex = floor(self.contentOffset.x / self.width + 0.5f);
    if (self.blockForPageViewDidScroll && self.shouldCallback) {
        for (NSNumber* index in [self.storeHelper storedPageContentScrollViewsIndexesInorder]) {
            CGRect rect = [self _rectForContentViewAtIndex:[index unsignedIntegerValue]];
            GCPageContentScrollView* contentContainerView = [self.storeHelper pageContentScrollViewAtIndex:[index unsignedIntegerValue]];
            self.blockForPageViewDidScroll(self, contentContainerView.contentView, (rect.origin.x - scrollView.contentOffset.x) / self.width);
        }
    }
    [self _checkContentIfDidEndDiplay];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startDraggingOffsetPoint = scrollView.contentOffset;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (self.contentPagingEnabled) {
        NSInteger targetPageIndex = floor(((*targetContentOffset).x / self.width) + 0.5f);
        NSInteger originPageIndex = floor(self.startDraggingOffsetPoint.x / self.width + 0.5f);
        NSInteger pageIndex = originPageIndex;
        if (targetPageIndex > originPageIndex) {
            pageIndex++;
        }
        else if (targetPageIndex < originPageIndex) {
            pageIndex--;
        }
        *targetContentOffset = [self _originForContentViewAtIndex:pageIndex];
    }
    else {
        NSInteger targetPageIndex = floor(((*targetContentOffset).x / self.width) + 0.5f);
        *targetContentOffset = [self _originForContentViewAtIndex:targetPageIndex];
    }
}



#pragma mark - private methods

- (void)_refreshContentPageViews {
    NSArray* visibleIndexes = [self _visibleContentIndexes];
    for (NSNumber* index in [self.storeHelper storedPageContentScrollViewsIndexesInorder]) {
        if (![visibleIndexes containsObject:index]) {
            NSUInteger idx = [index unsignedIntegerValue];
            GCPageContentScrollView* contentContainerView = [self.storeHelper pageContentScrollViewAtIndex:idx];
            UIView* view = contentContainerView.contentView;
            [contentContainerView removeFromSuperview];
            [self.storeHelper deletePageContentScrollViewAtIndex:idx];
            if (self.blockForPageViewDidUndisplay && self.shouldCallback) {
                self.blockForPageViewDidUndisplay(self, idx, view);
            }
        }
    }
    for (NSNumber* index in visibleIndexes) {
        NSUInteger idx = [index unsignedIntegerValue];
        if (![self.storeHelper pageContentScrollViewAtIndex:idx]) {
            CGRect rect = [self _rectForContentViewAtIndex:idx];
            UIView* view = self.blockForPageViewForDisplay(self, idx);
            GCPageContentScrollView* contentView = [self.storeHelper createPageContentScrollViewAtIndex:idx];
            contentView.frame = rect;
            contentView.maximumZoomScale = self.contentMaximumZoomScale;
            contentView.minimumZoomScale = self.contentMinimumZoomScale;
            contentView.contentView = view;
            [self addSubview:contentView];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
    }
}

- (void)_checkContentIfDidEndDiplay {
    if (self.blockForPageViewDidEndDisplay && self.shouldCallback) {
        for (NSNumber* index in [self _visibleContentIndexes]) {
            NSUInteger idx = [index unsignedIntegerValue];
            CGRect rect = [self _rectForContentViewAtIndex:idx];
            if ((rect.origin.x - self.contentOffset.x) == 0) {
                GCPageContentScrollView* contentContainerView = [self.storeHelper pageContentScrollViewAtIndex:idx];
                self.blockForPageViewDidEndDisplay(self, self.currentPageIndex, contentContainerView.contentView);
            }
        }
    }
}

- (CGRect)_rectForContentViewAtIndex:(NSUInteger)index {
    return (CGRect){{self.width * index, 0}, self.bounds.size};
}
- (CGPoint)_originForContentViewAtIndex:(NSUInteger)index {
    return [self _rectForContentViewAtIndex:index].origin;
}

- (NSArray *)_visibleContentIndexes {
    if (self.totalPageCount == 0) {
        return @[];
    }
    CGRect visibleRect = self.bounds;
    
    BOOL (^IsContentAtIndexVisible)(NSUInteger index) = ^(NSUInteger index) {
        CGRect rect = [self _rectForContentViewAtIndex:index];
        if (CGRectEqualToRect(rect, CGRectZero)) {
            return  NO;
        }
        if (!CGRectIntersectsRect(rect, visibleRect)) {
            return NO;
        }
        return YES;
    };
    NSMutableOrderedSet* indexes = [[NSMutableOrderedSet alloc] init];
    {
        NSUInteger pageIndex = (self.bounds.origin.x / self.width);
        while (YES) {
            if (!IsContentAtIndexVisible(pageIndex)) {
                break;
            }
            [indexes addObject:@(pageIndex)];
            if (pageIndex-- == 0) {
                break;
            }
        }
    }
    {
        NSUInteger pageIndex = (self.bounds.origin.x / self.width);
        while (YES) {
            if (!IsContentAtIndexVisible(pageIndex)) {
                break;
            }
            [indexes addObject:@(pageIndex)];
            if (++pageIndex >= self.totalPageCount) {
                break;
            }
        }
    }
    return [indexes array];
}

@end
