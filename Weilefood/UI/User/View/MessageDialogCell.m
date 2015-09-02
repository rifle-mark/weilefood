//
//  MessageDialogCell.m
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MessageDialogCell.h"
#import "WLModelHeader.h"

@interface MessageDialogCell ()

@property(nonatomic,strong)UIImageView      *avatarV;
@property(nonatomic,strong)UILabel          *nickNameL;
@property(nonatomic,strong)UILabel          *messageL;
@property(nonatomic,strong)UILabel          *timeL;
@property(nonatomic,strong)UIView           *lineV;

@end

@implementation MessageDialogCell

+ (NSString *)reuseIdentify {
    return @"MessageDialogCellIdentify";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_CLEAR;
        [self.contentView addSubview:self.avatarV];
        [self.contentView addSubview:self.nickNameL];
        [self.contentView addSubview:self.timeL];
        [self.contentView addSubview:self.messageL];
        [self.contentView addSubview:self.lineV];
        [self setNeedsUpdateConstraints];
        
        [self _setupObserver];
    }
    return self;
}

- (void)updateConstraints {
    [self.avatarV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarV.superview);
        make.left.equalTo(self.avatarV.superview).with.offset(10);
        make.width.height.equalTo(@44);
    }];
    
    [self.nickNameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameL.superview).with.offset(18);
        make.left.equalTo(self.avatarV.mas_right).with.offset(13);
    }];
    [self.timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeL.superview).with.offset(15);
        make.right.equalTo(self.timeL.superview).with.offset(-10);
    }];
    [self.messageL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameL.mas_bottom).with.offset(6);
        make.left.equalTo(self.nickNameL);
        make.right.equalTo(self.timeL.mas_left);
    }];
    [self.lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarV);
        make.right.equalTo(self.timeL);
        make.bottom.equalTo(self.lineV.superview);
        make.height.equalTo(@0.4);
    }];
    
    [super updateConstraints];
}

#pragma mark - private
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"dialog" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.avatarV my_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:44 height:44 urlString:self.dialog.avatar]];
        self.nickNameL.text = self.dialog.nickName;
        self.messageL.text = self.dialog.content;
        NSString *time = nil;
        if ([self.dialog.followDate isToday]) {
            if ([self.dialog.followDate hour] < 12) {
                time = [self.dialog.followDate formattedDateWithFormat:@"上午 HH:ss"];
            }
            else {
                time = [self.dialog.followDate formattedDateWithFormat:@"下午 HH:ss"];
            }
        }
        else if ([self.dialog.followDate isYesterday]) {
            time = @"昨天";
        }
        else {
            time = [self.dialog.followDate formattedDateWithFormat:@"MM/DD/YYYY"];
        }
        self.timeL.text = time;
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

- (UILabel *)nickNameL {
    if (!_nickNameL) {
        _nickNameL = [[UILabel alloc] init];
        _nickNameL.font = [UIFont boldSystemFontOfSize:16];
        _nickNameL.textColor = k_COLOR_DIMGRAY;
    }
    return _nickNameL;
}

- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [[UILabel alloc] init];
        _timeL.font = [UIFont systemFontOfSize:12];
        _timeL.textColor = k_COLOR_DARKGRAY;
        _timeL.textAlignment = NSTextAlignmentRight;
    }
    return _timeL;
}

- (UILabel *)messageL {
    if (!_messageL) {
        _messageL = [[UILabel alloc] init];
        _messageL.font = [UIFont systemFontOfSize:14];
        _messageL.textColor = k_COLOR_STAR_DUST;
        _messageL.numberOfLines = 1;
        _messageL.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _messageL;
}

- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineV;
}
@end
