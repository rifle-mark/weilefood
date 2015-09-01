//
//  DoctorInfoHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorInfoHeaderView.h"
#import "ScoreView.h"

@interface DoctorInfoHeaderView ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) ScoreView   *scoreView;

@end

static NSInteger const kNameTopMargin     = 15;
static NSInteger const kScoreTopMargin    = 8;
static NSInteger const kScoreBottomMargin = 6;
#define kNameFont  [UIFont systemFontOfSize:25]

@implementation DoctorInfoHeaderView

+ (CGFloat)viewHeight {
    return SCREEN_WIDTH
    + kNameTopMargin + kNameFont.lineHeight
    + kScoreTopMargin + [ScoreView viewHeight] + kScoreBottomMargin;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.picImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.scoreView];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [self.scoreView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(self).offset(-kScoreBottomMargin);
    }];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.baseline.equalTo(self.scoreView.mas_top).offset(-kScoreTopMargin);
    }];
    [self.picImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.nameLabel.mas_top).offset(-kNameTopMargin);
        make.height.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - public property methods

- (void)setImageUrl:(NSString *)imageUrl {
    imageUrl = [imageUrl copy];
    [self.picImageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setScore:(NSInteger)score {
    _score = score;
    self.scoreView.score = score;
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
        _nameLabel.font = kNameFont;
        _nameLabel.textColor = k_COLOR_MAROOM;
    }
    return _nameLabel;
}

- (ScoreView *)scoreView {
    if (!_scoreView) {
        _scoreView = [[ScoreView alloc] init];
    }
    return _scoreView;
}

@end
