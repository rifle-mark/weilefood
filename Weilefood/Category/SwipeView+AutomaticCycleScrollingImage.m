//
//  SwipeView+AutomaticCycleScrollingImage.m
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SwipeView+AutomaticCycleScrollingImage.h"

static char const kPropertyImageUrlsKey = 0;
static char const kPropertyCurrentItemIndexDidChangeBlockKey = 0;
static char const kPropertyDidSelectItemAtIndexBlockKey = 0;
static NSInteger const kImageChangeDelay = 4;

@implementation SwipeView (AutomaticCycleScrollingImage)

+ (instancetype)acsi_create {
    SwipeView *ret = [[SwipeView alloc] init];
    ret.pagingEnabled = YES;
    ret.wrapEnabled = YES;
    ret.dataSource = ret;
    ret.delegate = ret;
    return ret;
}

#pragma mark - public methods

- (NSArray *)acsi_imageUrls {
    return objc_getAssociatedObject(self, &kPropertyImageUrlsKey);
}

- (void)setAcsi_imageUrls:(NSArray *)acsi_imageUrls {
    objc_setAssociatedObject(self, &kPropertyImageUrlsKey, acsi_imageUrls, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadData];
    if (self.numberOfPages > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_autoNextImage) object:nil];
        [self performSelector:@selector(_autoNextImage) withObject:nil afterDelay:kImageChangeDelay];
    }
}

- (acsi_SwipeViewBlock)acsi_currentItemIndexDidChangeBlock {
    return objc_getAssociatedObject(self, &kPropertyCurrentItemIndexDidChangeBlockKey);
}

- (void)setAcsi_currentItemIndexDidChangeBlock:(acsi_SwipeViewBlock)block {
    objc_setAssociatedObject(self, &kPropertyCurrentItemIndexDidChangeBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)acsi_currentItemIndexDidChangeBlock:(acsi_SwipeViewBlock)block {
    self.acsi_currentItemIndexDidChangeBlock = block;
}

- (acsi_DidSelectItemAtIndexBlock)acsi_didSelectItemAtIndexBlock {
    return objc_getAssociatedObject(self, &kPropertyDidSelectItemAtIndexBlockKey);
}

- (void)setAcsi_didSelectItemAtIndexBlock:(acsi_DidSelectItemAtIndexBlock)block {
    objc_setAssociatedObject(self, &kPropertyDidSelectItemAtIndexBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)acsi_didSelectItemAtIndexBlock:(acsi_DidSelectItemAtIndexBlock)block {
    self.acsi_didSelectItemAtIndexBlock = block;
}

#pragma mark - SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return self.acsi_imageUrls ? self.acsi_imageUrls.count : 0;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView = nil;
    if (!view) {
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
    }
    else {
        imageView = (UIImageView *)view;
    }
    NSString *url = self.acsi_imageUrls[index];
    [imageView my_setImageWithURL:[NSURL URLWithString:url]];
    return imageView;
}

#pragma mark - SwipeViewDelegate

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return swipeView.bounds.size;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    GCBlockInvoke(self.acsi_currentItemIndexDidChangeBlock, swipeView);
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_autoNextImage) object:nil];
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate {
    [self performSelector:@selector(_autoNextImage) withObject:nil afterDelay:kImageChangeDelay];
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    GCBlockInvoke(self.acsi_didSelectItemAtIndexBlock, swipeView, index);
}

#pragma mark - private methods

- (void)_autoNextImage {
    if (self.window) {
        if (self.numberOfPages > 0 && !self.decelerating) {
            NSInteger newPage = self.currentPage + 1;
            if (newPage >= self.numberOfPages) {
                newPage = 0;
            }
            [self scrollToPage:newPage duration:0.3];
        }
    }
    [self performSelector:@selector(_autoNextImage) withObject:nil afterDelay:kImageChangeDelay];
}

@end
