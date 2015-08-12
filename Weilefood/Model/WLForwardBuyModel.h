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
@property (nonatomic, copy) NSDate *startDate;
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
/// 是否已收藏
@property (nonatomic, assign) BOOL isFav;
/// 所属栏目ID
@property (nonatomic, assign) NSUInteger channelId;
/// 所属栏目名称
@property (nonatomic, copy) NSString *channelName;
/// 幻灯片图组(详情接口)<WLPictureModel>
@property (nonatomic, strong) NSArray *pictures;
///
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, assign) NSInteger isDeleted;

@end
