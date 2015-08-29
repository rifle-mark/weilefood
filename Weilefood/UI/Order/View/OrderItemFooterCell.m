//
//  OrderItemFooterCell.m
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderItemFooterCell.h"

@interface OrderItemFooterCell ()

@property (nonatomic, strong) UILabel  *moneyLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView   *lineView;

@end

static NSInteger const kLabelHeight = 37;
static NSInteger const kLineHeight = 7;

@implementation OrderItemFooterCell

+ (CGFloat)cellHeight {
    return kLabelHeight + kLineHeight;
}

+ (NSString *)reuseIdentifier {
    return @"OrderItemFooterCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)updateConstraints {
    [self.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(@0);
        make.height.equalTo(@(kLabelHeight));
    }];
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-11);
        make.centerY.equalTo(self.moneyLabel);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(kLineHeight));
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (void)setMoney:(CGFloat)money {
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"总计：￥%.2f", money];
}

#pragma mark - private property methods

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        _moneyLabel.textColor = k_COLOR_DIMGRAY;
    }
    return _moneyLabel;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.enabled = NO;
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_button setTitle:@"查看详情" forState:UIControlStateNormal];
        [_button setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"discovery_all_icon_n"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"discovery_all_icon_h"] forState:UIControlStateHighlighted];
        [_button sizeToFit];
        _button.titleEdgeInsets = UIEdgeInsetsMake(0, -_button.imageView.frame.size.width - 4, 0, _button.imageView.frame.size.width + 4);
        _button.imageEdgeInsets = UIEdgeInsetsMake(0, _button.titleLabel.frame.size.width, 0, -_button.titleLabel.frame.size.width);
    }
    return _button;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

@end
