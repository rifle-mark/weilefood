//
//  DoctorInfoHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养师详情界面 - 头部分
@interface DoctorInfoHeaderView : UIView

/// 图片
@property (nonatomic, copy  ) NSString  *imageUrl;
/// 姓名
@property (nonatomic, copy  ) NSString  *name;
/// 星级
@property (nonatomic, assign) NSInteger score;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
