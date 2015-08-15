//
//  WLShareModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 分享
@interface WLShareModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger shareId;
/// 用户ID
@property (nonatomic, assign) NSUInteger userId;
/// 头像
@property (nonatomic, copy) NSString *avatar;
/// 昵称
@property (nonatomic, copy) NSString *nickName;
/// 多图url，以,字符分隔
@property (nonatomic, copy) NSString *images;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 回复数
@property (nonatomic, assign) NSUInteger commentCount;
/// 是否已收藏
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, assign) BOOL isLike;
///
@property (nonatomic, copy) NSDate *createDate;

@end
