//
//  ActivityInfoHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ActivityInfoHeaderView.h"

@interface ActivityInfoHeaderView ()

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *beginEndDateLabel;

@end

static NSInteger const kTitleTopMargin = 15;
static NSInteger const kTimeTopMargin  = 9;
static NSInteger const kTimeHeight     = 14;
#define kTitleFont  [UIFont systemFontOfSize:18]

@implementation ActivityInfoHeaderView

+ (CGFloat)viewHeight {
    return SCREEN_WIDTH * 0.5
    + kTitleTopMargin + kTitleFont.lineHeight * 2
    + kTimeTopMargin + kTimeHeight;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.beginEndDateLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [self.beginEndDateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self);
        make.height.equalTo(@(kTimeHeight));
    }];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(0.5);
        make.bottom.equalTo(self.beginEndDateLabel.mas_top).offset(-kTimeTopMargin -kTitleFont.lineHeight * 2 -kTitleTopMargin);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(self.imageView.mas_bottom).offset(kTitleTopMargin);
    }];
}

#pragma mark - public property methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.imageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setBeginDate:(NSDate *)beginDate {
    _beginDate = beginDate;
    [self _refeashDateAndStatusLabel];
}

- (void)setEndDate:(NSDate *)endDate {
    _endDate = endDate;
    [self _refeashDateAndStatusLabel];
}

#pragma mark - private methods

- (void)_refeashDateAndStatusLabel {
    self.beginEndDateLabel.text = [NSString stringWithFormat:@"活动时间：%@ — %@", [self.beginDate formattedDateWithFormat:@"MM.dd"], [self.endDate formattedDateWithFormat:@"MM.dd"]];
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
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)beginEndDateLabel {
    if (!_beginEndDateLabel) {
        _beginEndDateLabel = [[UILabel alloc] init];
        _beginEndDateLabel.font = [UIFont systemFontOfSize:13];
        _beginEndDateLabel.textColor = k_COLOR_STAR_DUST;
    }
    return _beginEndDateLabel;
}

@end
