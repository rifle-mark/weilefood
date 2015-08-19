//
//  WLCommentModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 评论对象的类型
typedef NS_ENUM(NSUInteger, WLCommentType) {
    /// 分享
    WLCommentTypeShare = 1,
    /// 市集产品
    WLCommentTypeProduct = 2,
    /// 活动
    WLCommentTypeActivity = 3,
    /// 预购
    WLCommentTypeForwardBuy = 4,
    /// 营养推荐
    WLCommentTypeNutrition = 5,
    /// 主题视频
    WLCommentTypeVideo = 6,
    /// 营养师
    WLCommentTypeDoctor = 7,
};

/// 评论
@interface WLCommentModel : NSObject

/// ID
@property (nonatomic, assign) long long commentId;
/// 发布者头像
@property (nonatomic, copy) NSString *avatar;
/// 发布者ID
@property (nonatomic, assign) long long userId;
/// 发布者昵称
@property (nonatomic, copy) NSString *nickName;
/// 回复用户ID
@property (nonatomic, assign) long long toUserId;
/// 回复用户昵称
@property (nonatomic, copy) NSString *toNickName;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 回复评论ID
@property (nonatomic, assign) long long parentId;
/// 评论时间
@property (nonatomic, copy) NSDate *createDate;
/// 评价对象ID
@property (nonatomic, assign) long long refId;
/// 评论对象类型
@property (nonatomic, assign) WLCommentType type;


@end
