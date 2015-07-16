//
//  WLChannelModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 市集栏目信息
@interface WLChannelModel : NSObject
/// 栏目ID
@property (nonatomic, assign) NSUInteger channelId;
/// 栏目名
@property (nonatomic, copy) NSString *name;
/// 子栏目
@property (nonatomic, strong) NSArray *childChannel;
///
@property (nonatomic, assign) NSUInteger parentId;
///
@property (nonatomic, assign) NSInteger type;
///
@property (nonatomic, copy) NSString *ico;

@end
