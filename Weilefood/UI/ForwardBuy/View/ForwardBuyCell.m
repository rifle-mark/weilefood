//
//  ForwardBuyCell.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ForwardBuyCell.h"

@interface ForwardBuyCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *statusLabel;
@property (nonatomic, strong) UILabel     *beginEndDateLabel;
@property (nonatomic, strong) UILabel     *nameLabel;
//@property (nonatomic, strong) UILabel     *numberLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UILabel     *actionCountLabel;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UILabel     *commentCountLabel;
@property (nonatomic, strong) UIView      *footerView;

@end

@implementation ForwardBuyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.beginEndDateLabel];
        [self.contentView addSubview:self.nameLabel];
//        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.actionImageView];
        [self.contentView addSubview:self.actionCountLabel];
        [self.contentView addSubview:self.commentImageView];
        [self.contentView addSubview:self.commentCountLabel];
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

- (void)setNumber:(NSInteger)number {
    _number = number;
//    self.numberLabel.text = [NSString stringWithFormat:@" 剩余：%ld份 ", number];
}

- (void)setPrice:(CGFloat)price {
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", price];
}

- (void)setActionCount:(NSUInteger)actionCount {
    _actionCount = actionCount;
    self.actionCountLabel.text = [NSString stringWithFormat:@"%ld", actionCount];
}

- (void)setCommentCount:(NSUInteger)commentCount {
    _commentCount = commentCount;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", commentCount];
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
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_baseline).offset(7);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.picImageView);
        make.centerY.equalTo(self.priceLabel);
    }];
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentCountLabel.mas_left).offset(-4);
        make.centerY.equalTo(self.priceLabel);
        make.size.mas_equalTo(self.commentImageView.image.size);
    }];
    [self.actionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.priceLabel);
    }];
    [self.actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.actionCountLabel.mas_left).offset(-4);
        make.centerY.equalTo(self.priceLabel);
        make.size.mas_equalTo(self.actionImageView.image.size);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
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

//- (UILabel *)numberLabel {
//    if (!_numberLabel) {
//        _numberLabel = [[UILabel alloc] init];
//        _numberLabel.font = [UIFont systemFontOfSize:12];
//        _numberLabel.textColor = [UIColor whiteColor];
//        _numberLabel.backgroundColor = [UIColor blueColor];
//        _numberLabel.layer.cornerRadius = 10;
//    }
//    return _numberLabel;
//}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:20];
        _priceLabel.textColor = k_COLOR_GOLDENROD;
    }
    return _priceLabel;
}

- (UIImageView *)actionImageView {
    if (!_actionImageView) {
        _actionImageView = [[UIImageView alloc] init];
        _actionImageView.image = [UIImage imageNamed:@"market_product_action_icon"];
    }
    return _actionImageView;
}

- (UILabel *)actionCountLabel {
    if (!_actionCountLabel) {
        _actionCountLabel = [[UILabel alloc] init];
        _actionCountLabel.font = [UIFont systemFontOfSize:10];
        _actionCountLabel.textColor = k_COLOR_DARKGRAY;
    }
    return _actionCountLabel;
}

- (UIImageView *)commentImageView {
    if (!_commentImageView) {
        _commentImageView = [[UIImageView alloc] init];
        _commentImageView.image = [UIImage imageNamed:@"market_product_comment_icon"];
    }
    return _commentImageView;
}

- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.font = [UIFont systemFontOfSize:10];
        _commentCountLabel.textColor = k_COLOR_DARKGRAY;
    }
    return _commentCountLabel;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _footerView;
}

@end