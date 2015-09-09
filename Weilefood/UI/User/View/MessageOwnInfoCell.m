//
//  MessageInfoCell.m
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MessageOwnInfoCell.h"
#import "WLModelHeader.h"

@interface MessageOwnInfoCell ()

@property(nonatomic,strong)UIImageView      *avatarV;
@property(nonatomic,strong)UIImageView      *messageBgV;
@property(nonatomic,strong)UILabel          *messageL;
@property(nonatomic,strong)UILabel          *timeL;

@end

@implementation MessageOwnInfoCell


+ (CGFloat)cellHeightWithMessage:(WLMessageModel *)message {
    CGRect textRect = [[[self class] _messageAttributedStringWithMessage:message] boundingRectWithSize:ccs([UIScreen mainScreen].bounds.size.width-116, 10000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    if (textRect.size.height <= 20) {
        return 44+35;
    }
    else {
        return textRect.size.height+27+35;
    }
}

+ (NSAttributedString *)_messageAttributedStringWithMessage:(WLMessageModel *)message {
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = 5;
    
    return [[NSAttributedString alloc]
            initWithString:message.content
            attributes:@{NSParagraphStyleAttributeName:ps,
                         NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                         NSForegroundColorAttributeName:k_COLOR_DIMGRAY}];
}

+ (NSString *)reuseIdentify {
    return @"MessageOwnInfoCellIdentify";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_CLEAR;
        [self.contentView addSubview:self.timeL];
        [self.contentView addSubview:self.avatarV];
        [self.contentView addSubview:self.messageBgV];
        [self.messageBgV addSubview:self.messageL];
        
        [self _setupObserver];
    }
    return self;
}

- (void)updateConstraints {
    [self.timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.timeL.superview);
        make.top.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [self.avatarV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.avatarV.superview).with.offset(-10);
        make.top.equalTo(self.timeL.mas_bottom).with.offset(5);
        make.width.height.equalTo(@(44));
    }];
    [self.messageBgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarV);
        make.right.equalTo(self.avatarV.mas_left);
    }];
    
    CGFloat width = 10;
    if (self.message) {
        NSAttributedString *text = [[self class] _messageAttributedStringWithMessage:self.message];
        CGRect textRect = [text boundingRectWithSize:ccs(SCREEN_WIDTH - 116, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        width = textRect.size.width;
    }
    [self.messageL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageBgV).insets(UIEdgeInsetsMake(12, 10, 6, 16));
        make.width.equalTo(@(width));
    }];
    
    [super updateConstraints];
}

#pragma mark - private
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"message" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        NSAttributedString *text = [[self class] _messageAttributedStringWithMessage:self.message];
        self.messageL.attributedText = text;
        [self.avatarV my_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:44 height:44 urlString:self.message.userAvatar]];
        
        NSString *time = nil;
        if ([self.message.createDate isToday]) {
            if ([self.message.createDate hour] < 12) {
                time = [self.message.createDate formattedDateWithFormat:@"上午 HH:mm"];
            }
            else {
                time = [self.message.createDate formattedDateWithFormat:@"下午 HH:mm"];
            }
        }
        else if ([self.message.createDate isYesterday]) {
            time = [self.message.createDate formattedDateWithFormat:@"昨天 HH:mm"];
        }
        else {
            time = [self.message.createDate formattedDateWithFormat:@"yyyy年MM月dd日 HH:mm"];
        }
        self.timeL.text = [NSString stringWithFormat:@" %@ ", time];
        [self setNeedsUpdateConstraints];
    }];
}

#pragma mark - property
- (UIImageView *)avatarV {
    if (!_avatarV) {
        _avatarV = [[UIImageView alloc] init];
        _avatarV.clipsToBounds = YES;
        _avatarV.layer.cornerRadius = 22;
    }
    
    return _avatarV;
}

- (UILabel *)messageL {
    if (!_messageL) {
        _messageL = [[UILabel alloc] init];
        _messageL.numberOfLines = 0;
    }
    return _messageL;
}

- (UIImageView *)messageBgV {
    if (!_messageBgV) {
        _messageBgV = [[UIImageView alloc] init];
        _messageBgV.image = [UIImage imageNamed:@"message_own"];
        _messageBgV.contentMode = UIViewContentModeScaleToFill;
    }
    return _messageBgV;
}

- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [[UILabel alloc] init];
        _timeL.backgroundColor = k_COLOR_DARKGRAY;
        _timeL.font = [UIFont boldSystemFontOfSize:12];
        _timeL.textColor = k_COLOR_WHITE;
        _timeL.clipsToBounds = YES;
        _timeL.layer.cornerRadius = 8;
    }
    return _timeL;
}
@end
