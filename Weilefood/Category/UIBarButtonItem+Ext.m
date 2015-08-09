//
//  UIBarButtonItem+Ext.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIBarButtonItem+Ext.h"
#import "LoginVC.h"

@implementation UIBarButtonItem (Ext)

+ (instancetype)createNavigationFixedItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = -10;
    return item;
}

- (void)_userAction {
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:YES completion:nil];
}

+ (UIBarButtonItem *)createUserBarButtonItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 26, 44);
    [btn setImage:[UIImage imageNamed:@"mainpage_user_icon_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"mainpage_user_icon_h"] forState:UIControlStateHighlighted];
    UIBarButtonItem *ret = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:ret action:@selector(_userAction) forControlEvents:UIControlEventTouchUpInside];
    return ret;
}

- (void)_closeAction {
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

+ (UIBarButtonItem *)createCloseBarButtonItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 22);
    [btn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    UIBarButtonItem *ret = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:ret action:@selector(_closeAction) forControlEvents:UIControlEventTouchUpInside];
    return ret;
}

@end
