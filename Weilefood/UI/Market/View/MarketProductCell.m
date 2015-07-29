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
@property (nonatomic, strong) UIImageView *tagImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
//@property (nonatomic, strong) UILabel     *numberLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UILabel     *actionCountLabel;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UILabel     *commentCountLabel;
@property (nonatomic, strong) UIView      *footerView;

@end

@implementation MarketProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.tagImageView];
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

- (void)setTagType:(MarketProductCellTag)tagType {
    _tagType = tagType;
    switch (tagType) {
        case MarketProductCellTagJXCP:
            self.tagImageView.image = [UIImage imageNamed:@"market_product_tag_JXCP"];
            break;
        case MarketProductCellTagLYTL:
            self.tagImageView.image = [UIImage imageNamed:@"market_product_tag_LYTL"];
            break;
        case MarketProductCellTagTSMS:
            self.tagImageView.image = [UIImage imageNamed:@"market_product_tag_TSMS"];
            break;
        case MarketProductCellTagYSBT:
            self.tagImageView.image = [UIImage imageNamed:@"market_product_tag_YSBT"];
            break;
        default:
            self.tagImageView.image = nil;
            break;
    }
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
        make.height.equalTo(self.picImageView.mas_width).multipliedBy(2.0 / 3.0);
    }];
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.picImageView).offset(10);
        make.size.mas_equalTo([UIImage imageNamed:@"market_product_tag_YSBT"].size);
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

#pragma mark - private property methods

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
    }
    return _picImageView;
}

- (UIImageView *)tagImageView {
    if (!_tagImageView) {
        _tagImageView = [[UIImageView alloc] init];
    }
    return _tagImageView;
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
