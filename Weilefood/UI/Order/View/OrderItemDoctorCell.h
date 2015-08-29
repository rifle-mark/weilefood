//
//  OrderItemDoctorCell.h
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 我的订单列表 - 营养师信息
@interface OrderItemDoctorCell : UITableViewCell

/// 图片链接
@property (nonatomic, copy) NSString *imageUrl;
/// 姓名
@property (nonatomic, copy) NSString *name;
/// 服务名称
@property (nonatomic, copy) NSString *serviceName;
/// 金额
@property (nonatomic, assign) CGFloat money;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

@end
