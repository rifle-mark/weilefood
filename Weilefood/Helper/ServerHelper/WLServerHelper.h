//
//  WLServerHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const API_RESULT_KEYNAME;
extern NSString * const API_RESULT_ITEMS_KEYNAME;

@class WLApiInfoModel;

/**
 *  服务端HTTP接口对象
 */
@interface WLServerHelper : NSObject

/// 当前登录用户Token
@property (nonatomic, copy) NSString *userToken;

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

/**
 *  GET网络接口，只返回ApiInfo信息
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param callback
 */
- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  POST网络接口，只返回ApiInfo信息
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param callback
 */
- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  GET访问有result对象接口，返回 ApiInfo 和 指定类型的result对象
 *
 *  @param url         请求地址
 *  @param parameters  请求参数
 *  @param resultClass 指定result数据对象的类
 *  @param callback
 */
- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback;

/**
 *  POST访问有result对象接口，返回 ApiInfo 和 指定类型的result对象
 *
 *  @param url         请求地址
 *  @param parameters  请求参数
 *  @param resultClass 指定result数据对象的类
 *  @param callback
 */
- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback;

/**
 *  GET访问列表接口，返回 ApiInfo 和 指定数组元素类型的result数组
 *
 *  @param url              请求地址
 *  @param parameters       请求参数
 *  @param resultArrayClass 指定数组元素类型
 *  @param callback
 */
- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters resultArrayClass:(Class)resultArrayClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  POST访问列表接口，返回 ApiInfo 和 指定数组元素类型的result数组
 *
 *  @param url              请求地址
 *  @param parameters       请求参数
 *  @param resultArrayClass 指定数组元素类型
 *  @param callback
 */
- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters resultArrayClass:(Class)resultArrayClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  GET访问列表接口，返回 ApiInfo 和 指定数组元素类型的result.items数组
 *
 *  @param url              请求地址
 *  @param parameters       请求参数
 *  @param resultItemsClass 指定数组元素类型
 *  @param callback
 */
- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

/**
 *  POST访问列表接口，返回 ApiInfo 和 指定数组元素类型的result.items数组
 *
 *  @param url              请求地址
 *  @param parameters       请求参数
 *  @param resultItemsClass 指定数组元素类型
 *  @param callback
 */
- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
