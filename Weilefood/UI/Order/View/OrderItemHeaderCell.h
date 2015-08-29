//
//  OrderItemHeaderCell.h
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderItemHeaderCell;

typedef void (^OrderItemHeaderCellRightButtonActionBlock)(OrderItemHeaderCell *cell);

/// 订单列表 - 订单头部信息
@interface OrderItemHeaderCell : UITableViewCell

/// 订单编号
@property (nonatomic, copy) NSString *orderNum;
/// 日期
@property (nonatomic, strong) NSDate *date;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

/**
 *  右侧显示指定文字
 *
 *  @param text 文字
 */
- (void)setRightLabelWithText:(NSString *)text;

/**
 *  右侧显示按钮
 *
 *  @param text        按钮文字
 *  @param actionBlock 按钮事件回调
 */
- (void)setRightButtonWithTitle:(NSString *)text actionBlock:(OrderItemHeaderCellRightButtonActionBlock)actionBlock;

/**
 *  清除右侧设置的信息
 */
- (void)clearRightControl;

@end
