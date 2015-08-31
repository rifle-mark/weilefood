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
#import <SDWebImage/NSData+ImageContentType.h>

@implementation WLServerHelper (UploadImage)

- (void)uploadImageWithImageData:(NSData *)imageData callback:(void (^)(WLUploadImageModel *apiInfo, NSError *error))callback {
    if (!imageData) {
        GCBlockInvoke(callback, nil, [NSError errorWithDomain:@"参数imageData不能为空" code:-1 userInfo:nil]);
        return;
    }

    NSString *extName = [self _imageExtNameWithImageData:imageData];
    if (!extName) {
        GCBlockInvoke(callback, nil, [NSError errorWithDomain:@"不支持的图片文件格式" code:-2 userInfo:nil]);
        return;
    }
    
    [self _uploadImageWithUrlString:kServerUploadImageUrl imageData:imageData extName:extName mimeType:[NSData sd_contentTypeForImageData:imageData] callback:callback];
}

- (void)uploadAvatarWithImageData:(NSData *)imageData callback:(void(^)(WLUploadImageModel *apiInfo, NSError *error))callback {
    if (!imageData) {
        GCBlockInvoke(callback, nil, [NSError errorWithDomain:@"参数imageData不能为空" code:-1 userInfo:nil]);
        return;
    }
    
    NSString *extName = [self _imageExtNameWithImageData:imageData];
    if (!extName) {
        GCBlockInvoke(callback, nil, [NSError errorWithDomain:@"不支持的图片文件格式" code:-2 userInfo:nil]);
        return;
    }
    
    [self _uploadImageWithUrlString:kServerUploadAvatarUrl imageData:imageData extName:extName mimeType:[NSData sd_contentTypeForImageData:imageData] callback:callback];
}



#pragma mark - private
- (NSString *)_imageExtNameWithImageData:(NSData *)imageData {
    NSString *mimeType = [NSData sd_contentTypeForImageData:imageData];
    NSString *extName = nil;
    if ([mimeType isEqualToString:@"image/jpeg"]) {
        extName = @"jpg";
    }
    else if ([mimeType isEqualToString:@"image/png"]) {
        extName = @"png";
    }
    else if ([mimeType isEqualToString:@"image/gif"]) {
        extName = @"gif";
    }
    else if ([mimeType isEqualToString:@"image/tiff"]) {
        extName = @"tiff";
    }
    else if ([mimeType isEqualToString:@"image/webp"]) {
        extName = @"webp";
    }
    return extName;
}

- (void)_uploadImageWithUrlString:url imageData:(NSData*)imageData extName:(NSString *)extName mimeType:(NSString*)mimeType callback:(void(^)(WLUploadImageModel *apiInfo, NSError *error))callback {
    AFHTTPRequestOperationManager *manager = [self httpManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *fileName = [NSString stringWithFormat:@"image.%@", extName];
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
