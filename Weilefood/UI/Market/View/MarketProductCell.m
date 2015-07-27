//
//  MarketProductCell.m
//  Weilefood
//
//  Created by kelei on 15/7/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MarketProductCell.h"

@interface MarketProductCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *numberLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UILabel     *actionCountLabel;
@property (nonatomic, strong) UILabel     *commentCountLabel;

@end

@implementation MarketProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.actionCountLabel];
        [self.contentView addSubview:self.commentCountLabel];
        
        [self _makeConstraints];
    }
    return self;
}

#pragma mark - public property methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@" 剩余：%ld份 ", number];
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
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@100);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.picImageView.mas_bottom).offset(10);
        make.height.equalTo(@(self.nameLabel.font.lineHeight));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.equalTo(@(self.numberLabel.font.lineHeight + 6));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.height.equalTo(@(self.priceLabel.font.lineHeight));
    }];
    [self.actionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.numberLabel.mas_bottom).offset(10);
        make.bottomMargin.equalTo(@-10);
    }];
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.actionCountLabel.mas_right).offset(10);
        make.centerY.equalTo(self.actionCountLabel);
    }];
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nameLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.backgroundColor = [UIColor blueColor];
        _numberLabel.layer.cornerRadius = 10;
    }
    return _numberLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:16];
        _priceLabel.textColor = [UIColor yellowColor];
    }
    return _priceLabel;
}

- (UILabel *)actionCountLabel {
    if (!_actionCountLabel) {
        _actionCountLabel = [[UILabel alloc] init];
        _actionCountLabel.font = [UIFont systemFontOfSize:12];
        _actionCountLabel.textColor = [UIColor grayColor];
    }
    return _actionCountLabel;
}

- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.font = [UIFont systemFontOfSize:12];
        _commentCountLabel.textColor = [UIColor grayColor];
    }
    return _commentCountLabel;
}

@end
