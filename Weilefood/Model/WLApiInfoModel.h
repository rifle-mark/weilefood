//
//  WLApiInfoModel.h
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 服务端接口返回的标准信息
@interface WLApiInfoModel : NSObject

/// 接口获取数据是否成功
@property (nonatomic, assign) BOOL isSuc;
/// 获取失败时提示内容
@property (nonatomic, copy) NSString *message;

@end
