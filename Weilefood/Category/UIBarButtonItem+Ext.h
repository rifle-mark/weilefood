//
//  UIBarButtonItem+Ext.h
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Ext)

/**
 *  返回NavigationBar上的FixedSpace，用于缩短按钮间距
 */
+ (instancetype)createNavigationFixedItem;

/**
 *  返回应用级别的“用户”BarButtonItem按钮
 */
+ (UIBarButtonItem *)createUserBarButtonItem;

/**
 *  返回应用级别的“关闭”BarButtonItem按钮
 */
+ (UIBarButtonItem *)createCloseBarButtonItem;

@end
