//
//  OrderNumberAndDateView.h
//  Weilefood
//
//  Created by kelei on 15/8/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 订单编号和日期视图
@interface OrderNumberAndDateView : UIView

/// 订单编号
@property (nonatomic, copy) NSString *orderNum;
/// 日期
@property (nonatomic, strong) NSDate *date;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
