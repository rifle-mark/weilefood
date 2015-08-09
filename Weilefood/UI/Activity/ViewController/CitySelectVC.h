//
//  CitySelectVC.h
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLActivityCityModel;

typedef void (^SelectedCity)(WLActivityCityModel *activityCity);

/// 活动城市选择界面
@interface CitySelectVC : UIViewController

/**
 *  回调：用户选择了某个城市
 */
- (void)selectedCity:(SelectedCity)block;

@end
