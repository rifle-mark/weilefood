//
//  DiscoveryCollectionHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/8.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BannerImageClickBlock)(NSInteger index);

/// 发现界面CollectionCell的头
@interface DiscoveryCollectionHeaderView : UICollectionReusableView

/// Banner广告图片数组
@property (nonatomic, strong) NSArray  *bannerImageUrls;
/// 视频广告图片
@property (nonatomic, copy  ) NSString *videoImageUrl;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

/**
 *  回调：用户点击了某个Banner广告
 */
- (void)bannerImageClickBlock:(BannerImageClickBlock)block;

/**
 *  回调：用户点击了集市
 */
- (void)marketClickBlock:(GCAOPInterceptorBlock)block;

/**
 *  回调：用户点击了预购
 */
- (void)forwardbuyClickBlock:(GCAOPInterceptorBlock)block;

/**
 *  回调：用户点击了营养推荐
 */
- (void)nutritionClickBlock:(GCAOPInterceptorBlock)block;

/**
 *  回调：用户点击了视频广告
 */
- (void)videoImageClickBlock:(GCAOPInterceptorBlock)block;

@end
