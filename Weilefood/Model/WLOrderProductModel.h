//
//  WLOrderProductModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 订单商品类型
typedef NS_ENUM(NSInteger, WLOrderProductType) {
    /// 市集产品
    WLOrderProductTypeProduct = 2,
    /// 活动
    WLOrderProductTypeActivity = 3,
    /// 预购
    WLOrderProductTypeForwardBuy = 4,
    /// 营养师
    WLOrderProductTypeDoctor = 5,
};

/// 订单商品
@interface WLOrderProductModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger orderDetailId;
/// 商品类型(生成订单时必填)
@property (nonatomic, assign) WLOrderProductType type;
/// 商品对象ID(生成订单时必填)
@property (nonatomic, assign) long long refId;
/// 数量(生成订单时必填)
@property (nonatomic, assign) NSUInteger count;
/// 单价
@property (nonatomic, assign) CGFloat price;
/// 名称
@property (nonatomic, copy) NSString *title;
/// 图片URL
@property (nonatomic, copy) NSString *image;
/// 订单ID
@property (nonatomic, assign) long long orderId;
///
@property (nonatomic, copy) NSDate *createDate;

@end


/// CoreData使用
@interface WLMOOrderProduct : NSManagedObject
@property (nonatomic, strong) NSNumber *orderDetailId;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *refId;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *orderId;
@property (nonatomic, strong) NSDate *createDate;
@end