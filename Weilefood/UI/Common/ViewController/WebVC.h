//
//  WebVC.h
//  LawyerCenter
//
//  Created by kelei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 浏览器界面
@interface WebVC : UIViewController

/**
 *  初始化本界面
 *
 *  @param url 打开指定网页
 */
- (id)initWithTitle:(NSString *)title URL:(NSString *)url;

@end
