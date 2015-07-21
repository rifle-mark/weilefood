//
//  WLOrderDeliverModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 订单发货快递信息
@interface WLOrderDeliverModel : NSObject

/// 订单ID
@property (nonatomic, assign) NSUInteger orderId;
/// ID
@property (nonatomic, assign) NSUInteger deliverId;
/// 发货日期
@property (nonatomic, copy) NSDate *deliverDate;
/// 快递单号
@property (nonatomic, copy) NSString *expressNum;
/// 快递名称
@property (nonatomic, copy) NSString *expressName;
///
@property (nonatomic, assign) NSInteger expressType;

@end
