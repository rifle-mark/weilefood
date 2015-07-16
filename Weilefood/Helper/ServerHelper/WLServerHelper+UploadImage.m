//
//  WLServerHelper+UploadImage.m
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+UploadImage.h"
#import "WLModelHeader.h"
#import "WLDictionaryHelper.h"

@implementation WLServerHelper (UploadImage)

- (void)uploadImageWithImageData:(NSData *)imageData type:(WLServerUploadImageType)type callback:(void (^)(WLUploadImageModel *apiInfo, NSError *error))callback {
    AFHTTPRequestOperationManager *manager = [self httpManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:kServerUploadImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
