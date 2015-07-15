//
//  WLServerHelper.m
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"
#import "WLModelHeader.h"
#import "WLDictionaryHelper.h"

#import "NSString+Ext.h"

static NSString * const API_URL              = @"http://web.ifeicai.com/api";
static NSString * const API_UPDATE_IMAGE_URL = @"http://img.ifeicai.com/uploadimage.ashx";

static WLServerHelper *instance = nil;


@implementation WLServerHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - public methods

- (NSString *)getApiUrlWithPaths:(NSArray *)urlPaths {
    NSMutableString *ret = [NSMutableString stringWithString:API_URL];
    for (id item in urlPaths) {
        [ret appendFormat:@"/%@", item];
    }
    return ret;
}

- (AFHTTPRequestOperationManager *)httpManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:self.token forHTTPHeaderField:@"token"];
    return manager;
}

- (void)uploadImageWithImageData:(NSData *)imageData type:(WLServerUploadImageType)type callback:(void (^)(WLUploadImageModel *apiInfo, NSError *error))callback {
    AFHTTPRequestOperationManager *manager = [self httpManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:API_UPDATE_IMAGE_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *fileName = [NSString stringWithFormat:@"image.%@", type == WLServerUploadImageTypePNG ? @"png" : @"jpg"];
        NSString *mimeType = [NSString stringWithFormat:@"image/%@", type == WLServerUploadImageTypePNG ? @"png" : @"jpeg"];
        [formData appendPartWithFileData:imageData name:@"imgFile" fileName:fileName mimeType:mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLUploadImageModel *apiInfo = [WLUploadImageModel objectWithKeyValues:responseDic];
        GCBlockInvoke(callback, apiInfo, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, error);
    }];
}

@end
