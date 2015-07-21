//
//  WLOrderModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 订单
@interface WLOrderModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger orderId;
/// 编号
@property (nonatomic, copy) NSString *orderNum;
/// 订单日期
@property (nonatomic, copy) NSDate *orderDate;
/// 总金额
@property (nonatomic, assign) CGFloat totalMoney;
/// 支付方式
@property (nonatomic, assign) NSUInteger paymentId;
/// 支付日期
@property (nonatomic, copy) NSDate *paymentDate;
///
@property (nonatomic, assign) NSUInteger orderType;
///
@property (nonatomic, assign) NSInteger state;
///
@property (nonatomic, assign) NSUInteger userId;

@end
