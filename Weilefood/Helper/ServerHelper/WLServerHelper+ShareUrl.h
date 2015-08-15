//
//  WLServerHelper+ShareUrl.h
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

/// 分享对象类型
typedef NS_ENUM(NSInteger, WLServerHelperShareType) {
    /// 集市商品
    WLServerHelperShareTypeProduct,
    /// 活动
    WLServerHelperShareTypeActivity,
    /// 预购
    WLServerHelperShareTypeForwardBuy,
    /// 营养推荐
    WLServerHelperShareTypeNutrition,
    /// 主题视频
    WLServerHelperShareTypeVideo,
    /// 营养师
    WLServerHelperShareTypeDoctor,
};

/// 分享链接相关
@interface WLServerHelper (ShareUrl)

/**
 *  取得对象分享到公众平台的链接
 *
 *  @param type     分享对象类型
 *  @param objectId 对象ID
 *
 *  @return 链接
 */
- (NSString *)getShareUrlWithType:(WLServerHelperShareType)type objectId:(long long)objectId;

@end
