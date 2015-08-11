//
//  ActivityInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "TransparentNavigationBarVC.h"

@class WLActivityModel;

/// 活动详情界面
@interface ActivityInfoVC : TransparentNavigationBarVC

/**
 *  通过WLActivityModel实例化商品详情界面
 *
 *  @param activity
 *
 *  @return
 */
- (instancetype)initWithActivity:(WLActivityModel *)activity;

@end
