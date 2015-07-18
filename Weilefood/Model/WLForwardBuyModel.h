//
//  WLForwardBuyModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 预购
@interface WLForwardBuyModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger forwardBuyId;
/// 开始时间
@property (nonatomic, copy) NSString *startDate;
/// 结束时间
@property (nonatomic, copy) NSDate *endDate;
/// 图片
@property (nonatomic, copy) NSString *banner;
/// 名称
@property (nonatomic, copy) NSString *title;
/// 数量
@property (nonatomic, assign) NSUInteger count;
/// 价格
@property (nonatomic, assign) CGFloat price;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 评论数
@property (nonatomic, assign) NSUInteger commentCount;
/// 描述
@property (nonatomic, copy) NSString *desc;
///
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, assign) NSUInteger channelId;
///
@property (nonatomic, assign) NSInteger isDeleted;

@end
