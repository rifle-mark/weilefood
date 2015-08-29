//
//  SelectPayPlatformVC.h
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 支付平台类型
typedef NS_ENUM(NSInteger, SelectPayPlatform) {
    /// 支付宝
    SelectPayPlatformAlipay,
    /// 微信支付
    SelectPayPlatformWeixin,
    /// 易宝支付
    SelectPayPlatformYeepay,
};

@class SelectPayPlatformVC;

typedef void (^SelectPayPlatformVCSelectBlock)(SelectPayPlatformVC *vc, SelectPayPlatform selectPayPlatform);

/// 选择支付平台
@interface SelectPayPlatformVC : UIViewController

/**
 *  显示界面
 *
 *  @param money       显示的金额
 *  @param selectBlock 回调：用户选择了某支付平台
 */
+ (void)selectPayPlatformWithMoney:(CGFloat)money selectBlock:(SelectPayPlatformVCSelectBlock)selectBlock;

/**
 *  关闭自己
 */
- (void)dismissSelf;

@end
