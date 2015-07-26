//
//  MainPageCollectionHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MainPageCollectionHeaderView.h"

@interface MainPageCollectionHeaderView ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *allButton;

@end

@implementation MainPageCollectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(@0);
    }];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(@0);
    }];
}

- (void)_allButtonAction {
    GCBlockInvoke(self.allButtonActionBlock);
}

#pragma mark - private property methons

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_allButton setTitle:@"全部 >" forState:UIControlStateNormal];
        [_allButton addTarget:self action:@selector(_allButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

@end
