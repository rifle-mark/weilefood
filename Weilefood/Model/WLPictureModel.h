//
//  WLPictureModel.h
//  Weilefood
//
//  Created by kelei on 15/8/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 对象详情上的图片
@interface WLPictureModel : NSObject

/// 图片URL
@property (nonatomic, copy) NSString *picPath;
/// ID
@property (nonatomic, assign) long long productId;
/// 所属产品ID
@property (nonatomic, assign) long long productPictureId;

@end
