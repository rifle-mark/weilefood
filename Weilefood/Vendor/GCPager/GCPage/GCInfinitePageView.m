//
//  GCInfinitePageView.m
//  GCPagerExtension
//
//  Created by njgarychow on 1/17/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import "GCInfinitePageView.h"

#import "GCPageScrollView.h"
#import "GCPageViewCellStoreHelper.h"
#import "GCPageViewCell.h"
#import "UIView+GCOperation.h"

static NSInteger realHalfPageCount = 1000000;

@interface GCInfinitePageView ()

@property (nonatomic, strong) GCPageScrollView* pageScrollView;
@property (nonatomic, strong) GCPageViewCellStoreHelper* cellStoreHelper;

@property (nonatomic, strong) NSTimer* autoScrollTimer;
@property (nonatomic, assign) NSTimeInterval autoScrollInterval;

@property (nonatomic, assign) NSUInteger totalPageCount;

@end



@implementation GCInfinitePageView

- (NSUInteger)currentPageIndex {
    return [self _indexFromPageScrollViewIndex:self.pageScrollView.currentPageIndex];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        __weak typeof(self) weakSelf = self;
        self.cellStoreHelper = [[GCPageViewCellStoreHelper alloc] init];
        
        self.pageScrollView = ({
            GCPageScrollView* view = [[GCPageScrollView alloc] initWithFrame:self.bounds];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [view withBlockForPageViewDidUndisplay:^(GCPageScrollView *view, NSUInteger index, UIView *undisplayView) {
                [weakSelf.cellStoreHelper freeReusablePageViewCell:(id)undisplayView];
            }];
            [view withBlockForPageViewDidEndDisplay:^(GCPageScrollView *view, NSUInteger index, UIView *displayView) {
                [weakSelf _startAutoScrollWithInterval];
            }];
            view;
        });
        [self addSubview:self.pageScrollView];
    }
    return self;
}

- (instancetype)withBlockForPageViewCellCount:(NSUInteger (^)(GCPageView* pageView))block {
    __weak typeof(self) weakSelf = self;
    [self.pageScrollView withBlockForPageViewCount:^NSUInteger(GCPageScrollView *view) {
        weakSelf.totalPageCount = block(weakSelf);
        return realHalfPageCount * 2;
    }];
    return self;
}
- (instancetype)withBlockForPageViewCell:(GCPageViewCell* (^)(GCPageView* pageView, NSUInteger index))block {
    __weak typeof(self) weakSelf = self;
    [self.pageScrollView withBlockForPageViewForDisplay:^UIView *(GCPageScrollView *view, NSUInteger index) {
        return (UIView *)block(weakSelf, [weakSelf _indexFromPageScrollViewIndex:index]);
    }];
    return self;
}
- (instancetype)withBlockForPageViewCellDidScroll:(void (^)(GCPageView* pageView, GCPageViewCell* cell, CGFloat position))block {
    __weak typeof(self) weakSelf = self;
    [self.pageScrollView withBlockForPageViewDidScroll:^(GCPageScrollView *view, UIView *contentView, CGFloat position) {
        [weakSelf _stopAutoScroll];
        if (block) {
            block(weakSelf, (GCPageViewCell *)contentView, position);
        }
    }];
    return self;
}
- (instancetype)withBlockForPageViewCellDidEndDisplay:(void (^)(GCPageView* pageView, NSUInteger index, GCPageViewCell* cell))block {
    __weak typeof(self) weakSelf = self;
    [self.pageScrollView withBlockForPageViewDidEndDisplay:^(GCPageScrollView *view, NSUInteger index, UIView *displayView) {
        [weakSelf _startAutoScrollWithInterval];
        if (block) {
            block(weakSelf, [weakSelf _indexFromPageScrollViewIndex:index], (GCPageViewCell *)displayView);
        }
    }];
    return self;
}

- (instancetype)withLeftBorderAction:(void (^)())leftBorderAction {
    return self;
}
- (instancetype)withRightBorderAction:(void (^)())rightBorderAction {
    return self;
}
- (instancetype)withPagingEnabled:(BOOL)pagingEnabled {
    self.pageScrollView.contentPagingEnabled = pagingEnabled;
    return self;
}
- (instancetype)withMaximumZoomScale:(CGFloat)maximumZoomScale {
    self.pageScrollView.contentMaximumZoomScale = maximumZoomScale;
    return self;
}
- (instancetype)withMinimumZoomScale:(CGFloat)minimumZoomScale {
    self.pageScrollView.contentMinimumZoomScale = minimumZoomScale;
    return self;
}
- (instancetype)withBounces:(BOOL)bounces {
    self.pageScrollView.bounces = bounces;
    return self;
}

- (void)registClass:(Class)cellClass withCellIdentifer:(NSString *)cellIdentifier {
    [self.cellStoreHelper registClass:cellClass withCellIdentifer:cellIdentifier];
}
- (id)dequeueReusableCellWithIdentifer:(NSString *)cellIdentifier {
    return [self.cellStoreHelper dequeueReusablePageViewCellForIdentifer:cellIdentifier size:self.size];
}

- (void)reloadData {
    [self.pageScrollView showPageAtIndexWithoutCallbacks:(self.pageScrollView.currentPageIndex + realHalfPageCount)];
    [self.pageScrollView reloadData];
}

- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation {
    [self.pageScrollView showPageAtIndex:index animation:animation];
}

- (void)startAutoScrollWithInterval:(NSTimeInterval)interval {
    self.autoScrollInterval = interval;
    [self _startAutoScrollWithInterval];
}
- (void)stopAutoScroll {
    self.autoScrollInterval = 0;
    [self _stopAutoScroll];
}

#pragma mark - private methods

- (void)_startAutoScrollWithInterval {
    if (self.autoScrollInterval == 0) {
        return;
    }
    
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollInterval
                                                            target:self
                                                          selector:@selector(_scrollToNextPageAutomatic:)
                                                          userInfo:nil
                                                           repeats:NO];
}
- (void)_stopAutoScroll {
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer = nil;
}
- (void)_scrollToNextPageAutomatic:(NSTimer *)timer {
    NSUInteger nextPageIndex = self.pageScrollView.currentPageIndex + 1;
    [self.pageScrollView showPageAtIndex:nextPageIndex animation:YES];
}
- (NSUInteger)_indexFromPageScrollViewIndex:(NSUInteger)index {
    NSInteger pageIndex = ((NSInteger)index - realHalfPageCount) % (NSInteger)self.totalPageCount;
    pageIndex = (pageIndex + (NSInteger)self.totalPageCount) % (NSInteger)self.totalPageCount;
    return pageIndex;
}

@end
