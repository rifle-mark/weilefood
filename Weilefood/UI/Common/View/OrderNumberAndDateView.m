//
//  OrderNumberAndDateView.m
//  Weilefood
//
//  Created by kelei on 15/8/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderNumberAndDateView.h"

@interface OrderNumberAndDateView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation OrderNumberAndDateView

+ (CGFloat)viewHeight {
    return 55;
}

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = k_COLOR_WHITESMOKE;
        [self addSubview:self.label];
    }
    return self;
}

- (void)updateConstraints {
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.centerY.equalTo(@0);
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (void)setOrderNum:(NSString *)orderNum {
    _orderNum = [orderNum copy];
    [self _resetNumberAndDateText];
}

- (void)setDate:(NSDate *)date {
    _date = date;
    [self _resetNumberAndDateText];
}

#pragma mark - private methods

- (void)_resetNumberAndDateText {
    NSString *dateStr = [self.date formattedDateWithFormat:@"yyyy年M月d日 HH:mm"];
    self.label.text = [NSString stringWithFormat:@"订单号：%@\n下单时间：%@", self.orderNum, dateStr];
}

#pragma mark - private property methods

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = k_COLOR_STAR_DUST;
        _label.numberOfLines = 2;
    }
    return _label;
}

@end
