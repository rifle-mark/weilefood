//
//  ProductTableHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/6.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ProductTableHeaderView.h"
#import <SwipeView/SwipeView.h>

@interface ProductTableHeaderView () <SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, strong) SwipeView     *swipeView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *priceLabel;

@end

static NSInteger const kImageChangeDelay = 4;
#define kTitleFont  [UIFont systemFontOfSize:18]

@implementation ProductTableHeaderView

+ (CGFloat)viewHeight {
    return V_W_([UIApplication sharedApplication].keyWindow) + 15 + kTitleFont.lineHeight * 2 + 50;
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
    
    [self.swipeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(self.swipeView.mas_width);
    }];
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.swipeView);
        make.height.equalTo(@25);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(self.swipeView.mas_bottom).offset(15);
    }];
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self);
        make.height.equalTo(@20);
    }];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.height.equalTo(self.numberLabel);
    }];
}

#pragma mark - public property methods

- (void)setImages:(NSArray *)images {
    _images = images;
    [self.swipeView reloadData];
    self.pageControl.numberOfPages = self.swipeView.numberOfPages;
    [self performSelector:@selector(_autoNextImage) withObject:nil afterDelay:kImageChangeDelay];
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

#pragma mark - SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return self.images ? self.images.count : 0;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView = nil;
    if (!view) {
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = swipeView.bounds;
    }
    else {
        imageView = (UIImageView *)view;
    }
    NSString *url = self.images[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    return imageView;
}

#pragma mark - SwipeViewDelegate

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    self.pageControl.currentPage = swipeView.currentPage;
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_autoNextImage) object:nil];
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate {
    [self performSelector:@selector(_autoNextImage) withObject:nil afterDelay:kImageChangeDelay];
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    // TODO: 进入广告界面
}

#pragma mark - private methods

- (void)_autoNextImage {
    if (self.swipeView.numberOfPages > 0 && !self.swipeView.decelerating) {
        NSInteger newPage = self.swipeView.currentPage + 1;
        if (newPage >= self.swipeView.numberOfPages) {
            newPage = 0;
        }
        [self.swipeView scrollToPage:newPage duration:0.3];
    }
    [self performSelector:@selector(_autoNextImage) withObject:nil afterDelay:kImageChangeDelay];
}

#pragma mark - private property methods

- (SwipeView *)swipeView {
    if (!_swipeView) {
        _swipeView = [[SwipeView alloc] init];
        _swipeView.backgroundColor = k_COLOR_WHITE;
        _swipeView.pagingEnabled = YES;
        _swipeView.wrapEnabled = YES;
        _swipeView.dataSource = self;
        _swipeView.delegate = self;
    }
    return _swipeView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
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
