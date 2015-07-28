//
//  UINavigationController+UserBarButtonItem.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UINavigationController+UserBarButtonItem.h"

@implementation UINavigationController (UserBarButtonItem)

- (void)_userAction {
    DLog(@"");
}

- (UIBarButtonItem *)createUserBarButtonItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 26, 44);
    [btn setImage:[UIImage imageNamed:@"mainpage_user_icon_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"mainpage_user_icon_h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(_userAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
