//
//  CommentCell.m
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UILabel     *timeLabel;

@end

#define kNameFont       [UIFont systemFontOfSize:15]
#define kContentFont    [UIFont systemFontOfSize:13]
#define kTimeFont       [UIFont systemFontOfSize:11]

static NSInteger const kNameTopMargin    = 17;
static NSInteger const kContentTopMargin = 8;
static NSInteger const kTimeTopMargin    = 6;
static NSInteger const kTimeBottomMargin = 6;

static NSInteger const kAvatarLeftMargin   = 20;
static NSInteger const kAvatarWidth        = 43;
static NSInteger const kContentLeftMargin  = 13;
static NSInteger const kContentRigthMargin = 20;

@implementation CommentCell

+ (CGFloat)cellHeightWithContent:(NSString *)content {
    CGFloat contentWidth = V_W_([UIApplication sharedApplication].keyWindow) - kAvatarLeftMargin - kAvatarWidth - kContentLeftMargin - kContentRigthMargin;
    CGRect contentFrame = [content boundingRectWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kContentFont} context:nil];
    
    return kNameTopMargin + kNameFont.lineHeight
        + kContentTopMargin + contentFrame.size.height
        + kTimeTopMargin + kTimeFont.lineHeight
        + kTimeBottomMargin;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.timeLabel];
        
        [self _makeConstraints];
    }
    return self;
}

- (void)_makeConstraints {
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kAvatarLeftMargin));
        make.top.equalTo(@(kNameTopMargin));
        make.size.mas_equalTo(CGSizeMake(kAvatarWidth, kAvatarWidth));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(kContentLeftMargin);
        make.top.equalTo(@(kNameTopMargin));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(kContentLeftMargin);
        make.right.equalTo(self.contentView).offset(-kContentRigthMargin);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kContentTopMargin);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kTimeTopMargin);
    }];
}

#pragma mark - public methods

- (void)setAvatarUrl:(NSString *)avatarUrl {
    _avatarUrl = [avatarUrl copy];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setContent:(NSString *)content {
    _content = [content copy];
    self.contentLabel.text = content;
}

- (void)setTime:(NSDate *)time {
    _time = [time copy];
    self.timeLabel.text = [time formattedDateWithFormat:@"yyyy-MM-dd"];;
}

#pragma mark - private property methods

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 21;
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kNameFont;
        _nameLabel.textColor = k_COLOR_GOLDENROD;
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kContentFont;
        _contentLabel.textColor = k_COLOR_SLATEGRAY;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kTimeFont;
        _timeLabel.textColor = k_COLOR_DARKGRAY;
    }
    return _timeLabel;
}

@end
