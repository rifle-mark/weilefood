//
//  DoctorServiceCell.h
//  Weilefood
//
//  Created by kelei on 15/8/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoctorServiceCell;

typedef void (^BuyClickBlock)(DoctorServiceCell *cell);

/// 营养师服务项目Cell
@interface DoctorServiceCell : UITableViewCell

/// 名称
@property (nonatomic, copy) NSString *name;
/// 介绍
@property (nonatomic, copy) NSString *desc;
/// 价格
@property (nonatomic, assign) CGFloat price;

/**
 *  Cell展示所需要的高度
 *
 *  @param desc 介绍文字
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithDesc:(NSString *)desc;
+ (NSString *)reuseIdentifier;

/// 回调：用户点击了购买按钮
- (void)buyClickBlock:(BuyClickBlock)block;

@end
