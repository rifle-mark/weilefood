//
//  WLServerHelper+Message.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLMessageModel;

@interface WLServerHelper (Message)

/**
 *  发送私信
 *
 *  @param toUserId 对方ID
 *  @param content  消息内容
 *  @param callback
 */
- (void)message_addWithToUserId:(NSUInteger)toUserId content:(NSString *)content callback:(void (^)(WLApiInfoModel *apiInfo, WLMessageModel *apiResult, NSError *error))callback;

/**
 *  获取会话列表。(NSArray<WLDialogModel>)apiResult
 *
 *  @param maxDate  加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)message_getDialogListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取会话的消息列表。(NSArray<WLMessageModel>)apiResult
 *
 *  @param userId   用户ID
 *  @param maxDate  加载最新数据传nil，加载更多数据传lastItem.Date
 *  @param pageSize 返回的最大记录数
 *  @param callback
 */
- (void)message_getMessageListWithUserId:(NSUInteger)userId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
