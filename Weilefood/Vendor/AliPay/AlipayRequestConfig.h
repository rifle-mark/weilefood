//
//  AlipayRequestConfig.h
//  IntegratedAlipay
//
//  Created by Winann on 15/1/9.
//  Copyright (c) 2015年 Winann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlipayHeader.h"


/// 支付成功
static NSInteger const kAlipayResultStatusSuccess = 9000;


/// 支付宝支付结果信息对象
@interface AlipayResponseInfo : NSObject
/// 文字消息
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *result;
/// 状态
@property (nonatomic, assign) NSInteger resultStatus;
@end


typedef void(^AlipayPayCallback)(AlipayResponseInfo *responseInfo);


@interface AlipayRequestConfig : NSObject


/**
 *  配置请求信息，仅有变化且必要的参数
 *
 *  @param tradeNO            商户网站唯一订单号
 *  @param productName        商品名称
 *  @param productDescription 商品详情
 *  @param amount             总金额
 *  @param callback           支付结果回调
 */
+ (void)alipayWithTradeNO:(NSString *)tradeNO
              productName:(NSString *)productName
       productDescription:(NSString *)productDescription
                   amount:(NSString *)amount
                 callback:(AlipayPayCallback)callback;

@end
