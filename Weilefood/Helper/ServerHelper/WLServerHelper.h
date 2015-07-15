//
//  WLServerHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const API_RESULT_KEYNAME = @"result";

@class WLUploadImageModel;


/**
 *  服务端上传的图片类型
 */
typedef NS_ENUM(NSInteger, WLServerUploadImageType){
    /**
     *  PNG图片
     */
    WLServerUploadImageTypePNG,
    /**
     *  JPEG图片
     */
    WLServerUploadImageTypeJPEG,
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
 *  上传图片
 *
 *  @param imageData 图片NSData数据
 *  @param callback  完成时回调
 */
- (void)uploadImageWithImageData:(NSData *)imageData type:(WLServerUploadImageType)type callback:(void (^)(WLUploadImageModel *apiInfo, NSError *error))callback;

@end
