//
//  WLServerHelper+Channel.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

/// 栏目类型
typedef NS_ENUM(NSUInteger, WLChannelType);

@interface WLServerHelper (Channel)

/**
 *  获取栏目列表。市集栏目 或 预购栏目。(NSArray<WLChannelModel>)apiResult
 *
 *  @param type     市集栏目 或 预购栏目
 *  @param callback
 */
- (void)channel_getListWithType:(WLChannelType)type callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
