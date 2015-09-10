//
//  UIBarButtonItem+Ext.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIBarButtonItem+Ext.h"
#import "LoginVC.h"
#import "UserCenterVC.h"
#import "ShoppingCartVC.h"

#import "WLDatabaseHelperHeader.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@implementation UIBarButtonItem (Ext)

+ (instancetype)createNavigationFixedItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                          target:nil
                                                                          action:nil];
    item.width = -10;
    return item;
}

- (void)_userAction {
}

+ (UIBarButtonItem *)createUserBarButtonItemWithVC:(UIViewController *)vc {
    
    UIImage *img_n = [UIImage imageNamed:@"mainpage_user_icon_n"];
    UIImage *img_h = [UIImage imageNamed:@"mainpage_user_icon_h"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, img_n.size.width, img_n.size.height);
    [btn setImage:img_n forState:UIControlStateNormal];
    [btn setImage:img_h forState:UIControlStateHighlighted];
    [btn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
        UIViewController *nc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([nc isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController *)nc) pushViewController:[[UserCenterVC alloc] init] animated:YES];
        }
        else {
            [nc.navigationController pushViewController:[[UserCenterVC alloc] init] animated:YES];
        }
    }];
    
    _weak(btn);
    [vc aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        _strong(btn);
        if (!btn) {
            return;
        }
        WLUserModel *user = [WLDatabaseHelper user_find];
        if (!user) {
            return;
        }
        [[WLServerHelper sharedInstance] user_hasUnreadWithCallback:^(WLApiInfoModel *apiInfo, BOOL hasUnreadMessage, BOOL hasUnreadReply, NSError *error) {
            if (error || !apiInfo.isSuc) {
                return;
            }
            _strong_check(btn);
            UIImage *img_n = [UIImage imageNamed:hasUnreadMessage || hasUnreadReply ? @"mainpage_user_icon_n_red" : @"mainpage_user_icon_n"];
            UIImage *img_h = [UIImage imageNamed:hasUnreadMessage || hasUnreadReply ? @"mainpage_user_icon_h_red" : @"mainpage_user_icon_h"];
            [btn setImage:img_n forState:UIControlStateNormal];
            [btn setImage:img_h forState:UIControlStateHighlighted];
        }];
    } error:NULL];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
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
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)vc) pushViewController:[[ShoppingCartVC alloc] init] animated:YES];
    }
    else {
        [vc.navigationController pushViewController:[[ShoppingCartVC alloc] init] animated:YES];
    }
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
