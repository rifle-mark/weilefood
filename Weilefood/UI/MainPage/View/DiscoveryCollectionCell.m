//
//  DiscoveryCollectionCell.m
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DiscoveryCollectionCell.h"

@interface DiscoveryCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *moneyLabel;

@end

/// Cell中图片高度=图片宽度*此数据
static CGFloat const kImageHeightScale = 0.788;

@implementation DiscoveryCollectionCell

+ (CGFloat)cellHeightWithCellWidth:(CGFloat)cellWidth {
    return cellWidth * kImageHeightScale + 68;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.moneyLabel];
        
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

- (void)setMoney:(CGFloat)money {
    _money = money;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f", money];
}

#pragma mark - private methons

- (void)_makeConstraints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(kImageHeightScale);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottomMargin.equalTo(@-7);
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = k_COLOR_DIMGRAY;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:13];
        _moneyLabel.textColor = k_COLOR_GOLDENROD;
    }
    return _moneyLabel;
}

@end
