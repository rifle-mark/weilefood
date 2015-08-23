//
//  WeiSubCommentCell.m
//  Sunflower
//
//  Created by makewei on 15/6/4.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "WLShareSubCommentCell.h"

#import "WLShareModel.h"
#import "WLCommentModel.h"

@interface WLShareSubCommentCell ()

@property(nonatomic,strong)UIImageView      *avatarV;
@property(nonatomic,strong)UILabel          *nickNameL;
@property(nonatomic,strong)UILabel          *timeL;
@property(nonatomic,strong)UILabel          *contentL;

@end

@implementation WLShareSubCommentCell

+ (NSString *)reuseIdentify {
    return @"WeiSubCommentCellIdentify";
}

+ (CGFloat)heightWithComment:(WLCommentModel *)comment screenWidth:(CGFloat)width {
    CGRect strRect = [[WLShareSubCommentCell _contentAttributeStringWithComment:comment] boundingRectWithSize:ccs(width - 86, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return strRect.size.height + 15+12+10+15;
}

+ (NSAttributedString *)_contentAttributeStringWithComment:(WLCommentModel *)comment {
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.alignment = NSTextAlignmentLeft;
    ps.lineBreakMode = NSLineBreakByWordWrapping;
    ps.lineHeightMultiple = 1;
    NSDictionary *att = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],
                          NSForegroundColorAttributeName:k_COLOR_DIMGRAY,
                          NSBackgroundColorAttributeName:k_COLOR_CLEAR,
                          NSParagraphStyleAttributeName:ps};
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:comment.content attributes:att];
    return str;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_WHITESMOKE;
        
        if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.equalTo(self.contentView.superview);
            }];
        }
        _weak(self);
        self.avatarV = [[UIImageView alloc] init];
        self.avatarV.clipsToBounds = YES;
        self.avatarV.layer.cornerRadius = 22;
        [self.contentView addSubview:self.avatarV];
        [self.avatarV mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.top.equalTo(self.contentView).with.offset(12);
            make.left.equalTo(self.contentView).with.offset(15);
            make.width.height.equalTo(@42);
        }];
        
        self.timeL = [[UILabel alloc] init];
        self.timeL.backgroundColor = k_COLOR_CLEAR;
        self.timeL.font = [UIFont boldSystemFontOfSize:12];
        self.timeL.textColor = k_COLOR_LAVENDER;
        self.timeL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeL];
        [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.top.equalTo(self.contentView).with.offset(20);
            make.right.equalTo(self.contentView).with.offset(-17);
            make.height.equalTo(@12);
            make.width.equalTo(@100);
        }];
        
        self.nickNameL = [[UILabel alloc] init];
        self.nickNameL.backgroundColor = k_COLOR_CLEAR;
        self.nickNameL.font = [UIFont boldSystemFontOfSize:12];
        self.nickNameL.textColor = k_COLOR_GOLDENROD;
        [self.contentView addSubview:self.nickNameL];
        [self.nickNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.top.equalTo(self.contentView).with.offset(15);
            make.left.equalTo(self.contentView).with.offset(69);
            make.right.equalTo(self.timeL.mas_left).with.offset(-5);
            make.height.equalTo(@12);
        }];
        
        self.contentL = [[UILabel alloc] init];
        self.contentL.numberOfLines = 0;
        [self.contentView addSubview:self.contentL];
        [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.top.equalTo(self.nickNameL.mas_bottom).with.offset(10);
            make.left.equalTo(self.nickNameL);
            make.right.equalTo(self.contentView).with.offset(-17);
            make.bottom.equalTo(self.contentView).with.offset(-15);
        }];
        
        UIView *splitV = [[UIView alloc] init];
        splitV.backgroundColor = k_COLOR_DARKGRAY;
        [self.contentView addSubview:splitV];
        [splitV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(10);
            make.right.equalTo(self.contentView).with.offset(-10);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.4);
        }];
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithActionBlock:^(UIGestureRecognizer *gesture) {
            _strong(self);
            if (gesture.state == UIGestureRecognizerStateBegan) {
                GCBlockInvoke(self.longTapBlock, self.comment);
            }
        }];
        [self.contentView addGestureRecognizer:longTap];
        
        [self _setupObserver];
    }
    return self;
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"comment" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.avatarV sd_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:42 height:42 urlString:self.comment.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.nickNameL.text = self.comment.nickName;
        self.contentL.attributedText = [[self class] _contentAttributeStringWithComment:self.comment];
        if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.equalTo(self.contentView.superview);
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            }];
        }
    }];
}

@end
