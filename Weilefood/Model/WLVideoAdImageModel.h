//
//  WLVideoAdImageModel.h
//  Weilefood
//
//  Created by kelei on 15/8/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 视频栏目在首页和列表界面的广告图
@interface WLVideoAdImageModel : NSObject

/// 首页图
@property (nonatomic, copy) NSString *videoIndexPic;
/// 列表界面图
@property (nonatomic, copy) NSString *videoListPic;
/// ID
@property (nonatomic, assign) long long systemConfigId;

@end
