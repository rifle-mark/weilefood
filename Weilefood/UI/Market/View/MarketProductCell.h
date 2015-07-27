//
//  MarketProductCell.h
//  Weilefood
//
//  Created by kelei on 15/7/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 集市列表商品Cell
@interface MarketProductCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString   *imageUrl;
/// 名称
@property (nonatomic, copy  ) NSString   *name;
/// 剩余数量
@property (nonatomic, assign) NSInteger  number;
/// 单价
@property (nonatomic, assign) CGFloat    price;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 评论数
@property (nonatomic, assign) NSUInteger commentCount;

@end
