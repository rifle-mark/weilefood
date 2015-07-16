//
//  WLServerHelper+UploadImage.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

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

@interface WLServerHelper (UploadImage)

/**
 *  上传图片
 *
 *  @param imageData 图片NSData数据
 *  @param callback  完成时回调
 */
- (void)uploadImageWithImageData:(NSData *)imageData type:(WLServerUploadImageType)type callback:(void (^)(WLUploadImageModel *apiInfo, NSError *error))callback;

@end
