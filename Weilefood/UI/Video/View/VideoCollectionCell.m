//
//  VideoCollectionCell.m
//  Weilefood
//
//  Created by kelei on 15/8/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "VideoCollectionCell.h"

@interface VideoCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *pointsLabel;
@property (nonatomic, strong) UIButton    *favoriteButton;

@property (nonatomic, copy) void (^favoriteBlock)(VideoCollectionCell *cell);

@end

/// Cell中图片高度=图片宽度*此数据
static CGFloat const kImageHeightScale = 0.788;

@implementation VideoCollectionCell

+ (CGFloat)cellHeightWithCellWidth:(CGFloat)cellWidth {
    return cellWidth * kImageHeightScale + 68;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.playImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.pointsLabel];
        [self.contentView addSubview:self.favoriteButton];
        
        [self _makeConstraints];
    }
    return self;
}

#pragma mark - public property methons

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)setPoints:(NSInteger)points {
    _points = points;
    self.pointsLabel.text = [NSString stringWithFormat:@"观看积分 %ld", points];
}

- (void)favoriteBlock:(void (^)(VideoCollectionCell *))block {
    self.favoriteBlock = block;
}

#pragma mark - private methons

- (void)_makeConstraints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(kImageHeightScale);
    }];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imageView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
    }];
    [self.pointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottomMargin.equalTo(@-7);
    }];
    [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.rightMargin.equalTo(@0);
        make.centerY.equalTo(self.pointsLabel);
    }];
}

#pragma mark - private property methons

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] init];
        _playImageView.image = [UIImage imageNamed:@"video_play"];
    }
    return _playImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = k_COLOR_DIMGRAY;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)pointsLabel {
    if (!_pointsLabel) {
        _pointsLabel = [[UILabel alloc] init];
        _pointsLabel.font = [UIFont boldSystemFontOfSize:13];
        _pointsLabel.textColor = k_COLOR_GOLDENROD;
    }
    return _pointsLabel;
}

- (UIButton *)favoriteButton {
    if (!_favoriteButton) {
        _favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoriteButton setImage:[UIImage imageNamed:@"video_icon_favorite_n"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"video_icon_favorite_h"] forState:UIControlStateHighlighted];
        _weak(self);
        [_favoriteButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.favoriteBlock, self);
        }];
    }
    return _favoriteButton;
}

@end