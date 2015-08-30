//
//  InputView.m
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "InputView.h"

@interface InputView () {
    UILabel *_titleLabel;
    UITextField *_textField;
    UITextView *_textView;
    InputViewStyle _style;
}
@end

static NSInteger const kViewHeight = 40;
static NSInteger const kContentMargin = 15;
#define kFont [UIFont systemFontOfSize:14]

@implementation InputView

+ (CGFloat)viewHeightOfStyleOneLine {
    return kViewHeight;
}

- (id)init {
    if (self = [super init]) {
        _style = InputViewStyleOneLine;
        [self _init];
    }
    return self;
}

- (id)initWithStyle:(InputViewStyle)style {
    if (self = [super init]) {
        _style = style;
        [self _init];
    }
    return self;
}

- (void)_init {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = k_COLOR_WHITESMOKE;
    self.layer.cornerRadius = 4;
    _titleWidth = 0;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.textView];
}

- (void)updateConstraints {
    if (_style == InputViewStyleOneLine) {
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kContentMargin);
            make.top.bottom.equalTo(self);
            make.height.equalTo(@(kViewHeight));
            if (self.titleWidth != 0) {
                make.width.equalTo(@(self.titleWidth));
            }
        }];
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.right.equalTo(self).offset(-kContentMargin);
            make.top.bottom.equalTo(self);
        }];
    }
    else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(kContentMargin, kContentMargin, 0, kContentMargin));
        }];
        [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-kContentMargin);
            if (self.titleLabel.hidden) {
                make.top.equalTo(self.titleLabel);
            }
            else {
                make.top.equalTo(self.titleLabel.mas_baseline).offset(12);
            }
        }];
    }
    [super updateConstraints];
}

#pragma mark - public methods

- (InputViewStyle)style {
    return _style;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = k_COLOR_DIMGRAY;
        _titleLabel.font = kFont;
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField && _style == InputViewStyleOneLine) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFont;
        _textField.textColor = k_COLOR_BLACK;
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView && _style == InputViewStyleMultiLine) {
        _textView = [[UITextView alloc] init];
        _textView.font = kFont;
        _textView.textColor = k_COLOR_BLACK;
        _textView.backgroundColor = self.backgroundColor;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.textContainer.lineFragmentPadding = 0;
    }
    return _textView;
}

- (void)setTitleWidth:(NSInteger)titleWidth {
    _titleWidth = titleWidth;
    if (_style == InputViewStyleOneLine) {
        [self setNeedsUpdateConstraints];
    }
}

- (NSString *)text {
    return _style == InputViewStyleOneLine ? self.textField.text : self.textView.text;
}

- (void)setText:(NSString *)text {
    if (_style == InputViewStyleOneLine) {
        self.textField.text = text;
    }
    else {
        self.textView.text = text;
    }
}

@end
