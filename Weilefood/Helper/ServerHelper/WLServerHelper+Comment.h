//
//  WLServerHelper+Comment.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

/// 评论对象的类型
typedef NS_ENUM(NSUInteger, WLCommentType);

@interface WLServerHelper (Comment)

/**
 *  添加评论
 *
 *  @param type     评论对象的类型
 *  @param refId    对象ID
 *  @param contnet  内容
 *  @param parentId 引用或回复评论ID
 *  @param callback
 */
- (void)comment_addWithType:(WLCommentType)type refId:(long long)refId content:(NSString *)content parentId:(long long)parentId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  删除评论
 *
 *  @param commentId 评论ID
 *  @param callback
 */
- (void)comment_deleteWithCommentId:(long long)commentId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  获取某对象的评论列表。(NSArray<WLCommentModel>)apiResult
 *
 *  @param type     评论对象的类型
 *  @param refId    对象ID
 *  @param maxDate  加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)comment_getListWithType:(WLCommentType)type refId:(long long)refId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取我的评论列表。(NSArray<WLCommentModel>)apiResult
 *
 *  @param type     评论对象的类型
 *  @param refId    对象ID
 *  @param maxDate  加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)comment_getMyListWithType:(WLCommentType)type refId:(long long)refId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取回复我的列表。(NSArray<WLCommentModel>)apiResult
 *
 *  @param maxDate  加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)comment_getReplyMeListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
