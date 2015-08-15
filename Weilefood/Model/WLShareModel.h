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

/// 头像
@property (nonatomic, copy) NSString *avatar;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 多图url，以,字符分隔
@property (nonatomic, copy) NSString *images;
///
@property (nonatomic, assign) NSUInteger shareId;
///
@property (nonatomic, assign) NSUInteger userId;
/// 昵称
@property (nonatomic, copy) NSString *nickName;
/// 内容
@property (nonatomic, copy) NSString *content;
///
@property (nonatomic, copy) NSDate *createDate;
/**
 *  评论数
 */
@property (nonatomic, assign) NSUInteger commentCount;
/**
 *  是否收藏
 */
@property (nonatomic, assign) BOOL  isFav;

@end
