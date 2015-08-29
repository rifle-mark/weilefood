//
//  OrderItemHeaderCell.m
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderItemHeaderCell.h"
#import "OrderNumberAndDateView.h"

@interface OrderItemHeaderCell ()

@property (nonatomic, strong) OrderNumberAndDateView *numberAndDateView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation OrderItemHeaderCell

+ (CGFloat)cellHeight {
    return [OrderNumberAndDateView viewHeight];
}

+ (NSString *)reuseIdentifier {
    return @"OrderItemHeaderCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.numberAndDateView];
    }
    return self;
}

- (void)updateConstraints {
    [self.numberAndDateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (NSString *)orderNum {
    return self.numberAndDateView.orderNum;
}

- (void)setOrderNum:(NSString *)orderNum {
    self.numberAndDateView.orderNum = orderNum;
}

- (NSDate *)date {
    return self.numberAndDateView.date;
}

- (void)setDate:(NSDate *)date {
    self.numberAndDateView.date = date;
}

- (void)setRightLabelWithText:(NSString *)text {
    [self clearRightControl];
    self.rightView = ({
        UILabel *v = [[UILabel alloc] init];
        v.font = [UIFont boldSystemFontOfSize:15];
        v.textColor = k_COLOR_ORANGE;
        v.text = text;
        v;
    });
    [self.contentView addSubview:self.rightView];
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-11);
        make.centerY.equalTo(@0);
    }];
}

- (void)setRightButtonWithTitle:(NSString *)text actionBlock:(OrderItemHeaderCellRightButtonActionBlock)actionBlock {
    [self clearRightControl];
    _weak(self);
    self.rightView = ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.backgroundColor = k_COLOR_ORANGE;
        v.layer.cornerRadius = 4;
        v.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [v setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [v setTitle:text forState:UIControlStateNormal];
        [v addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(actionBlock, self);
        }];
        v;
    });
    [self.contentView addSubview:self.rightView];
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-11);
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(80, 32));
    }];
}

- (void)clearRightControl {
    [self.rightView removeFromSuperview];
    self.rightView = nil;
}

#pragma mark - private property methods

- (OrderNumberAndDateView *)numberAndDateView {
    if (!_numberAndDateView) {
        _numberAndDateView = [[OrderNumberAndDateView alloc] init];
    }
    return _numberAndDateView;
}

@end
