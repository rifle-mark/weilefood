//
//  SwipeView+AutomaticCycleScrollingImage.h
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <SwipeView/SwipeView.h>

typedef void (^acsi_SwipeViewBlock)(SwipeView *swipeView);
typedef void (^acsi_DidSelectItemAtIndexBlock)(SwipeView *swipeView, NSInteger index);

/// 分页组件扩展(自动循环滚动图片)
@interface SwipeView (AutomaticCycleScrollingImage) <SwipeViewDataSource, SwipeViewDelegate>

/// 图片URL数组
@property (nonatomic, strong) NSArray *acsi_imageUrls;

/// 回调：当前显示序号已改变
@property (nonatomic, copy) acsi_SwipeViewBlock acsi_currentItemIndexDidChangeBlock;
/// 回调：当前显示序号已改变
- (void)acsi_currentItemIndexDidChangeBlock:(acsi_SwipeViewBlock)block;

/// 回调：用户点击了某个图片
@property (nonatomic, copy) acsi_DidSelectItemAtIndexBlock acsi_didSelectItemAtIndexBlock;
/// 回调：用户点击了某个图片
- (void)acsi_didSelectItemAtIndexBlock:(acsi_DidSelectItemAtIndexBlock)block;

/**
 *  取得SwipeView实例
 *
 *  @return SwipeView实例
 */
+ (instancetype)acsi_create;

@end
