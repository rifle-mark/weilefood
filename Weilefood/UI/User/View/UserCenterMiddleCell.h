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

+ (NSString*)reuseIdentify;

- (void)onShareClickBlock:(OnShareClickBlock)block;
- (void)onMsgClickBlock:(OnMsgClickBlock)block;
- (void)onShopCarClickBlock:(OnShopCarClickBlock)block;
@end
