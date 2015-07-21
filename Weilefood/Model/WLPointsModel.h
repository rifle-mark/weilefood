//
//  WLPointsModel.h
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 积分记录
@interface WLPointsModel : NSObject

/// 积分类型
@property (nonatomic, assign) NSInteger type;
/// 积分日期
@property (nonatomic, copy) NSDate *createDate;
/// 变化点数
@property (nonatomic, assign) NSInteger points;
///
@property (nonatomic, assign) NSInteger experience;
///
@property (nonatomic, assign) NSUInteger userId;

@end
