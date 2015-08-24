//
//  ScoreView.m
//  Weilefood
//
//  Created by kelei on 15/8/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ScoreView.h"

@interface ScoreView ()

@property (nonatomic, strong) UIImageView *scoreBGView;
@property (nonatomic, strong) UILabel     *scoreTitleLabel;
@property (nonatomic, strong) UIImageView *scoreImageView1;
@property (nonatomic, strong) UIImageView *scoreImageView2;
@property (nonatomic, strong) UIImageView *scoreImageView3;
@property (nonatomic, strong) UIImageView *scoreImageView4;
@property (nonatomic, strong) UIImageView *scoreImageView5;

@end

static NSInteger const kBGHeight = 23;

@implementation ScoreView

+ (CGFloat)viewHeight {
    return kBGHeight;
}

- (id)init {
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *views = @[self.scoreBGView, self.scoreTitleLabel,
                           self.scoreImageView1, self.scoreImageView2, self.scoreImageView3, self.scoreImageView4, self.scoreImageView5,
                           ];
        for (UIView *view in views) {
            [self addSubview:view];
        }
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.scoreBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(@(kBGHeight));
        make.left.equalTo(self.scoreTitleLabel).offset(-10);
        make.right.equalTo(self.scoreImageView5).offset(10);
    }];
    [self.scoreTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scoreBGView);
    }];
    NSArray *views = @[self.scoreImageView1, self.scoreImageView2, self.scoreImageView3, self.scoreImageView4, self.scoreImageView5];
    UIView *prevView = self.scoreTitleLabel;
    for (UIView *view in views) {
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(prevView.mas_right);
            make.centerY.equalTo(prevView);
        }];
        prevView = view;
    }
}

#pragma mark - public methods

- (void)setScore:(NSInteger)score {
    _score = score;
    
    UIImage *imageN = [UIImage imageNamed:@"housekeeper_score_icon_n"];
    UIImage *imageH = [UIImage imageNamed:@"housekeeper_score_icon_h"];
    self.scoreImageView1.image = score >= 1 ? imageH : imageN;
    self.scoreImageView2.image = score >= 2 ? imageH : imageN;
    self.scoreImageView3.image = score >= 3 ? imageH : imageN;
    self.scoreImageView4.image = score >= 4 ? imageH : imageN;
    self.scoreImageView5.image = score >= 5 ? imageH : imageN;
}

#pragma mark - private property methods

- (UIImageView *)scoreBGView {
    if (!_scoreBGView) {
        _scoreBGView = [[UIImageView alloc] init];
        _scoreBGView.image = [UIImage imageNamed:@"housekeeper_score_bg"];
    }
    return _scoreBGView;
}

- (UILabel *)scoreTitleLabel {
    if (!_scoreTitleLabel) {
        _scoreTitleLabel = [[UILabel alloc] init];
        _scoreTitleLabel.font = [UIFont systemFontOfSize:12];
        _scoreTitleLabel.textColor = k_COLOR_WHITE;
        _scoreTitleLabel.text = @"星级：";
    }
    return _scoreTitleLabel;
}

- (UIImageView *)scoreImageView1 {
    if (!_scoreImageView1) {
        _scoreImageView1 = [[UIImageView alloc] init];
    }
    return _scoreImageView1;
}

- (UIImageView *)scoreImageView2 {
    if (!_scoreImageView2) {
        _scoreImageView2 = [[UIImageView alloc] init];
    }
    return _scoreImageView2;
}

- (UIImageView *)scoreImageView3 {
    if (!_scoreImageView3) {
        _scoreImageView3 = [[UIImageView alloc] init];
    }
    return _scoreImageView3;
}

- (UIImageView *)scoreImageView4 {
    if (!_scoreImageView4) {
        _scoreImageView4 = [[UIImageView alloc] init];
    }
    return _scoreImageView4;
}

- (UIImageView *)scoreImageView5 {
    if (!_scoreImageView5) {
        _scoreImageView5 = [[UIImageView alloc] init];
    }
    return _scoreImageView5;
}

@end
