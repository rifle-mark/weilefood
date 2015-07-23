//
//  WLDatabaseHelper+User.h
//  Weilefood
//
//  Created by kelei on 15/7/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDatabaseHelper.h"

@class WLUserModel;

@interface WLDatabaseHelper (User)

/**
 *  查询WLUserModel
 */
+ (WLUserModel *)findUser;

/**
 *  保存WLUserModel
 */
+ (void)saveWithUser:(WLUserModel *)model;

/**
 *  删除WLUserModel
 */
+ (void)deleteUser;

@end
