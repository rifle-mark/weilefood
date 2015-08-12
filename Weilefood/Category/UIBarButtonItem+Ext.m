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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                          target:nil
                                                                          action:nil];
    item.width = -10;
    return item;
}

- (void)_userAction {
    [LoginVC show];
}

+ (UIBarButtonItem *)createUserBarButtonItem {
    UIBarButtonItem *ret = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mainpage_user_icon_n"]
                                                            style:UIBarButtonItemStyleDone
                                                           target:nil
                                                           action:nil];
    ret.target = ret;
    ret.action = @selector(_userAction);
    return ret;
}

- (void)_closeAction {
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

+ (UIBarButtonItem *)createCloseBarButtonItem {
    UIBarButtonItem *ret = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_close"]
                                                            style:UIBarButtonItemStyleDone
                                                           target:nil
                                                           action:nil];
    ret.target = ret;
    ret.action = @selector(_closeAction);
    return ret;
}

- (void)_cartAction {
    DLog(@"");
}

+ (UIBarButtonItem *)createCartBarButtonItem {
    UIBarButtonItem *ret = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baritem_cart"]
                                                            style:UIBarButtonItemStyleDone
                                                           target:nil
                                                           action:nil];
    ret.target = ret;
    ret.action = @selector(_cartAction);
    return ret;
}

@end
