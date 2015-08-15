//
//  ActivityInfoHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 活动详情界面 - 头部分
@interface ActivityInfoHeaderView : UIView

/// 活动图片
@property (nonatomic, copy    ) NSString *imageUrl;
/// 名称
@property (nonatomic, copy    ) NSString *title;
/// 开始时间
@property (nonatomic, strong  ) NSDate   *beginDate;
/// 结束时间
@property (nonatomic, strong  ) NSDate   *endDate;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
