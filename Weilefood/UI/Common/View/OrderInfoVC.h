//
//  OrderInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLOrderModel;

/// 订单详情界面
@interface OrderInfoVC : UIViewController

/**
 *  初始化本界面
 *
 *  @param order 列表上的订单信息对象
 *
 *  @return
 */
- (instancetype)initWithOrder:(WLOrderModel *)order;

@end
