//
//  WLActionModel.h
//  Weilefood
//
//  Created by kelei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 点赞/收藏 目标对象的类型
typedef NS_ENUM(NSInteger, WLActionType) {
    /// 所有/其它
    WLActionTypeAll = 0,
    /// 分享
    WLActionTypeShare = 1,
    /// 市集产品
    WLActionTypeProduct = 2,
    /// 活动
    WLActionTypeActivity = 3,
    /// 预购
    WLActionTypeForwardBuy = 4,
    /// 营养推荐
    WLActionTypeNutrition = 5,
    /// 主题视频
    WLActionTypeVideo = 6,
    /// 营养师
    WLActionTypeDoctor = 7,
};

/// 点赞/收藏
typedef NS_ENUM(NSInteger, WLActionActType) {
    /// 点赞
    WLActionActTypeApproval = 1,
    /// 收藏
    WLActionActTypeFavorite = 2,
};

/// 赞/收藏 活动
@interface WLActionModel : NSObject

/// ID
@property (nonatomic, assign) long long actionId;
/// 赞/收藏
@property (nonatomic, assign) WLActionActType actType;
/// 关联对象类型
@property (nonatomic, assign) WLActionType type;
/// 关联对象ID
@property (nonatomic, assign) long long refId;
/// 标题
@property (nonatomic, copy) NSString *remark;

@property (nonatomic, strong) NSDate *createDate;

@property (nonatomic, copy) NSString *actName;

@property (nonatomic, assign) long long actUserId;

@property (nonatomic, copy) NSString *ip;

@end
