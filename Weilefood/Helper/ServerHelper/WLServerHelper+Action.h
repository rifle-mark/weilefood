//
//  WLServerHelper+Action.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

/// 点赞/收藏 目标对象的类型
typedef NS_ENUM(NSUInteger, WLActionType) {
    /// 分享
    WLActionTypeShare = 1,
    /// 市集产品
    WLActionTypeProduct = 2,
    /// 活动
    WLActionTypeActivity = 3,
    /// 预购
    WLActionTypeForwardBuy = 4,
    /// 课堂
    WLActionTypeClass = 5,
    /// 主题视频
    WLActionTypeVideo = 6,
};

/// 点赞/收藏
typedef NS_ENUM(NSUInteger, WLActionActType) {
    /// 点赞
    WLActionActTypeApproval = 1,
    /// 收藏
    WLActionActTypeFavorite = 2,
};

@interface WLServerHelper (Action)

/**
 *  点赞、收藏
 *
 *  @param type     目标对象的类型
 *  @param actType  点赞 或 收藏
 *  @param objectId 目标对象ID
 *  @param callback
 */
- (void)action_addWithType:(WLActionType)type actType:(WLActionActType)actType objectId:(NSUInteger)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

@end
