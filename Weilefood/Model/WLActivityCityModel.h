//
//  WLActivityCityModel.h
//  Weilefood
//
//  Created by kelei on 15/8/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 活动开通城市
@interface WLActivityCityModel : NSObject

/// ID
@property (nonatomic, assign) long long activityCityId;
/// 名称
@property (nonatomic, copy) NSString *city;

@end
