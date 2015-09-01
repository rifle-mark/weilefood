//
//  UIScrollView+Keyboard.h
//  Sunflower
//
//  Created by kelei on 15/7/5.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (_Ext)

/**
 *  查找当前View中被激活的对象
 *
 *  @return 激活的对象
 */
- (instancetype)findFirstResponder;

/**
 *  传入view是当前view的subview(递归)
 *
 *  @param view 需要检查的view
 *
 *  @return YES:包含 NO:不包含
 */
- (BOOL)containsTheView:(UIView *)view;

/**
 *  返回当前view所在的ViewController
 *
 *  @return 当前view所在的ViewController
 */
- (UIViewController *)parentViewController;

@end

@interface UIScrollView (Keyboard)

/**
 *  自动处理弹出键盘后输入框的位置
 */
- (void)handleKeyboard;

@end
