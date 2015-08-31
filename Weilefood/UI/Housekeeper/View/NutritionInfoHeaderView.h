//
//  NutritionInfoHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养推荐详情界面 - 头部分
@interface NutritionInfoHeaderView : UIView

/// 图片
@property (nonatomic, copy  ) NSString          *imageUrl;
/// 标题
@property (nonatomic, copy  ) NSString          *title;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
