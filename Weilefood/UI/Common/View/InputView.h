//
//  InputView.h
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 表单输入项风格
typedef NS_ENUM(NSInteger, InputViewStyle){
    /// 单行(默认)
    InputViewStyleOneLine,
    /// 多行
    InputViewStyleMultiLine,
};

/// 表单输入项(统一样式)
@interface InputView : UIView

/// 标题对象
@property (nonatomic, strong, readonly) UILabel *titleLabel;
/// 输入框对象(InputViewStyleOneLine才有)
@property (nonatomic, strong, readonly) UITextField *textField;
/// 输入框对象(InputViewStyleMultiLine才有)
@property (nonatomic, strong, readonly) UITextView *textView;
/// 标题所占宽度。默认0自动宽度(InputViewStyleOneLine才有)
@property (nonatomic, assign) NSInteger titleWidth;

/**
 *  展示StyleOneLine风格所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeightOfStyleOneLine;

/**
 *  初始化本界面
 *
 *  @param style 风格
 *
 *  @return
 */
- (id)initWithStyle:(InputViewStyle)style;

@end
