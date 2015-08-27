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
 *  @param message 消息内容。可以为nil
 */
+ (void)showSuccessWithMessage:(NSString *)message;

/**
 *  显示错误消息
 *
 *  @param message 消息内容。不能为nil
 */
+ (void)showErrorWithMessage:(NSString *)message;

/**
 *  显示错误消息，消失后执行block
 *
 *  @param message 消息内容。不能为nil
 *  @param block   执行block
 */
+ (void)showErrorWithMessage:(NSString *)message completeBlock:(MBProgressHUDCompletionBlock)block;

/**
 *  显示正在加载消息
 *
 *  @param message 消息内容。可以为nil
 */
+ (void)showLoadingWithMessage:(NSString *)message;
+ (void)hideLoading;


@end
