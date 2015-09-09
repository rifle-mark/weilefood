//
//  UserCenterMiddleCell.h
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnShareClickBlock)();
typedef void(^OnMsgClickBlock)();
typedef void(^OnShopCarClickBlock)();

@interface UserCenterMiddleCell : UITableViewCell

/// 是否显示有新消息标记。默认=NO
@property (nonatomic, assign) BOOL displayNewMessage;

+ (NSString*)reuseIdentify;

- (void)onShareClickBlock:(OnShareClickBlock)block;
- (void)onMsgClickBlock:(OnMsgClickBlock)block;
- (void)onShopCarClickBlock:(OnShopCarClickBlock)block;
@end
