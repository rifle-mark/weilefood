//
//  WLServerHelper+UploadImage.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLUploadImageModel;

@interface WLServerHelper (UploadImage)

/**
 *  上传图片
 *
 *  @param callback  完成时回调
 */
- (void)uploadImageWithImageData:(NSData *)imageData callback:(void (^)(WLUploadImageModel *apiInfo, NSError *error))callback;

- (void)uploadAvatarWithImageData:(NSData *)imageData callback:(void(^)(WLUploadImageModel *apiInfo, NSError *error))callback;
@end
