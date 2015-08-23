//
//  GCDefaultPageView.m
//  GCPagerExtension
//
//  Created by njgarychow on 1/17/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import "GCDefaultPageView.h"
#import "GCPageScrollView.h"
#import "GCPageViewCellStoreHelper.h"
#import "GCPageViewCell.h"
#import "UIView+GCOperation.h"

@interface GCDefaultPageView () <UIScrollViewDelegate>

@property (nonatomic, strong) GCPageScrollView* pageScrollView;
@property (nonatomic, strong) GCPageViewCellStoreHelper* cellStoreHelper;

@property (nonatomic, copy) void (^leftBorderAction)();
@property (nonatomic, copy) void (^rightBorderAction)();

@property (nonatomic, strong) NSTimer* autoScrollTimer;
@property (nonatomic, assign) NSTimeInterval autoScrollInterval;

@end



@implementation GCDefaultPageView

- (NSUInteger)currentPageIndex {
    return self.pageScrollView.currentPageIndex;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        __weak typeof(self) weakSelf = self;
        self.cellStoreHelper = [[GCPageViewCellStoreHelper alloc] init];
        
        self.pageScrollView = ({
            GCPageScrollView* view = [[GCPageScrollView alloc] initWithFrame:self.bounds];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            view.pagingEnabled = YES;
            [view withBlockForPageViewDidUndisplay:^(GCPageScrollView *view, NSUInteger index, UIView *undisplayView) {
                [weakSelf.cellStoreHelper freeReusablePageViewCell:(id)undisplayView];
            }];
            [view withBlockForPageViewDidEndDisplay:^(GCPageScrollView *view, NSUInteger index, UIView *displayView) {
                [weakSelf _startAutoScrollWithInterval];
            }];
            view;
        });
        [self addSubview:self.pageScrollView];
        
        UIPanGestureRecognizer* pan = ({
            UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] init];
            [pan withBlockForShouldRequireFailureOf:^BOOL(UIGestureRecognizer *gesture, UIGestureRecognizer *otherGesture) {
                if (weakSelf.pageScrollView.panGestureRecognizer && [otherGesture isEqual:weakSelf.pageScrollView.panGestureRecognizer] && weakSelf.pageScrollView.blockForPageViewCount(weakSelf.pageScrollView) > 1) {
                    return YES;
                }
                return NO;
            }];
            [pan addTarget:self action:@selector(_panGestureHandler:)];
            pan;
        });
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (instancetype)withBlockForPageViewCellCount:(NSUInteger (^)(GCPageView* pageView))block {
    __weak typeof(self) weakSelf = self;
    [self.pageScrollView withBlockForPageViewCount:^NSUInteger(GCPageScrollView *view) {
        return block(weakSelf);
    }];
    return self;
}
- (instancetype)withBlockForPageViewCell:(GCPageViewCell* (^)(GCPageView* pageView, NSUInteger index))block {
    __weak typeof(self) weakSelf = self;
    [self.pageScrollView withBlockForPageViewForDisplay:^UIView *(GCPageScrollView *view, NSUInteger index) {
        return (UIView *)block(weakSelf, index);
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
            block(weakSelf, index, (GCPageViewCell *)displayView);
        }
    }];
    return self;
}

- (instancetype)withLeftBorderAction:(void (^)())leftBorderAction {
    self.pageScrollView.borderMask |= GCScrollViewBorderMaskLeft;
    self.leftBorderAction = leftBorderAction;
    return self;
}
- (instancetype)withRightBorderAction:(void (^)())rightBorderAction {
    self.pageScrollView.borderMask |= GCScrollViewBorderMaskRight;
    self.rightBorderAction = rightBorderAction;
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
    [self.pageScrollView reloadData];
    [self showPageAtIndex:self.currentPageIndex animation:NO];
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

- (void)_panGestureHandler:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateRecognized) {
//        CGPoint offsetPoint = [pan translationInView:pan.view];
        CGPoint offsetPoint = [pan translationInView:self];
        if (offsetPoint.x > 0 && self.leftBorderAction) {
            self.leftBorderAction();
        }
        if (offsetPoint.x < 0 && self.rightBorderAction) {
            self.rightBorderAction();
        }
    }
}

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
    NSUInteger nextPageIndex = (self.currentPageIndex + 1) % [self _totalPageCount];
    [self.pageScrollView showPageAtIndex:nextPageIndex animation:YES];
}

- (NSUInteger)_totalPageCount {
    return self.pageScrollView.totalPageCount;
}


@end