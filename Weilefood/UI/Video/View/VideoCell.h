//
//  VideoCell.h
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 视频列表 - 视频Cell
@interface VideoCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy    ) NSString  *imageUrl;
/// 名称
@property (nonatomic, copy    ) NSString  *name;
/// 赞数
@property (nonatomic, assign  ) NSInteger actionCount;
/// 评论数
@property (nonatomic, assign  ) NSInteger commentCount;
/// 是否已参加
@property (nonatomic, assign  ) NSInteger points;

@end
