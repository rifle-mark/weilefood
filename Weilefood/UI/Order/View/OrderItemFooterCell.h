//
//  OrderItemFooterCell.h
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 我的订单列表 - 普通订单尾部信息
@interface OrderItemFooterCell : UITableViewCell

/// 金额
@property (nonatomic, assign) CGFloat money;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

@end
