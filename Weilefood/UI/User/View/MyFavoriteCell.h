//
//  MyFavoriteCell.h
//  Weilefood
//
//  Created by kelei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 我的收藏Cell
@interface MyFavoriteCell : UITableViewCell

/// 类型名称
@property (nonatomic, copy  ) NSString *type;
/// 类型文字颜色
@property (nonatomic, strong) UIColor  *typeColor;
/// 标题
@property (nonatomic, copy  ) NSString *title;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

@end
