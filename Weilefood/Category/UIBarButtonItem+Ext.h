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
 *
 *  @return 
 */
+ (instancetype)createNavigationFixedItem;

@end
