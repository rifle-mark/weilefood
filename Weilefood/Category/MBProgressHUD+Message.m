//
//  MBProgressHUD+Message.m
//  LawyerCenter
//
//  Created by kelei on 15/7/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MBProgressHUD+Message.h"

@implementation MBProgressHUD (Message)

+ (void)showSuccessWithMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.labelText = message;
    [hud show:YES];
    [hud hide:YES afterDelay:3];
}

+ (void)showErrorWithMessage:(NSString *)message {
    NSParameterAssert(message);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud show:YES];
    [hud hide:YES afterDelay:3];
}

@end
