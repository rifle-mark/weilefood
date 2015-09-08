//
//  YeepayVC.h
//  Weilefood
//
//  Created by kelei on 15/9/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YeepayVCPayBlock)(BOOL isSuccess);

/// 易宝支付界面
@interface YeepayVC : UIViewController

/**
 *  支付
 *
 *  @param url      易宝支付链接
 *  @param payBlock 支付成功的回调
 */
+ (void)payWithUrl:(NSString *)url payBlock:(YeepayVCPayBlock)payBlock;

@end
