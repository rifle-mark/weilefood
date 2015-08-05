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
+ (WLUserModel *)user_find;

/**
 *  保存WLUserModel
 */
+ (void)user_save:(WLUserModel *)model;

/**
 *  删除WLUserModel
 */
+ (void)user_delete;

@end
