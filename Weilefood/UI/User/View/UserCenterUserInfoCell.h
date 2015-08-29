//
//  UserCenterUserInfoCell.h
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLUserModel;

typedef void(^OnUserInfoImageClickBlock)();
typedef void(^OnUserInfoPointClickBlock)();

@interface UserCenterUserInfoCell : UITableViewCell

@property(nonatomic,strong)WLUserModel  *user;

+ (NSString*)reuseIdentify;

- (void)onImageClickBlock:(OnUserInfoImageClickBlock)block;
- (void)onPointClickBlock:(OnUserInfoPointClickBlock)block;
@end
