//
//  WLVideoModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 主题视频
@interface WLVideoModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger videoId;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 图片
@property (nonatomic, copy) NSString *images;
/// 视频地址
@property (nonatomic, copy) NSString *videoUrl;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 积分数
@property (nonatomic, assign) NSUInteger points;
/// 评论数
@property (nonatomic, assign) NSUInteger commentCount;
///
@property (nonatomic, assign) NSInteger isDeleted;
///
@property (nonatomic, assign) NSInteger isRecommend;
///
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, copy) NSString *desc;

@end
