//
//  ForwardBuyInfoHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ForwardBuyInfoHeaderView.h"
#import "SwipeView+AutomaticCycleScrollingImage.h"
#import "WLModelHeader.h"

@interface ForwardBuyInfoHeaderView ()

@property (nonatomic, strong) SwipeView     *swipeView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView        *timeView;
@property (nonatomic, strong) UIImageView   *timeIconImageView;
@property (nonatomic, strong) UILabel       *beginEndDateLabel;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *priceLabel;

@end

static NSInteger const kTitleTopMargin      = 15;
static NSInteger const kTimeHeight          = 33;
static NSInteger const kNumberTopMargin     = 10;
static NSInteger const kNumberHeight        = 20;
#define kTitleFont  [UIFont systemFontOfSize:18]

@implementation ForwardBuyInfoHeaderView

+ (CGFloat)viewHeight {
    return SCREEN_WIDTH
    + kTimeHeight
    + kTitleTopMargin + kTitleFont.lineHeight * 2
    + kNumberTopMargin + kNumberHeight;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.swipeView];
        [self addSubview:self.pageControl];
        [self addSubview:self.timeView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.numberLabel];
        [self addSubview:self.priceLabel];
        
        [self.timeView addSubview:self.timeIconImageView];
        [self.timeView addSubview:self.beginEndDateLabel];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self);
        make.height.equalTo(@(kNumberHeight));
    }];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.height.equalTo(self.numberLabel);
    }];
    [self.timeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@(kTimeHeight));
        make.bottom.equalTo(self.numberLabel.mas_top).offset(-kNumberTopMargin -kTitleFont.lineHeight * 2 -kTitleTopMargin);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(self.timeView.mas_bottom).offset(kTitleTopMargin);
    }];
    [self.swipeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.swipeView.mas_width);
        make.bottom.equalTo(self.timeView.mas_top);
    }];
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    size.width += 8;
    size.height = 15;
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.swipeView);
        make.bottom.equalTo(self.swipeView).offset(-10);
        make.size.mas_equalTo(size);
    }];
    
    [self.timeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.beginEndDateLabel.mas_left);
        make.centerY.equalTo(self.timeView);
    }];
    [self.beginEndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.timeView).offset(self.timeIconImageView.image.size.width / 2);
        make.centerY.equalTo(self.timeView);
    }];
}

#pragma mark - public property methods

- (void)setImages:(NSArray *)images {
    _images = images;
    self.swipeView.acsi_imageUrls = images;
    [self.swipeView reloadData];
    self.pageControl.numberOfPages = self.swipeView.numberOfPages;
    // 这里直接调用[self setNeedsUpdateConstraints];在iOS7下会报错，原因是设置约束的时机问题。
    // 所以使用以下方法延迟执行
    [self performSelector:@selector(setNeedsUpdateConstraints) withObject:nil afterDelay:0.1];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@" 剩余：%ld份 ", (long)number];
}

- (void)setPrice:(CGFloat)price {
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", price];
}

- (void)setBeginDate:(NSDate *)beginDate {
    _beginDate = beginDate;
    [self _refeashDateAndStatusLabel];
}

- (void)setEndDate:(NSDate *)endDate {
    _endDate = endDate;
    [self _refeashDateAndStatusLabel];
}

- (void)setState:(WLForwardBuyState)state {
    _state = state;
    switch (state) {
        case WLForwardBuyStateNotStarted:
            self.timeView.backgroundColor = k_COLOR_MEDIUM_AQUAMARINE;
            break;
        case WLForwardBuyStateEnded:
            self.timeView.backgroundColor = k_COLOR_DARKGRAY;
            break;
        default:
            self.timeView.backgroundColor = k_COLOR_ANZAC;
            break;
    }
}

#pragma mark - private methods

- (void)_refeashDateAndStatusLabel {
    self.beginEndDateLabel.text = [NSString stringWithFormat:@"购买时间：%@ — %@", [self.beginDate formattedDateWithFormat:@"MM.dd"], [self.endDate formattedDateWithFormat:@"MM.dd"]];
}

#pragma mark - private property methods

- (SwipeView *)swipeView {
    if (!_swipeView) {
        _swipeView = [SwipeView acsi_create];
        _swipeView.backgroundColor = k_COLOR_WHITE;
        _weak(self);
        [_swipeView acsi_currentItemIndexDidChangeBlock:^(SwipeView *swipeView) {
            _strong_check(self);
            self.pageControl.currentPage = swipeView.currentPage;
        }];
        [_swipeView acsi_didSelectItemAtIndexBlock:^(SwipeView *swipeView, NSInteger index) {
            _strong_check(self);
            DLog(@"");
        }];
    }
    return _swipeView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = [k_COLOR_BLACK colorWithAlphaComponent:0.7];
        _pageControl.layer.cornerRadius = 7;
    }
    return _pageControl;
}

- (UIView *)timeView {
    if (!_timeView) {
        _timeView = [[UIView alloc] init];
    }
    return _timeView;
}

- (UIImageView *)timeIconImageView {
    if (!_timeIconImageView) {
        _timeIconImageView = [[UIImageView alloc] init];
        _timeIconImageView.image = [UIImage imageNamed:@"fy_icon_time"];
    }
    return _timeIconImageView;
}

- (UILabel *)beginEndDateLabel {
    if (!_beginEndDateLabel) {
        _beginEndDateLabel = [[UILabel alloc] init];
        _beginEndDateLabel.font = [UIFont systemFontOfSize:13];
        _beginEndDateLabel.textColor = k_COLOR_WHITE;
    }
    return _beginEndDateLabel;
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

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:11];
        _numberLabel.textColor = k_COLOR_STAR_DUST;
        _numberLabel.backgroundColor = k_COLOR_WHITESMOKE;
        _numberLabel.layer.cornerRadius = 4;
        _numberLabel.clipsToBounds = YES;
    }
    return _numberLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:20];;
        _priceLabel.textColor = k_COLOR_GOLDENROD;
    }
    return _priceLabel;
}

@end
