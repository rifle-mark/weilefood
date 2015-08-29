//
//  WLOrderModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLOrderDeliverModel, WLOrderAddressModel;

/// 订单状态
typedef NS_ENUM(NSInteger, WLOrderState) {
    /// 已取消
    WLOrderStateCancel = -1,
    /// 未付款
    WLOrderStateUnpaid = 0,
    /// 已付款(待发货 或 待提交营养需求)
    WLOrderStatePaid = 1,
    /// 已发货 或 已提交营养需求
    WLOrderStateShipped = 2,
    /// 确认收货 或 已回复营养计划
    WLOrderStateConfirmed = 3,
};

/// 订单
@interface WLOrderModel : NSObject

/// ID
@property (nonatomic, assign) long long    orderId;
/// 编号
@property (nonatomic, copy  ) NSString     *orderNum;
/// 订单日期
@property (nonatomic, copy  ) NSDate       *orderDate;
/// 总金额
@property (nonatomic, assign) CGFloat      totalMoney;
/// 支付方式
@property (nonatomic, assign) long long    paymentId;
/// 支付日期
@property (nonatomic, copy  ) NSDate       *paymentDate;
/// 状态
@property (nonatomic, assign) WLOrderState state;
///
@property (nonatomic, assign) NSInteger    orderType;
///
@property (nonatomic, assign) long long    userId;

/// 商品图片
@property (nonatomic, copy  ) NSString     *image;
/// 营养师头像
@property (nonatomic, copy  ) NSString     *images;
/// 营养师ID
@property (nonatomic, assign) long long    doctorId;
/// 营养师姓名
@property (nonatomic, copy  ) NSString     *trueName;
/// 预购名称|活动名称|
@property (nonatomic, copy  ) NSString     *title;

/// 发货快递信息
@property (nonatomic, strong) WLOrderDeliverModel *deliver;
/// 收货人信息
@property (nonatomic, strong) WLOrderAddressModel *orderAddress;
/// 订单商品列表<WLOrderProductModel>
@property (nonatomic, strong) NSArray *orderDetail;

@end


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


/// 订单收货人
@interface WLOrderAddressModel : NSObject

/// 邮编(生成订单时必填)
@property (nonatomic, copy) NSString *postCode;
/// 地址(生成订单时必填)
@property (nonatomic, copy) NSString *address;
/// 电话(生成订单时必填)
@property (nonatomic, copy) NSString *tel;
/// 姓名(生成订单时必填)
@property (nonatomic, copy) NSString *userName;
/// 订单ID
@property (nonatomic, assign) NSUInteger orderId;

@end
