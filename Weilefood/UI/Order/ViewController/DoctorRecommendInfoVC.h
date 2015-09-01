//
//  DoctorRecommendInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养师回复内容
@interface DoctorRecommendInfoVC : UIViewController

/**
 *  初始化本界面
 *
 *  @param orderId 营养师服务订单ID
 *
 *  @return
 */
- (id)initWithOrderId:(long long)orderId;

@end
