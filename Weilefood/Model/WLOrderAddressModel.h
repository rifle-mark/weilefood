//
//  WLOrderAddressModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

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
