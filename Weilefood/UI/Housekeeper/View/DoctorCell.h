//
//  DoctorCell.h
//  Weilefood
//
//  Created by kelei on 15/8/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养师Cell
@interface DoctorCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString   *imageUrl;
/// 姓名
@property (nonatomic, copy  ) NSString   *name;
/// 赞数
@property (nonatomic, assign) long long  actionCount;
/// 评论数
@property (nonatomic, assign) long long  commentCount;
/// 星级
@property (nonatomic, assign) NSInteger  score;
/// 简介
@property (nonatomic, copy  ) NSString   *desc;

/**
 *  cell展示所需要的高度
 *
 *  @param desc 简介
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithDesc:(NSString *)desc;
+ (NSString *)reuseIdentifier;

@end
