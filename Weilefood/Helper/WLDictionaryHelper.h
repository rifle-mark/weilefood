//
//  WLDictionaryHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDictionaryHelper : NSObject

/**
 *  处理服务端返回的JSON数据，主要是日期数据转换
 *
 *  @param dic 服务端返回的JSON字典
 *
 *  @return 处理数据后的字典
 */
+ (NSDictionary *)validModelDictionary:(NSDictionary *)dic;

@end
