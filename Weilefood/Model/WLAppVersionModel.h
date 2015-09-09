//
//  WLAppVersionModel.h
//  Weilefood
//
//  Created by kelei on 15/9/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLAppVersionModel : NSObject

/// 版本号
@property (nonatomic, copy) NSString *version;
/// 更新链接
@property (nonatomic, copy) NSString *url;
/// YES=强制升级
@property (nonatomic, assign) BOOL force;
/// 更新版本提示消息
@property (nonatomic, copy) NSString *message;

@end
