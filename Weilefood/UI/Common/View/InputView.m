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
}

@end

static NSInteger const kViewHeight = 40;

@implementation InputView

+ (CGFloat)viewHeight {
    return kViewHeight;
}

- (id)init {
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = k_COLOR_WHITESMOKE;
        self.layer.cornerRadius = 4;
        _titleWidth = 0;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
    }
    return self;
}

- (void)updateConstraints {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.titleLabel.hidden) {
            return;
        }
        make.left.equalTo(self).offset(15);
        make.top.bottom.equalTo(self);
        make.height.equalTo(@(kViewHeight));
        if (self.titleWidth != 0) {
            make.width.equalTo(@(self.titleWidth));
        }
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.textField.hidden) {
            return;
        }
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self).offset(-15);
        make.top.bottom.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = k_COLOR_DIMGRAY;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
    }
    return _textField;
}

- (void)setTitleWidth:(NSInteger)titleWidth {
    _titleWidth = titleWidth;
    [self setNeedsUpdateConstraints];
}

@end
