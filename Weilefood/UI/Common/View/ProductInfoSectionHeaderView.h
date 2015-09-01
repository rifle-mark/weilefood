//
//  ProductInfoSectionHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/6.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 商品详情界面 - 固定头部分
@interface ProductInfoSectionHeaderView : UIView

/// 是否已赞
@property (nonatomic, assign) BOOL      hasAction;
/// 赞数量
@property (nonatomic, assign) long long actionCount;
/// 评论数量
@property (nonatomic, assign) long long commentCount;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

/**
 *  回调：用户点击了“赞”
 *
 *  @param block
 */
- (void)actionBlock:(GCAOPInterceptorBlock)block;

/**
 *  回调：用户点击了“评论”
 *
 *  @param block
 */
- (void)commentBlock:(GCAOPInterceptorBlock)block;

/**
 *  回调：用户点击了“分享”
 *
 *  @param block
 */
- (void)shareBlock:(GCAOPInterceptorBlock)block;

@end
