//
//  ForwardBuyCell.h
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 预购状态
typedef NS_ENUM(NSInteger, WLForwardBuyState);

/// 预购列表 - 预购Cell
@interface ForwardBuyCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString          *imageUrl;
/// 名称
@property (nonatomic, copy  ) NSString          *name;
/// 单价
@property (nonatomic, assign) CGFloat           price;
/// 赞数
@property (nonatomic, assign) NSUInteger        actionCount;
/// 评论数
@property (nonatomic, assign) NSUInteger        commentCount;
/// 预购开始时间
@property (nonatomic, strong) NSDate            *beginDate;
/// 预购结束时间
@property (nonatomic, strong) NSDate            *endDate;
/// 状态
@property (nonatomic, assign) WLForwardBuyState state;


/**
 *  cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;

@end
