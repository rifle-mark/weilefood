//
//  WLServerHelper+Action.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

/// 点赞/收藏 目标对象的类型
typedef NS_ENUM(NSInteger, WLActionType);
/// 点赞/收藏
typedef NS_ENUM(NSInteger, WLActionActType);

@interface WLServerHelper (Action)

/**
 *  点赞、收藏
 *
 *  @param objectType 目标对象的类型
 *  @param actType    点赞 或 收藏
 *  @param objectId   目标对象ID
 *  @param callback
 */
- (void)action_addWithActType:(WLActionActType)actType objectType:(WLActionType)objectType objectId:(long long)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  取消收藏
 *
 *  @param objectType 目标对象的类型
 *  @param objectId   目标对象ID
 *  @param callback
 */
- (void)action_deleteFavoriteWithObjectType:(WLActionType)objectType objectId:(long long)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  获取我的收藏列表。(NSArray<WLActionModel>)apiResult
 *
 *  @param type     关联对象类型。0=所有
 *  @param maxDate  加载最新数据传0，加载更多数据传列表最后一条数据的时间
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)action_myFavoriteListWithType:(WLActionType)type maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
