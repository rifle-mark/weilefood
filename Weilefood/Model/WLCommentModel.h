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
@property (nonatomic, assign) NSUInteger commentId;
/// 头像
@property (nonatomic, copy) NSString *avatar;
/// 昵称
@property (nonatomic, copy) NSString *nickName;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 评论时间
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, assign) NSUInteger userId;
///
@property (nonatomic, assign) NSUInteger parentId;
///
@property (nonatomic, assign) NSUInteger refId;
///
@property (nonatomic, assign) WLCommentType type;

@end
