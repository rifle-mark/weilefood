//
//  ProductInfoHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/6.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ProductInfoHeaderView.h"
#import "SwipeView+AutomaticCycleScrollingImage.h"

@interface ProductInfoHeaderView ()

@property (nonatomic, strong) SwipeView     *swipeView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *priceLabel;

@end

static NSInteger const kTitleTopMargin  = 15;
static NSInteger const kNumberTopMargin = 10;
static NSInteger const kNumberHeight    = 20;
#define kTitleFont  [UIFont systemFontOfSize:18]

@implementation ProductInfoHeaderView

+ (CGFloat)viewHeight {
    return SCREEN_WIDTH
        + kTitleTopMargin + kTitleFont.lineHeight * 2
        + kNumberTopMargin + kNumberHeight;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.swipeView];
        [self addSubview:self.pageControl];
        [self addSubview:self.titleLabel];
        [self addSubview:self.numberLabel];
        [self addSubview:self.priceLabel];
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
    [self.swipeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.swipeView.mas_width);
        make.bottom.equalTo(self.numberLabel.mas_top).offset(-kNumberTopMargin -kTitleFont.lineHeight * 2 -kTitleTopMargin);
    }];
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    size.width += 8;
    size.height = 15;
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.swipeView);
        make.bottom.equalTo(self.swipeView).offset(-10);
        make.size.mas_equalTo(size);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(self.swipeView.mas_bottom).offset(kTitleTopMargin);
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
