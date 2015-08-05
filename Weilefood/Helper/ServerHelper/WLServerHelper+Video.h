//
//  WLServerHelper+Video.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLVideoModel, WLVideoAdImageModel;

@interface WLServerHelper (Video)

/**
 *  获取视频栏目在首页和列表界面的广告图
 *
 *  @param callback
 */
- (void)video_getAdImageWithCallback:(void (^)(WLApiInfoModel *apiInfo, WLVideoAdImageModel *apiResult, NSError *error))callback;

/**
 *  获取主题视频详细信息
 *
 *  @param videoId  预购ID
 *  @param callback
 */
- (void)video_getInfoWithVideoId:(NSUInteger)videoId callback:(void (^)(WLApiInfoModel *apiInfo, WLVideoModel *apiResult, NSError *error))callback;

/**
 *  首页推荐主题视频列表。(NSArray<WLVideoModel>)apiResult
 *
 *  @param pageIndex 第几页数据，从1开始
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)video_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  主题视频列表。(NSArray<WLVideoModel>)apiResult
 *
 *  @param maxDate   加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)video_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
