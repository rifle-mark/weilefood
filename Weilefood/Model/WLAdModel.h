//
//  WLAdModel.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 广告目标类型
typedef NS_ENUM(NSUInteger, WLAdType) {
    /// 分享
    WLAdTypeShare = 1,
    /// 市集产品
    WLAdTypeProduct = 2,
    /// 活动
    WLAdTypeActivity = 3,
    /// 预购
    WLAdTypeForwardBuy = 4,
    /// 营养推荐
    WLAdTypeNutrition = 5,
    /// 主题视频
    WLAdTypeVideo = 6,
    /// 链接广告
    WLAdTypeUrl = 7,
    /// 无链接广告
    WLAdTypeNoUrl = 8,
    /// 营养师
    WLAdTypeDietitians = 9,
};

/// 广告
@interface WLAdModel : NSObject

/// ID
@property (nonatomic, assign) NSUInteger adId;
/// 目标类型
@property (nonatomic, assign) WLAdType type;
/// 排序 从大到小排序
@property (nonatomic, assign) NSUInteger orderNum;
/// 对应的编号（根据Type访问对应的详情接口）
@property (nonatomic, assign) NSUInteger refId;
/// 名称
@property (nonatomic, copy) NSString *name;
/// 图片
@property (nonatomic, copy) NSString *images;
/// 如果Type为7，连接广告，则使用此字段
@property (nonatomic, copy) NSString *url;
///
@property (nonatomic, copy) NSDate *createDate;
///
@property (nonatomic, assign) NSInteger state;
///
@property (nonatomic, assign) NSInteger isDeleted;

@end
