//
//  UIImageView+SDWebImage.h
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDWebImage)

- (void)my_setImageWithURL:(NSURL *)url;

- (void)my_setImageWithURL:(NSURL *)url options:(SDWebImageOptions)options;

- (void)my_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;

- (void)my_setImageWithURL:(NSURL *)url options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;

- (void)my_setImageWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

@end
