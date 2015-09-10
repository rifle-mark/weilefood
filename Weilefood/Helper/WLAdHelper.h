//
//  WLAdHelper.h
//  Weilefood
//
//  Created by kelei on 15/9/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLAdModel;

@interface WLAdHelper : NSObject

/**
 *  打开广告详情
 *
 *  @param ad 广告对象
 */
+ (void)openWithAd:(WLAdModel *)ad;

@end
