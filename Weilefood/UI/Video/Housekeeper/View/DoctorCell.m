//
//  DoctorCell.m
//  Weilefood
//
//  Created by kelei on 15/8/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorCell.h"

@interface DoctorCell ()

@property (nonatomic, strong) UIImageView *actionImageView;
@property (nonatomic, strong) UILabel     *actionCountLabel;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UILabel     *commentCountLabel;
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel     *nameLabel;

@property (nonatomic, strong) UIImageView *scoreBGView;
@property (nonatomic, strong) UILabel     *scoreTitleLabel;
@property (nonatomic, strong) UIImageView *scoreImageView1;
@property (nonatomic, strong) UIImageView *scoreImageView2;
@property (nonatomic, strong) UIImageView *scoreImageView3;
@property (nonatomic, strong) UIImageView *scoreImageView4;
@property (nonatomic, strong) UIImageView *scoreImageView5;

@property (nonatomic, strong) UIView  *descView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView  *footerView;

@end

static NSInteger const kImageTopMargin      = 50;
static NSInteger const kImageHeight         = 170;
static NSInteger const kNameTopMargin       = 32;
static NSInteger const kScoreTopMargin      = 8;
static NSInteger const kScoreHeight         = 23;
static NSInteger const kScoreBottomMargin   = 9;
static NSInteger const kDescLeftRightMargin = 27;
static NSInteger const kDescTopBottomMargin = 15;
static NSInteger const kFooterHeight        = 10;

#define kNameFont [UIFont systemFontOfSize:22]
#define kDescFont [UIFont systemFontOfSize:14]

@implementation DoctorCell

+ (CGFloat)cellHeightWithDesc:(NSString *)desc {
    CGFloat descWidth = SCREEN_WIDTH - kDescLeftRightMargin * 2;
    CGFloat descHeight = [desc boundingRectWithSize:CGSizeMake(descWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kDescFont} context:nil].size.height;
    return kImageTopMargin + kImageHeight
    + kNameTopMargin + kNameFont.lineHeight
    + kScoreTopMargin + kScoreHeight + kScoreBottomMargin
    + kDescTopBottomMargin + descHeight + kDescTopBottomMargin
    + kFooterHeight;
}

+ (NSString *)reuseIdentifier {
    return @"DoctorCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *views = @[self.actionImageView, self.actionCountLabel, self.commentImageView, self.commentCountLabel,
                           self.picImageView, self.nameLabel,
                           self.scoreBGView, self.scoreTitleLabel,
                           self.scoreImageView1, self.scoreImageView2, self.scoreImageView3, self.scoreImageView4, self.scoreImageView5,
                           self.descView, self.descLabel, self.footerView,
                           ];
        for (UIView *view in views) {
            [self.contentView addSubview:view];
        }
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.commentCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentCountLabel.superview).offset(-13);
        make.top.equalTo(self.commentCountLabel.superview).offset(13);
    }];
    [self.commentImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentCountLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.commentCountLabel);
    }];
    [self.actionCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentImageView.mas_left).offset(-13);
        make.centerY.equalTo(self.commentImageView);
    }];
    [self.actionImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.actionCountLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.actionCountLabel);
    }];
    
    [self.picImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picImageView.superview).offset(kImageTopMargin);
        make.size.mas_equalTo(CGSizeMake(kImageHeight, kImageHeight));
        make.centerX.equalTo(@0);
    }];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picImageView.mas_bottom).offset(kNameTopMargin);
        make.centerX.equalTo(@0);
    }];
    
    [self.scoreBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_baseline).offset(kScoreTopMargin);
        make.centerX.equalTo(@0);
        make.height.equalTo(@(kScoreHeight));
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
    
    [self.descView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.descView.superview);
        make.top.equalTo(self.scoreBGView.mas_bottom).offset(kScoreBottomMargin);
    }];
    [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.descView).insets(UIEdgeInsetsMake(kDescTopBottomMargin, kDescLeftRightMargin, kDescTopBottomMargin, kDescLeftRightMargin));
    }];
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.footerView.superview);
        make.top.equalTo(self.descView.mas_bottom);
        make.height.equalTo(@(kFooterHeight));
    }];
}

#pragma mark - public methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.picImageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setActionCount:(long long)actionCount {
    _actionCount = actionCount;
    self.actionCountLabel.text = [NSString stringWithFormat:@"%lld", actionCount];
}

- (void)setCommentCount:(long long)commentCount {
    _commentCount = commentCount;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%lld", commentCount];
}

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

- (void)setDesc:(NSString *)desc {
    _desc = [desc copy];
    self.descLabel.text = desc;
}

#pragma mark - private property methods

- (UIImageView *)actionImageView {
    if (!_actionImageView) {
        _actionImageView = [[UIImageView alloc] init];
        _actionImageView.image = [UIImage imageNamed:@"market_product_action_icon"];
    }
    return _actionImageView;
}

- (UILabel *)actionCountLabel {
    if (!_actionCountLabel) {
        _actionCountLabel = [[UILabel alloc] init];
        _actionCountLabel.font = [UIFont systemFontOfSize:10];
        _actionCountLabel.textColor = k_COLOR_DARKGRAY;
    }
    return _actionCountLabel;
}

- (UIImageView *)commentImageView {
    if (!_commentImageView) {
        _commentImageView = [[UIImageView alloc] init];
        _commentImageView.image = [UIImage imageNamed:@"market_product_comment_icon"];
    }
    return _commentImageView;
}

- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.font = [UIFont systemFontOfSize:10];
        _commentCountLabel.textColor = k_COLOR_DARKGRAY;
    }
    return _commentCountLabel;
}

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
        _picImageView.layer.cornerRadius = kImageHeight * 0.5;
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

- (UIView *)descView {
    if (!_descView) {
        _descView = [[UIView alloc] init];
        _descView.backgroundColor = k_COLOR_DESERT_STORM;
    }
    return _descView;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = kDescFont;
        _descLabel.textColor = k_COLOR_STAR_DUST;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _footerView;
}

@end
