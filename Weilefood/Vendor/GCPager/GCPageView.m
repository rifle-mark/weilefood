//
//  GCPageView.m
//  GCPagerExtension
//
//  Created by njgarychow on 1/13/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import "GCPageView.h"
#import "GCDefaultPageView.h"
#import "GCInfinitePageView.h"


@implementation GCPageView

- (instancetype)initWithMode:(GCPageMode)mode {
    if (mode == GCPageModeDefault) {
        return [[GCDefaultPageView alloc] init];
    }
    if (mode == GCPageModeInfinite) {
        return [[GCInfinitePageView alloc] init];
    }
    return nil;
}

- (instancetype)withBlockForPageViewCellCount:(NSUInteger (^)(GCPageView* pageView))block {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withBlockForPageViewCell:(GCPageViewCell* (^)(GCPageView* pageView, NSUInteger index))block {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withBlockForPageViewCellDidScroll:(void (^)(GCPageView* pageView, GCPageViewCell* cell, CGFloat position))block {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withBlockForPageViewCellDidEndDisplay:(void (^)(GCPageView* pageView, NSUInteger index, GCPageViewCell* cell))block {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withLeftBorderAction:(void (^)())leftBorderAction {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withRightBorderAction:(void (^)())rightBorderAction {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withPagingEnabled:(BOOL)pagingEnabled {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withMaximumZoomScale:(CGFloat)maximumZoomScale {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withMinimumZoomScale:(CGFloat)minimumZoomScale {
    NSAssert(NO, @"override this method");
    return nil;
}
- (instancetype)withBounces:(BOOL)bounces {
    NSAssert(NO, @"override this method");
    return nil;
}

- (void)registClass:(Class)cellClass withCellIdentifer:(NSString *)cellIdentifier {
    NSAssert(NO, @"override this method");
}
- (id)dequeueReusableCellWithIdentifer:(NSString *)cellIdentifier {
    NSAssert(NO, @"override this method");
    return nil;
}

- (void)reloadData {
    NSAssert(NO, @"override this method");
}
- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation {
    NSAssert(NO, @"override this method");
}
- (void)startAutoScrollWithInterval:(NSTimeInterval)interval {
    NSAssert(NO, @"override this method");
}
- (void)stopAutoScroll {
    NSAssert(NO, @"override this method");
}

- (NSUInteger)currentPageIndex {
    NSAssert(NO, @"override this method");
    return 0;
}

@end
