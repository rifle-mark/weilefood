//
//  OrderConfirmVC.h
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 确认订单界面
@interface OrderConfirmVC : UIViewController

/**
 *  初始化本界面并传入商品列表(不能使用其它init方法初始化本界面)
 *
 *  @param productList 商品列表<WLOrderProductModel>
 *  @param needAddress 是否需要收货地址
 *
 *  @return
 */
- (instancetype)initWithProductList:(NSArray *)productList needAddress:(BOOL)needAddress;

@end
