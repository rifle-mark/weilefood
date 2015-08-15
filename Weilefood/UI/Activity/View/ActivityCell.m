//
//  ActivityCell.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ActivityCell.h"
#import "WLModelHeader.h"

@interface ActivityCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel     *beginEndDateLabel;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UILabel     *participatedLabel;
@property (nonatomic, strong) UIView      *footerView;

@end

@implementation ActivityCell

+ (CGFloat)cellHeight {
    return 10 + (V_W_([UIApplication sharedApplication].keyWindow) - 20) * 2.0 / 3.0 + 65;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.statusImageView];
        [self.contentView addSubview:self.beginEndDateLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.participatedLabel];
        [self.contentView addSubview:self.footerView];
        
        [self _makeConstraints];
    }
    return self;
}

#pragma mark - public property methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.picImageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
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

- (void)setParticipated:(BOOL)participated {
    _participated = participated;
    self.lineView.hidden = !participated;
    self.participatedLabel.hidden = !participated;
}

- (void)setState:(WLActivityState)state {
    _state = state;
    switch (state) {
        case WLActivityStateNotStarted:
            self.statusImageView.image = [UIImage imageNamed:@"item_state_notStarted"];
            break;
        case WLActivityStateEnded:
            self.statusImageView.image = [UIImage imageNamed:@"item_state_ended"];
            break;
        default:
            self.statusImageView.image = [UIImage imageNamed:@"item_state_started"];
            break;
    }
}

#pragma mark - private methods

- (void)_makeConstraints {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.height.equalTo(self.picImageView.mas_width).multipliedBy(1.0 / 2.0);
    }];
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.picImageView).offset(10);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.picImageView);
        make.top.equalTo(self.picImageView.mas_bottom).offset(7);
        make.height.equalTo(@(self.nameLabel.font.lineHeight));
    }];
    [self.beginEndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beginEndDateLabel.mas_right).offset(5);
        make.top.bottom.equalTo(self.beginEndDateLabel);
        make.width.equalTo(@1);
    }];
    [self.participatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(5);
        make.top.bottom.equalTo(self.lineView);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.beginEndDateLabel.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@8);
    }];
}

- (void)_refeashDateAndStatusLabel {
    self.beginEndDateLabel.text = [NSString stringWithFormat:@"活动时间：%@ — %@", [self.beginDate formattedDateWithFormat:@"MM.dd"], [self.endDate formattedDateWithFormat:@"MM.dd"]];
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

- (UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [[UIImageView alloc] init];
    }
    return _statusImageView;
}

- (UILabel *)beginEndDateLabel {
    if (!_beginEndDateLabel) {
        _beginEndDateLabel = [[UILabel alloc] init];
        _beginEndDateLabel.font = [UIFont systemFontOfSize:13];
        _beginEndDateLabel.textColor = k_COLOR_STAR_DUST;
    }
    return _beginEndDateLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = k_COLOR_MAROOM;
    }
    return _nameLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

- (UILabel *)participatedLabel {
    if (!_participatedLabel) {
        _participatedLabel = [[UILabel alloc] init];
        _participatedLabel.font = [UIFont systemFontOfSize:13];
        _participatedLabel.textColor = k_COLOR_GOLDENROD;
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
