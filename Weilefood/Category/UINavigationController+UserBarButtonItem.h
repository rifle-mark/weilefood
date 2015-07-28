//
//  UINavigationController+UserBarButtonItem.h
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (UserBarButtonItem)

/**
 *  返回应用级别的“用户”NavigationBar按钮
 *
 *  @return 
 */
- (UIBarButtonItem *)createUserBarButtonItem;

@end
