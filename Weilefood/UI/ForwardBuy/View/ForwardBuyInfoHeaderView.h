//
//  ForwardBuyInfoHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 预购状态
typedef NS_ENUM(NSInteger, WLForwardBuyState);

/// 预购详情界面 - 头部分
@interface ForwardBuyInfoHeaderView : UIView

/// 商品图集URL<NSString>
@property (nonatomic, strong) NSArray           *images;
/// 商品名称
@property (nonatomic, copy  ) NSString          *title;
/// 剩余数量
@property (nonatomic, assign) NSInteger         number;
/// 价格
@property (nonatomic, assign) CGFloat           price;
/// 预购开始时间
@property (nonatomic, strong) NSDate            *beginDate;
/// 预购结束时间
@property (nonatomic, strong) NSDate            *endDate;
/// 状态
@property (nonatomic, assign) WLForwardBuyState state;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
