//
//  SubmitUserHealthInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养师服务订单 - 提交用户健康资料
@interface SubmitUserHealthInfoVC : UIViewController

/**
 *  初始化本界面
 *
 *  @param orderId 营养师服务订单ID
 *
 *  @return
 */
- (id)initWithOrderId:(long long)orderId;

@end
