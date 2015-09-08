//
//  WLPayHelper.m
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLPayHelper.h"
#import "AlipayHeader.h"
#import "YeepayVC.h"

@implementation WLPayHelper

+ (instancetype)sharedInstance {
    static WLPayHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)payWithPlatform:(WLPayPlatform)platform orderNum:(NSString *)orderNum money:(CGFloat)money callback:(WLPayHelperPayCallback)callback {
    if (platform == WLPayPlatformWeixin) {
        
    }
    else if (platform == WLPayPlatformYeepay) {
        NSString *payUrl = [kServerUrl stringByAppendingFormat:@"/ybpay/pay.aspx?ordernum=%@", orderNum];
        [YeepayVC payWithUrl:payUrl payBlock:^(BOOL isSuccess) {
            GCBlockInvoke(callback, isSuccess, nil);
        }];
    }
    else if (platform == WLPayPlatformAlipay) {
        NSString *productName = [NSString stringWithFormat:@"<味了>订单%@", orderNum];
        [AlipayRequestConfig alipayWithTradeNO:orderNum
                                   productName:productName
                            productDescription:productName
                                        amount:[NSString stringWithFormat:@"%@", @(money)]
                                      callback:^(AlipayResponseInfo *responseInfo) {
                                          if (responseInfo.resultStatus == kAlipayResultStatusSuccess) {
                                              GCBlockInvoke(callback, YES, nil);
                                          }
                                          else {
                                              GCBlockInvoke(callback, NO, responseInfo.memo);
                                          }
                                      }
         ];
    }
    else {
        NSAssert(NO, @"不支持的支付平台%ld", (long)platform);
    }
}

@end
