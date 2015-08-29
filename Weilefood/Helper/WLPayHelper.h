//
//  WLPayHelper.h
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 支付平台
typedef NS_ENUM(NSInteger, WLPayPlatform) {
    /// 支付宝
    WLPayPlatformAlipay,
    /// 微信支付
    WLPayPlatformWeixin,
    /// 易宝支付
    WLPayPlatformYeepay,
};

typedef void(^WLPayHelperPayCallback)(BOOL isSuccess, NSString *errorMessage);

/// 支付业务
@interface WLPayHelper : NSObject

/// 单例方法
+ (instancetype)sharedInstance;

/**
 *  支付订单
 *
 *  @param platform 支付平台
 *  @param orderNum 订单编号
 *  @param money    订单总金额
 *  @param callback 回调
 */
+ (void)payWithPlatform:(WLPayPlatform)platform orderNum:(NSString *)orderNum money:(CGFloat)money callback:(WLPayHelperPayCallback)callback;

@end
