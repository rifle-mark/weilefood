//
//  WLServerHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  服务端HTTP接口对象
 */
@interface WLServerHelper : NSObject

/// 当前登录用户token
@property (nonatomic, copy) NSString *token;

/// 单例方法
+ (instancetype)sharedInstance;

/**
 *  获取API链接地址
 *
 *  @param urlPaths 链接路径
 *
 *  @return
 */
- (NSString *)getApiUrlWithPaths:(NSArray *)urlPaths;

/**
 *  AFNetworking实例，在http header上加了内容
 *
 *  @return AFNetworking实例
 */
- (AFHTTPRequestOperationManager *)httpManager;

@end
