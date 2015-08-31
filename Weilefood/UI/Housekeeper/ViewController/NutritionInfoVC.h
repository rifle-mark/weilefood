//
//  NutritionInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "TransparentNavigationBarVC.h"

@class WLNutritionModel;

/// 营养推荐详情
@interface NutritionInfoVC : TransparentNavigationBarVC

/**
 *  初始化此界面，并指定nutrition
 *
 *  @param nutrition 营养推荐
 *
 *  @return
 */
- (id)initWithNutrition:(WLNutritionModel *)nutrition;

@end
