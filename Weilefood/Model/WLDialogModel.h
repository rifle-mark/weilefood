//
//  WLDialogModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 私信会话对象
@interface WLDialogModel : NSObject

/// 编号，获取会话详情时需要使用
@property (nonatomic, assign) NSUInteger dialogId;
/// 对方UserId
@property (nonatomic, assign) NSUInteger followId;
/// 最后一条消息内容
@property (nonatomic, copy) NSString *content;
/// 对方昵称
@property (nonatomic, copy) NSString *nickName;
/// 对方头像
@property (nonatomic, copy) NSString *avatar;
/// 未读消息数量
@property (nonatomic, assign) NSInteger notReadCount;
/// 我的ID
@property (nonatomic, assign) NSUInteger userId;
///
@property (nonatomic, copy) NSDate *followDate;

@end
