//
//  MainPageCollectionHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MainPageCollectionHeaderView.h"

@interface MainPageCollectionHeaderView ()

@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *allButton;

@end

static NSInteger const kLineHieght  = 8;
static NSInteger const kTitleHeight = 45;

@implementation MainPageCollectionHeaderView

+ (NSInteger)viewHeight {
    return kLineHieght + kTitleHeight;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.allButton];
        
        [self _makeConstraints];
    }
    return self;
}

#pragma mark - public property methons

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

#pragma mark - private methons

- (void)_makeConstraints {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(kLineHieght));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self);
    }];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.bottom.equalTo(self.titleLabel);
    }];
}

- (void)_allButtonAction {
    GCBlockInvoke(self.allButtonActionBlock);
}

#pragma mark - private property methons

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = k_COLOR_DIMGRAY;
    }
    return _titleLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_allButton setImage:[UIImage imageNamed:@"mainpage_all_icon_n"] forState:UIControlStateNormal];
        [_allButton setImage:[UIImage imageNamed:@"mainpage_all_icon_h"] forState:UIControlStateHighlighted];
        // 图标居右
        [_allButton sizeToFit];
        _allButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_allButton.imageView.frame.size.width - 4, 0, _allButton.imageView.frame.size.width + 4);
        _allButton.imageEdgeInsets = UIEdgeInsetsMake(0, _allButton.titleLabel.frame.size.width, 0, -_allButton.titleLabel.frame.size.width);
        
        [_allButton addTarget:self action:@selector(_allButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

@end
