//
//  InputView.h
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 表单输入项(统一样式)
@interface InputView : UIView

/// 标题对象
@property (nonatomic, strong, readonly) UILabel *titleLabel;
/// 输入框对象
@property (nonatomic, strong, readonly) UITextField *textField;
/// 标题所占宽度。默认0自动宽度
@property (nonatomic, assign) NSInteger titleWidth;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
