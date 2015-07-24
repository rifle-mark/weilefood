//
//  MBProgressHUD+Message.h
//  LawyerCenter
//
//  Created by kelei on 15/7/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Message)

/**
 *  显示成功消息
 *
 *  @param view    消息框容器
 *  @param message 消息内容。可以为nil
 */
+ (void)showSuccessWithView:(UIView *)view message:(NSString *)message;

/**
 *  显示错误消息
 *
 *  @param view    消息框容器
 *  @param message 消息内容。不能为nil
 */
+ (void)showErrorWithView:(UIView *)view message:(NSString *)message;

@end
