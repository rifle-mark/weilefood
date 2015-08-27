//
//  MBProgressHUD+Message.m
//  LawyerCenter
//
//  Created by kelei on 15/7/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MBProgressHUD+Message.h"

@implementation MBProgressHUD (Message)

+ (instancetype)_sharedHUD {
    static MBProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithWindow:window];
        instance.removeFromSuperViewOnHide = YES;
    });
    if (!instance.superview) {
        [window addSubview:instance];
    }
    return instance;
}

+ (void)showSuccessWithMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[self alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.labelText = message;
    [hud show:YES];
    [hud hide:YES afterDelay:3];
}

+ (void)showErrorWithMessage:(NSString *)message {
    [self showErrorWithMessage:message completeBlock:nil];
}

+ (void)showErrorWithMessage:(NSString *)message completeBlock:(MBProgressHUDCompletionBlock)block {
    NSParameterAssert(message);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[self alloc] initWithWindow:window];
    [window addSubview:hud];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.completionBlock = block;
    [hud show:YES];
    [hud hide:YES afterDelay:3];
}

+ (void)showLoadingWithMessage:(NSString *)message {
    MBProgressHUD *hud = [self _sharedHUD];
    hud.userInteractionEnabled = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    [hud show:YES];
}

+ (void)hideLoading {
    MBProgressHUD *hud = [self _sharedHUD];
    [hud hide:YES];
}

@end
