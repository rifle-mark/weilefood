//
//  ActivityCell.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *statusLabel;
@property (nonatomic, strong) UILabel     *beginEndDateLabel;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *cityLabel;
@property (nonatomic, strong) UILabel     *participatedLabel;
@property (nonatomic, strong) UIView      *footerView;

@end

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.beginEndDateLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.cityLabel];
        [self.contentView addSubview:self.participatedLabel];
        [self.contentView addSubview:self.footerView];
        
        [self _makeConstraints];
    }
    return self;
}

#pragma mark - public property methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setBeginDate:(NSDate *)beginDate {
    _beginDate = beginDate;
    [self _refeashDateAndStatusLabel];
}

- (void)setEndDate:(NSDate *)endDate {
    _endDate = endDate;
    [self _refeashDateAndStatusLabel];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setCity:(NSString *)city {
    _city = [city copy];
    self.cityLabel.text = city;
}

- (void)setParticipated:(BOOL)participated {
    participated = participated;
    self.participatedLabel.hidden = !participated;
}

#pragma mark - private methods

- (void)_makeConstraints {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.height.equalTo(self.picImageView.mas_width).multipliedBy(1.0 / 2.0);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.picImageView).offset(10);
    }];
    [self.beginEndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView).offset(10);
        make.bottom.equalTo(self.picImageView).offset(-10);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.picImageView);
        make.top.equalTo(self.picImageView.mas_bottom).offset(7);
        make.height.equalTo(@(self.nameLabel.font.lineHeight));
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_baseline).offset(7);
    }];
    [self.participatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nameLabel);
        make.centerY.equalTo(self.cityLabel);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityLabel.mas_bottom).offset(8);
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@8);
    }];
}

- (void)_refeashDateAndStatusLabel {
    self.beginEndDateLabel.text = [NSString stringWithFormat:@"%@ 到 %@", [self.beginDate formattedDateWithFormat:@"yyyy-MM-dd"], [self.endDate formattedDateWithFormat:@"yyyy-MM-dd"]];
    NSDate *now = [NSDate date];
    if ([now isEarlierThan:self.beginDate]) {
        self.statusLabel.text = @"未开始";
    }
    else if ([now isLaterThan:self.endDate]) {
        self.statusLabel.text = @"已结束";
    }
    else {
        self.statusLabel.text = @"进行中";
    }
}

#pragma mark - private property methods

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
    }
    return _picImageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:12];
        _statusLabel.textColor = k_COLOR_WHITE;
    }
    return _statusLabel;
}

- (UILabel *)beginEndDateLabel {
    if (!_beginEndDateLabel) {
        _beginEndDateLabel = [[UILabel alloc] init];
        _beginEndDateLabel.font = [UIFont systemFontOfSize:14];
        _beginEndDateLabel.textColor = k_COLOR_WHITE;
    }
    return _beginEndDateLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = k_COLOR_MAROOM;
    }
    return _nameLabel;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:12];
        _cityLabel.textColor = k_COLOR_MAROOM;
    }
    return _cityLabel;
}

- (UILabel *)participatedLabel {
    if (!_participatedLabel) {
        _participatedLabel = [[UILabel alloc] init];
        _participatedLabel.font = [UIFont systemFontOfSize:12];
        _participatedLabel.textColor = k_COLOR_MAROOM;
        _participatedLabel.text = @"已参加";
    }
    return _participatedLabel;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _footerView;
}

@end
