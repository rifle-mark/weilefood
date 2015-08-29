//
//  WLPointRulerModel.h
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLPointRulerModel : NSObject

/// 积分类型
@property (nonatomic, assign) NSInteger type;
/// 变化点数
@property (nonatomic, assign) NSInteger points;
/// 积分标题
@property (nonatomic, copy)NSString     *title;

@end
