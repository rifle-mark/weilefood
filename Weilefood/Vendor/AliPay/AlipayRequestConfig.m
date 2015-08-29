//
//  AlipayRequestConfig.m
//  IntegratedAlipay
//
//  Created by Winann on 15/1/9.
//  Copyright (c) 2015年 Winann. All rights reserved.
//

#import "AlipayRequestConfig.h"


@implementation AlipayResponseInfo
@end


@implementation AlipayRequestConfig


// 仅含有变化的参数
+ (void)alipayWithTradeNO:(NSString *)tradeNO
              productName:(NSString *)productName
       productDescription:(NSString *)productDescription
                   amount:(NSString *)amount
                 callback:(AlipayPayCallback)callback {
    [self alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:tradeNO productName:productName productDescription:productDescription amount:amount notifyURL:kNotifyURL service:@"mobile.securitypay.pay" paymentType:@"1" inputCharset:@"UTF-8" itBPay:@"30m" privateKey:kPrivateKey appScheme:kAppScheme callback:callback];
    
}

// 包含所有必要的参数
+ (void)alipayWithPartner:(NSString *)partner
                   seller:(NSString *)seller
                  tradeNO:(NSString *)tradeNO
              productName:(NSString *)productName
       productDescription:(NSString *)productDescription
                   amount:(NSString *)amount
                notifyURL:(NSString *)notifyURL
                  service:(NSString *)service
              paymentType:(NSString *)paymentType
             inputCharset:(NSString *)inputCharset
                   itBPay:(NSString *)itBPay
               privateKey:(NSString *)privateKey
                appScheme:(NSString *)appScheme
                 callback:(AlipayPayCallback)callback {
    
    Order *order = [[Order alloc] init];
    order.partner            = partner;
    order.seller             = seller;
    order.tradeNO            = tradeNO;
    order.productName        = productName;
    order.productDescription = productDescription;
    order.amount             = amount;
    order.notifyURL          = notifyURL;
    order.service            = service;
    order.paymentType        = paymentType;
    order.inputCharset       = inputCharset;
    order.itBPay             = itBPay;
    
    
    // 将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    
    NSString *signedString = [self genSignedStringWithPrivateKey:privateKey OrderSpec:orderSpec];
    
    // 调用支付接口
    [self payWithAppScheme:appScheme orderSpec:orderSpec signedString:signedString callback:callback];
}

// 生成signedString
+ (NSString *)genSignedStringWithPrivateKey:(NSString *)privateKey OrderSpec:(NSString *)orderSpec {
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    return [signer signString:orderSpec];
}

// 支付
+ (void)payWithAppScheme:(NSString *)appScheme orderSpec:(NSString *)orderSpec signedString:(NSString *)signedString callback:(AlipayPayCallback)callback{
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if (callback) {
                AlipayResponseInfo *info = [[AlipayResponseInfo alloc] init];
                info.memo = resultDic[@"memo"];
                info.result = resultDic[@"result"];
                info.resultStatus = [resultDic[@"resultStatus"] integerValue];
                callback(info);
            }
        }];
    }
}

@end
