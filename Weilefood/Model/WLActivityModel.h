//
//  WLActivityModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 活动状态
typedef NS_ENUM(NSInteger, WLActivityState) {
    /// 已开始
    WLActivityStateStarted = 0,
    /// 未开始
    WLActivityStateNotStarted = 3,
    /// 已结束
    WLActivityStateEnded = 4,
};

/// 线上线下活动
@interface WLActivityModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger activityId;
/// 活动介绍
@property (nonatomic, copy) NSString *content;
/// 开始时间
@property (nonatomic, copy) NSDate *startDate;
/// 结束时间
@property (nonatomic, copy) NSDate *endDate;
/// 图片
@property (nonatomic, copy) NSString *banner;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 价格
@property (nonatomic, assign) CGFloat price;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 评论数
@property (nonatomic, assign) NSUInteger commentCount;
/// 线下活动城市
@property (nonatomic, copy) NSString *city;
/// 所属栏目ID
@property (nonatomic, assign) NSUInteger channelId;
/// 当前用户是否已参加
@property (nonatomic, assign) BOOL isJoin;
/// 活动状态
@property (nonatomic, assign) WLActivityState state;
///
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, assign) NSInteger isDeleted;

@end
