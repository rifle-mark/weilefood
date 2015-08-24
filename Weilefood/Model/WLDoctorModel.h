//
//  WLDoctorModel.h
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 营养师
@interface WLDoctorModel : NSObject

/// ID
@property (nonatomic, assign) long long doctorId;
/// 图片
@property (nonatomic, copy) NSString *images;
/// 姓名
@property (nonatomic, copy) NSString *trueName;
/// 星级1-5
@property (nonatomic, assign) NSInteger star;
/// 介绍(html格式)
@property (nonatomic, copy) NSString *desc;
/// 赞数
@property (nonatomic, assign) NSInteger actionCount;
/// 评论数
@property (nonatomic, assign) NSInteger commentCount;
/// 是否已收藏
@property (nonatomic, assign) BOOL isFav;
/// 是否已赞
@property (nonatomic, assign) BOOL isLike;
/// 提供的服务<WLDoctorServiceModel>
@property (nonatomic, strong) NSArray *service;
///
@property (nonatomic, assign) NSInteger state;
///
@property (nonatomic, strong) NSDate *createDate;
///
@property (nonatomic, copy) NSString *phoneNum;
///
@property (nonatomic, assign) NSInteger isRecommend;
///
@property (nonatomic, assign) long long adminId;

@end


/// 营养师服务项
@interface WLDoctorServiceModel : NSObject

/// ID
@property (nonatomic, assign) long long doctorServiceId;
/// 介绍
@property (nonatomic, copy) NSString *remark;
/// 名称
@property (nonatomic, copy) NSString *title;
/// 价格
@property (nonatomic, assign) CGFloat price;
/// 所属营养师ID
@property (nonatomic, assign) long long doctorId;
///
@property (nonatomic, assign) NSInteger isDeleted;

@end

