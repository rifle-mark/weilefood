//
//  WLOrderDetailModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLOrderDeliverModel, WLOrderAddressModel;

/// 订单详情
@interface WLOrderDetailModel : NSObject

/// 发货快递信息
@property (nonatomic, strong) WLOrderDeliverModel *deliver;
/// 收货人信息
@property (nonatomic, strong) WLOrderAddressModel *orderAddress;
/// 订单商品列表<WLOrderProductModel>
@property (nonatomic, strong) NSArray *orderDetail;

@end
