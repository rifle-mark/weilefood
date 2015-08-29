//
//  UserCenterUserInfoCell.h
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnUserInfoImageClickBlock)();
typedef void(^OnUserInfoPointClickBlock)();

@interface UserCenterUserInfoCell : UITableViewCell

+ (NSString*)reuseIdentify;

- (void)onImageClickBlock:(OnUserInfoImageClickBlock)block;
- (void)onPointClickBlock:(OnUserInfoPointClickBlock)block;
@end
