//
//  OrderPostAgeCell.h
//  Weilefood
//
//  Created by kelei on 15/9/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 订单详情 - 邮费信息
@interface OrderPostAgeCell : UITableViewCell

/// 邮费
@property (nonatomic, assign) CGFloat postAge;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

@end
