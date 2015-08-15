//
//  WLNutritionModel.h
//  Weilefood
//
//  Created by kelei on 15/8/5.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 营养推荐
@interface WLNutritionModel : NSObject

/// ID
@property (nonatomic, assign) long long classId;
/// 图片
@property (nonatomic, copy) NSString *images;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 介绍
@property (nonatomic, copy) NSString *desc;
/// 赞数
@property (nonatomic, assign) long long actionCount;
/// 评论数
@property (nonatomic, assign) long long commentCount;
/// 是否已收藏
@property (nonatomic, assign) BOOL isFav;
/// 是否已赞
@property (nonatomic, assign) BOOL isLike;
///
@property (nonatomic, assign) NSInteger type;
///
@property (nonatomic, copy) NSString *createDate;

@end
