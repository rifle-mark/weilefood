//
//  OrderInfoHeaderCell.h
//  Weilefood
//
//  Created by kelei on 15/8/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 订单详情 - 概要信息
@interface OrderInfoHeaderCell : UITableViewCell

/// 收货人姓名
@property (nonatomic, copy) NSString *name;
/// 收货人电话
@property (nonatomic, copy) NSString *phone;
/// 收货人地址
@property (nonatomic, copy) NSString *address;
/// 收货人邮编
@property (nonatomic, copy) NSString *zipCode;
/// 是否显示快递信息。默认NO
@property (nonatomic, assign) BOOL isShowExpressInfo;
/// 快递名称
@property (nonatomic, copy) NSString *expressName;
/// 快递单号
@property (nonatomic, copy) NSString *expressNum;

/**
 *  Cell展示所需要的高度
 *
 *  @param address           收货人地址
 *  @param isShowExpressInfo 是否显示快递信息
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithAddress:(NSString *)address isShowExpressInfo:(BOOL)isShowExpressInfo;
+ (NSString *)reuseIdentifier;


@end
