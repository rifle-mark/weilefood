//
//  WLServerHelper+Ad.h
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@interface WLServerHelper (Ad)

/**
 *  获取广告列表。(NSArray<WLAdModel>)apiResult
 *
 *  @param callback
 */
- (void)ad_getListWithCallback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
