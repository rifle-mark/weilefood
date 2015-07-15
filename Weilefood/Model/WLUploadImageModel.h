//
//  WLUploadImageModel.h
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUploadImageModel : NSObject
/// 错误码。0无错误
@property (nonatomic, assign) NSInteger error;
/// 图片上传成功后的链接地址
@property (nonatomic, copy) NSString *url;
/// 错误描述
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *md5value;
@end
