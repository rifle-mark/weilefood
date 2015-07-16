//
//  WLServerHelper+Share.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLApiInfoModel, WLShareModel;

@interface WLServerHelper (Share)

/**
 *  添加分享
 *
 *  @param content  分享内容
 *  @param images   分享图片url，多图以,字符分隔
 *  @param callback
 */
- (void)share_addWithContent:(NSString *)content images:(NSString *)images callback:(void (^)(WLApiInfoModel *apiInfo, WLShareModel *apiResult, NSError *error))callback;

/**
 *  删除分享
 *
 *  @param shareId  要删除的分享ID
 *  @param callback
 */
- (void)share_deleteWithShareId:(NSUInteger)shareId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  举报分享
 *
 *  @param shareId  要举报的分享ID
 *  @param callback
 */
- (void)share_policeWithShareId:(NSUInteger)shareId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  获取分享列表
 *
 *  @param maxDate  加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pagesize 返回的最大记录数
 *  @param callback
 */
- (void)share_getListWithMaxDate:(NSDate *)maxDate pagesize:(NSUInteger)pagesize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  获取我的分享列表
 *
 *  @param maxDate  加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pagesize 返回的最大记录数
 *  @param callback
 */
- (void)share_getMyListWithMaxDate:(NSDate *)maxDate pagesize:(NSUInteger)pagesize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;


@end
