//
//  VideoCell.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UILabel     *actionCountLabel;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UILabel     *commentCountLabel;
@property (nonatomic, strong) UIButton    *favoritedButton;
@property (nonatomic, strong) UIButton    *buyButton;
@property (nonatomic, strong) UIView      *footerView;

@end

@implementation VideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.actionImageView];
        [self.contentView addSubview:self.actionCountLabel];
        [self.contentView addSubview:self.commentImageView];
        [self.contentView addSubview:self.commentCountLabel];
        [self.contentView addSubview:self.favoritedButton];
        [self.contentView addSubview:self.buyButton];
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

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setActionCount:(NSInteger)actionCount {
    _actionCount = actionCount;
    self.actionCountLabel.text = [NSString stringWithFormat:@"%ld", actionCount];
}

- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", commentCount];
}

- (void)setPoints:(NSInteger)points {
    _points = points;
    NSString *title = [NSString stringWithFormat:@"观看积分%ld", points];
    [self.buyButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark - private methods

- (void)_makeConstraints {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.height.equalTo(self.picImageView.mas_width).multipliedBy(1.0 / 2.0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.picImageView);
        make.top.equalTo(self.picImageView.mas_bottom).offset(7);
        make.height.equalTo(@(self.nameLabel.font.lineHeight));
    }];
    [self.favoritedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_baseline).offset(10);
    }];
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favoritedButton.mas_right);
        make.top.equalTo(self.favoritedButton);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.picImageView);
        make.centerY.equalTo(self.favoritedButton);
    }];
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentCountLabel.mas_left).offset(-4);
        make.centerY.equalTo(self.favoritedButton);
        make.size.mas_equalTo(self.commentImageView.image.size);
    }];
    [self.actionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.favoritedButton);
    }];
    [self.actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.actionCountLabel.mas_left).offset(-4);
        make.centerY.equalTo(self.favoritedButton);
        make.size.mas_equalTo(self.actionImageView.image.size);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.favoritedButton.mas_bottom).offset(10);
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = k_COLOR_MAROOM;
    }
    return _nameLabel;
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

- (UIButton *)favoritedButton {
    if (!_favoritedButton) {
        _favoritedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoritedButton setTitleColor:k_COLOR_BLACK forState:UIControlStateNormal];
        [_favoritedButton setTitle:@"收藏" forState:UIControlStateNormal];
    }
    return _favoritedButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setTitleColor:k_COLOR_BLACK forState:UIControlStateNormal];
    }
    return _buyButton;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _footerView;
}

@end
