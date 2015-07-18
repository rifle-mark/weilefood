//
//  WLChannelModel.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 栏目类型
typedef NS_ENUM(NSUInteger, WLChannelType) {
    /// 市集产品栏目
    WLChannelTypeProduct    = 1,
    /// 预购栏目
    WLChannelTypeForwardBuy = 2,
};

/// 栏目
@interface WLChannelModel : NSObject

/// 栏目ID
@property (nonatomic, assign) NSUInteger channelId;
/// 栏目名
@property (nonatomic, copy) NSString *name;
/// 子栏目
@property (nonatomic, strong) NSArray *childChannel;
/// 类型
@property (nonatomic, assign) WLChannelType type;
///
@property (nonatomic, assign) NSUInteger parentId;
///
@property (nonatomic, copy) NSString *ico;

@end
