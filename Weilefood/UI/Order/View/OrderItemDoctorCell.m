//
//  OrderItemDoctorCell.m
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderItemDoctorCell.h"

@interface OrderItemDoctorCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *serviceNameLabel;
@property (nonatomic, strong) UILabel     *moneyLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

static NSInteger const kContentMargin = 11;
static NSInteger const kImageHeight = 100;
static NSInteger const kLineHeight = 7;

@implementation OrderItemDoctorCell

+ (CGFloat)cellHeight {
    return kContentMargin + kImageHeight + kContentMargin + kLineHeight;
}

+ (NSString *)reuseIdentifier {
    return @"OrderItemDoctorCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.serviceNameLabel];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)updateConstraints {
    [self.picImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kContentMargin));
        make.width.height.equalTo(@(kImageHeight));
    }];
    [self.serviceNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_right).offset(17);
        make.right.equalTo(self.contentView).offset(-kContentMargin);
        make.centerY.equalTo(self.picImageView);
    }];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.serviceNameLabel);
        make.bottom.equalTo(self.serviceNameLabel.mas_top).offset(-10);
    }];
    [self.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.serviceNameLabel);
        make.top.equalTo(self.serviceNameLabel.mas_bottom).offset(10);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(kLineHeight));
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.picImageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = [NSString stringWithFormat:@"营养师：%@", name];
}

- (void)setServiceName:(NSString *)serviceName {
    _serviceName = [serviceName copy];
    self.serviceNameLabel.text = [NSString stringWithFormat:@"购买服务：%@", serviceName];
}

- (void)setMoney:(CGFloat)money {
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f", money];
}

#pragma mark - private property methods

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.layer.cornerRadius = kImageHeight * 0.5;
        _picImageView.clipsToBounds = YES;
    }
    return _picImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textColor = k_COLOR_DIMGRAY;
    }
    return _nameLabel;
}

- (UILabel *)serviceNameLabel {
    if (!_serviceNameLabel) {
        _serviceNameLabel = [[UILabel alloc] init];
        _serviceNameLabel.font = [UIFont boldSystemFontOfSize:14];
        _serviceNameLabel.textColor = k_COLOR_DIMGRAY;
    }
    return _serviceNameLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:14];
        _moneyLabel.textColor = k_COLOR_ANZAC;
    }
    return _moneyLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

@end
