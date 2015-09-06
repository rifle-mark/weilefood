//
//  UIApplication+Ext.h
//  LawyerCenter
//
//  Created by kelei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Ext)

/**
 *  获取应用当前正显示的ViewController
 *
 *  @return ViewController
 */
- (UIViewController *)currentViewController;

@end
