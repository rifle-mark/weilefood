//
//  NutritionCell.h
//  Weilefood
//
//  Created by kelei on 15/8/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养推荐Cell
@interface NutritionCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString          *imageUrl;
/// 名称
@property (nonatomic, copy  ) NSString          *name;
/// 赞数
@property (nonatomic, assign) long long         actionCount;
/// 评论数
@property (nonatomic, assign) long long         commentCount;

/**
 *  cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

@end
