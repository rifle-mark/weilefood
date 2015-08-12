//
//  LoginVC.h
//  Weilefood
//
//  Created by kelei on 15/7/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLUserModel;

typedef void(^LoggedBlock)(WLUserModel *user);

@interface LoginVC : UIViewController

/**
 *  弹出登录界面
 */
+ (void)show;

/**
 *  检查是否已登录。已登录：执行block；未登录：弹出登录界面，登录后执行block
 *
 *  @param block 登录成功后的block
 */
+ (void)needsLoginWithLoggedBlock:(LoggedBlock)block;

@end
