//
//  MarketChildChannelView.h
//  Weilefood
//
//  Created by kelei on 15/8/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 市集列表界面 - 市集子栏目选择视图
@interface MarketChildChannelView : UIView

/// 当前选中的栏目ID
@property (nonatomic, assign) kChannelID selectChanneID;

/// 展示所需要的高度
+ (NSInteger)viewHeight;

/// 是否支持此kChannelID选择
- (BOOL)supportThisChannelID:(kChannelID)channelID;

/// 选中某个栏目时的回调(设置selectChanneID时不会触发)
- (void)selectBlock:(void (^)(MarketChildChannelView *view))block;

/// 用户点击了“收起”按钮
- (void)collapseBlock:(void (^)(MarketChildChannelView *view))block;

@end
