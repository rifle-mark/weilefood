//
//  WLServerHelper+AppVersion.h
//  Weilefood
//
//  Created by kelei on 15/9/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLAppVersionModel;

@interface WLServerHelper (AppVersion)

/**
 *  获取应用最新版本信息
 *
 *  @param callback
 */
- (void)appVersion_getWithCallback:(void(^)(WLApiInfoModel* apiInfo, WLAppVersionModel *apiResult, NSError *error))callback;

@end
