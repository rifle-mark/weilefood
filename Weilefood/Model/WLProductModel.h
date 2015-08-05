//
//  WLProductModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 市集产品
@interface WLProductModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger productId;
/// 名称
@property (nonatomic, copy) NSString *productName;
/// 数量
@property (nonatomic, assign) NSUInteger count;
/// 图片
@property (nonatomic, copy) NSString *images;
/// 价格
@property (nonatomic, assign) CGFloat price;
/// 赞数
@property (nonatomic, assign) NSUInteger actionCount;
/// 评论数
@property (nonatomic, assign) NSUInteger commentCount;
/// 描述
@property (nonatomic, copy) NSString *desc;
/// 所属栏目ID
@property (nonatomic, assign) NSUInteger channelId;
/// 所属栏目名称
@property (nonatomic, copy) NSString *channelName;
/// 幻灯片图组(详情接口)
@property (nonatomic, strong) NSArray *pictures;
///
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, assign) NSInteger isRecommend;
///
@property (nonatomic, assign) NSInteger isDeleted;

@end


/// 产品图片对象
@interface WLProductPictureModel : NSObject

/// 图片URL
@property (nonatomic, copy) NSString *picPath;
/// ID
@property (nonatomic, assign) long long productId;
/// 所属产品ID
@property (nonatomic, assign) long long productPictureId;

@end