//
//  WLServerHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLApiInfoModel;

typedef NS_ENUM(NSUInteger, WLServerHelperMode) {
    WLServerHelperModeGET,
    WLServerHelperModePOST,
};

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

/**
 *  访问一般接口，只返回ApiInfo信息
 *
 *  @param mode       请求方式GET/POST
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param callback
 */
- (void)httpMode:(WLServerHelperMode)mode url:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback;

/**
 *  访问有result对象接口，返回 ApiInfo 和 指定类型的result对象
 *
 *  @param mode        请求方式GET/POST
 *  @param url         请求地址
 *  @param parameters  请求参数
 *  @param resultClass 指定result数据对象的类
 *  @param callback
 */
- (void)httpMode:(WLServerHelperMode)mode url:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback;

/**
 *  访问列表接口，返回 ApiInfo 和 指定数组元素类型的result.items数组
 *
 *  @param mode             请求方式GET/POST
 *  @param url              请求地址
 *  @param parameters       请求参数
 *  @param resultItemsClass 指定数组元素类型
 *  @param callback
 */
- (void)httpMode:(WLServerHelperMode)mode url:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
