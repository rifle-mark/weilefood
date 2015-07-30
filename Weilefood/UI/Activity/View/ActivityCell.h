//
//  ActivityCell.h
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 活动列表 - 活动Cell
@interface ActivityCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy    ) NSString *imageUrl;
/// 预购开始时间
@property (nonatomic, strong  ) NSDate   *beginDate;
/// 预购结束时间
@property (nonatomic, strong  ) NSDate   *endDate;
/// 名称
@property (nonatomic, copy    ) NSString *name;
/// 城市
@property (nonatomic, copy    ) NSString *city;
/// 是否已参加
@property (nonatomic, assign  ) BOOL     participated;

@end
