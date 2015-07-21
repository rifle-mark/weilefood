//
//  WLMessageModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 私信消息对象
@interface WLMessageModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger messageId;
/// 所属会话ID
@property (nonatomic, assign) NSUInteger dialogId;
/// 是否已读
@property (nonatomic, assign) BOOL isRead;
/// 我的ID
@property (nonatomic, assign) NSUInteger userId;
/// 我的头像
@property (nonatomic, copy) NSString *userAvatar;
/// 我的昵称
@property (nonatomic, copy) NSString *userNickName;
/// 对方ID
@property (nonatomic, assign) NSUInteger toUserId;
/// 对方头像
@property (nonatomic, copy) NSString *toUserAvatar;
/// 对方昵称
@property (nonatomic, copy) NSString *toUserNickName;
/// 消息内容
@property (nonatomic, copy) NSString *content;
/// 发送时间
@property (nonatomic, copy) NSDate *createDate;

@end
