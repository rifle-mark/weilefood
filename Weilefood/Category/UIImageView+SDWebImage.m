//
//  UIImageView+SDWebImage.m
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIImageView+SDWebImage.h"

@interface UIImageView ()

@property (nonatomic, assign) UIViewContentMode oldMode;

@end

static char const kPropertyOldModeKey = 0;

@implementation UIImageView (SDWebImage)

#pragma mark - public property methods

- (void)setContentMode:(UIViewContentMode)contentMode {
    self.oldMode = contentMode;
    [super setContentMode:contentMode];
}

#pragma mark - public methods

- (void)my_setImageWithURL:(NSURL *)url {
    [self my_setImageWithURL:url options:0 progress:nil completed:nil];
}

- (void)my_setImageWithURL:(NSURL *)url options:(SDWebImageOptions)options {
    [self my_setImageWithURL:url options:options progress:nil completed:nil];
}

- (void)my_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock {
    [self my_setImageWithURL:url options:0 progress:nil completed:completedBlock];
}

- (void)my_setImageWithURL:(NSURL *)url options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock {
    [self my_setImageWithURL:url options:options progress:nil completed:completedBlock];
}

- (void)my_setImageWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    
    UIImage *placeholderImage = [UIImage imageNamed:@"bg_placeholder"];
    if (self.bounds.size.width < placeholderImage.size.width || self.bounds.size.height < placeholderImage.size.height) {
        [super setContentMode:UIViewContentModeScaleAspectFit];
    }
    else {
        [super setContentMode:UIViewContentModeCenter];
    }
    
    _weak(self);
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            return;
        }
        _strong_check(self);
        self.contentMode = self.oldMode;
    }];
}

#pragma mark - private property methods

- (UIViewContentMode)oldMode {
    return [objc_getAssociatedObject(self, &kPropertyOldModeKey) integerValue];
}

- (void)setOldMode:(UIViewContentMode)oldMode {
    objc_setAssociatedObject(self, &kPropertyOldModeKey, @(oldMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
