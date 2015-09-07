//
//  DiscoveryCollectionHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/8.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DiscoveryCollectionHeaderView.h"
#import "SwipeView+AutomaticCycleScrollingImage.h"

@interface DiscoveryCollectionHeaderView ()

@property (nonatomic, strong) SwipeView     *bannerView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView   *leftImageView;
@property (nonatomic, strong) UILabel       *leftLabel;
@property (nonatomic, strong) UIButton      *leftButton;
@property (nonatomic, strong) UIImageView   *middleImageView;
@property (nonatomic, strong) UILabel       *middleLabel;
@property (nonatomic, strong) UIButton      *middleButton;
@property (nonatomic, strong) UIImageView   *rightImageView;
@property (nonatomic, strong) UILabel       *rightLabel;
@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) UIImageView   *videoImageView;

@property (nonatomic, copy) BannerImageClickBlock bannerImageClickBlock;
@property (nonatomic, copy) GCAOPInterceptorBlock marketClickBlock;
@property (nonatomic, copy) GCAOPInterceptorBlock forwardbuyClickBlock;
@property (nonatomic, copy) GCAOPInterceptorBlock nutritionClickBlock;
@property (nonatomic, copy) GCAOPInterceptorBlock videoImageClickBlock;

@end

static NSInteger const kHeaderBannerHeight  = 160;
static NSInteger const kHeaderButtonWidth   = 80;
static NSInteger const kHeaderButtonHeight  = 126;
static NSInteger const kHeaderAdHeight      = 88;

@implementation DiscoveryCollectionHeaderView

+ (CGFloat)viewHeight {
    return kHeaderBannerHeight + kHeaderButtonHeight + kHeaderAdHeight;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSArray *array = @[self.bannerView,         self.pageControl,
                           self.leftImageView,      self.leftLabel,     self.leftButton,
                           self.middleImageView,    self.middleLabel,   self.middleButton,
                           self.rightImageView,     self.rightLabel,    self.rightButton,
                           self.videoImageView,
                           ];
        for (UIView *view in array) {
            [self addSubview:view];
        }
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bannerView.superview);
        make.height.equalTo(@(kHeaderBannerHeight));
    }];
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    size.width += 8;
    size.height = 15;
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bannerView);
        make.bottom.equalTo(self.bannerView).offset(-10);
        make.size.mas_equalTo(size);
    }];
    [self.middleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kHeaderButtonWidth, kHeaderButtonHeight));
    }];
    CGFloat buttonMargin = ([UIApplication sharedApplication].keyWindow.bounds.size.width - kHeaderButtonWidth * 3) / 4.0;
    [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.middleButton);
        make.left.equalTo(@(buttonMargin));
    }];
    [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.middleButton);
        make.right.equalTo(@(-buttonMargin));
    }];
    NSArray *views = @[@[self.leftImageView, self.leftLabel, self.leftButton],
                       @[self.middleImageView, self.middleLabel, self.middleButton],
                       @[self.rightImageView, self.rightLabel, self.rightButton],
                       ];
    for (NSArray *array in views) {
        UIImageView *imgView = array[0];
        UILabel *label = array[1];
        UIButton *btn = array[2];
        [imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.centerY.equalTo(btn).offset(-15);
        }];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgView);
            make.top.equalTo(imgView.mas_bottom).offset(10);
        }];
    }
    [self.videoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleButton.mas_bottom);
        make.left.right.equalTo(self.videoImageView.superview);
        make.bottom.equalTo(self.videoImageView.superview);
    }];
}

#pragma mark - public methods

- (void)setBannerImageUrls:(NSArray *)bannerImageUrls {
    _bannerImageUrls = bannerImageUrls;
    self.bannerView.acsi_imageUrls = bannerImageUrls;
    [self.bannerView reloadData];
    self.pageControl.numberOfPages = self.bannerView.numberOfPages;
    [self _remakeConstraints];
}

- (void)setVideoImageUrl:(NSString *)videoImageUrl {
    _videoImageUrl = [videoImageUrl copy];
    [self.videoImageView my_setImageWithURL:[NSURL URLWithString:videoImageUrl]];
}

- (void)bannerImageClickBlock:(BannerImageClickBlock)block {
    self.bannerImageClickBlock = block;
}

- (void)marketClickBlock:(GCAOPInterceptorBlock)block {
    self.marketClickBlock = block;
}

- (void)forwardbuyClickBlock:(GCAOPInterceptorBlock)block {
    self.forwardbuyClickBlock = block;
}

- (void)nutritionClickBlock:(GCAOPInterceptorBlock)block {
    self.nutritionClickBlock = block;
}

- (void)videoImageClickBlock:(GCAOPInterceptorBlock)block {
    self.videoImageClickBlock = block;
}

#pragma mark - private methods

- (UILabel *)_createButtonLabel {
    return ({
        UILabel *v = [[UILabel alloc] init];
        v.font = [UIFont systemFontOfSize:15];
        v.textColor = k_COLOR_MAROOM;
        v;
    });
}

#pragma mark - private property methods

- (SwipeView *)bannerView {
    if (!_bannerView) {
        _bannerView = [SwipeView acsi_create];
        _bannerView.backgroundColor = [UIColor grayColor];
        _weak(self);
        [_bannerView acsi_currentItemIndexDidChangeBlock:^(SwipeView *swipeView) {
            _strong_check(self);
            self.pageControl.currentPage = swipeView.currentPage;
        }];
        [_bannerView acsi_didSelectItemAtIndexBlock:^(SwipeView *swipeView, NSInteger index) {
            _strong_check(self);
            GCBlockInvoke(self.bannerImageClickBlock, index);
        }];
    }
    return _bannerView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = [k_COLOR_BLACK colorWithAlphaComponent:0.2];
        _pageControl.layer.cornerRadius = 7;
    }
    return _pageControl;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"discovery_market_icon"];
    }
    return _leftImageView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [self _createButtonLabel];
        _leftLabel.text = @"集市";
    }
    return _leftLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _weak(self);
        [_leftButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.marketClickBlock);
        }];
    }
    return _leftButton;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.image = [UIImage imageNamed:@"discovery_forwardbuy_icon"];
    }
    return _middleImageView;
}

- (UILabel *)middleLabel {
    if (!_middleLabel) {
        _middleLabel = [self _createButtonLabel];
        _middleLabel.text = @"预购";
    }
    return _middleLabel;
}

- (UIButton *)middleButton {
    if (!_middleButton) {
        _middleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _weak(self);
        [_middleButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.forwardbuyClickBlock);
        }];
    }
    return _middleButton;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"discovery_right_icon"];
    }
    return _rightImageView;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [self _createButtonLabel];
        _rightLabel.text = @"营养推荐";
    }
    return _rightLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _weak(self);
        [_rightButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.nutritionClickBlock);
        }];
    }
    return _rightButton;
}

- (UIImageView *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
        _videoImageView.userInteractionEnabled = YES;
        _weak(self);
        [_videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(UIGestureRecognizer *gesture) {
            _strong_check(self);
            GCBlockInvoke(self.videoImageClickBlock);
        }]];
    }
    return _videoImageView;
}

@end
