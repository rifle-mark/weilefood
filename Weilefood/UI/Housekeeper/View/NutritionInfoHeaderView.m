//
//  NutritionInfoHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "NutritionInfoHeaderView.h"

@interface NutritionInfoHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;

@end

static NSInteger const kTitleTopMargin      = 15;
#define kTitleFont  [UIFont systemFontOfSize:18]

@implementation NutritionInfoHeaderView

+ (CGFloat)viewHeight {
    return SCREEN_WIDTH + kTitleTopMargin + kTitleFont.lineHeight;;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.imageView.mas_width);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-kTitleTopMargin);
    }];
    
    [super updateConstraints];
}

#pragma mark - public property methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.imageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - private property methods

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
        _titleLabel.font = kTitleFont;
        _titleLabel.textColor = k_COLOR_MAROOM;
    }
    return _titleLabel;
}

@end
