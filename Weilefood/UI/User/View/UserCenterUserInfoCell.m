//
//  UserCenterUserInfoCell.m
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UserCenterUserInfoCell.h"
#import "WLModelHeader.h"
#import "WLAPIAddressGenerator.h"
#import "WLDatabaseHelper+User.h"

@interface UserCenterUserInfoCell ()

@property(nonatomic,strong)UIImageView          *avatarV;
@property(nonatomic,strong)UILabel              *nickNameL;
@property(nonatomic,strong)UIButton             *pointBtn;

@property(nonatomic,copy)OnUserInfoImageClickBlock imageClickBlock;
@property(nonatomic,copy)OnUserInfoPointClickBlock pointClickBlock;

@end

@implementation UserCenterUserInfoCell

+ (NSString*)reuseIdentify {
    return @"UserCenterUserInfoCellIdentify";
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_TURQUOISE;
        
        [self.contentView addSubview:self.avatarV];
        [self.contentView addSubview:self.nickNameL];
        [self.contentView addSubview:self.pointBtn];
        
        [self _layoutSubView];
        
        [self _setupObserver];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)onImageClickBlock:(OnUserInfoImageClickBlock)block {
    self.imageClickBlock = block;
}
- (void)onPointClickBlock:(OnUserInfoPointClickBlock)block {
    self.pointClickBlock = block;
}

#pragma mark - private method

- (void)_layoutSubView {
    [self.avatarV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarV.superview);
        make.top.equalTo(self.avatarV.superview).with.offset(8);
        make.width.height.equalTo(@80);
    }];
    [self.nickNameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.left.right.equalTo(self.nickNameL.superview);
        make.top.equalTo(self.avatarV.mas_bottom).with.offset(15);
    }];
    [self.pointBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameL.mas_bottom).with.offset(6);
        make.centerX.equalTo(self.nickNameL.superview);
    }];
}
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"user" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        if (!self.user) {
            [self.avatarV my_setImageWithURL:nil];
            self.nickNameL.text = @"点击登录";
            self.pointBtn.hidden = YES;
            return;
        }
        [self.avatarV my_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:80 height:80 urlString:self.user.avatar]];
        self.nickNameL.text = self.user.nickName;
        self.pointBtn.hidden = NO;
        [self.pointBtn setTitle:[NSString stringWithFormat:@"  积分%ld >  ", (long)self.user.points] forState:UIControlStateNormal];
    }];
    
    [self addObserverForNotificationName:kNotificationUserInfoUpdate usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        WLUserModel *user = [WLDatabaseHelper user_find];
        if (self.user.userId == user.userId) {
            self.user = user;
        }
    }];
    
    [self addObserverForNotificationName:kNotificationUserLoginSucc usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        self.user = [WLDatabaseHelper user_find];
    }];
}

#pragma mark - propertys
- (UIImageView *)avatarV {
    if (!_avatarV) {
        _avatarV = [[UIImageView alloc] init];
        _avatarV.clipsToBounds = YES;
        _avatarV.contentMode = UIViewContentModeScaleAspectFill;
        _avatarV.layer.cornerRadius = 40;
        _avatarV.userInteractionEnabled = YES;
        _avatarV.layer.borderWidth = 2;
        _avatarV.layer.borderColor = [[k_COLOR_BLACK colorWithAlphaComponent:0.1] CGColor];
        _weak(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UIGestureRecognizer *gesture) {
            _strong_check(self);
            GCBlockInvoke(self.imageClickBlock);
        }];
        [_avatarV addGestureRecognizer:tap];
    }
    return _avatarV;
}

- (UILabel *)nickNameL {
    if (!_nickNameL) {
        _nickNameL = [[UILabel alloc] init];
        _nickNameL.backgroundColor = k_COLOR_CLEAR;
        _nickNameL.font = [UIFont boldSystemFontOfSize:18];
        _nickNameL.textColor = k_COLOR_WHITE;
        _nickNameL.textAlignment = NSTextAlignmentCenter;
        _weak(self);
        _nickNameL.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UIGestureRecognizer *gesture) {
            _strong_check(self);
            GCBlockInvoke(self.imageClickBlock);
        }];
        [_nickNameL addGestureRecognizer:tap];
    }
    return _nickNameL;
}

- (UIButton *)pointBtn {
    if (!_pointBtn) {
        _pointBtn = [[UIButton alloc] init];
        _pointBtn.backgroundColor = k_COLOR_MEDIUMTURQUOISE;
        _pointBtn.clipsToBounds = YES;
        _pointBtn.layer.cornerRadius = 4;
        [_pointBtn setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_pointBtn setTitleColor:k_COLOR_WHITESMOKE forState:UIControlStateHighlighted];
        _pointBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        _weak(self);
        [_pointBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.pointClickBlock);
        }];
    }
    return _pointBtn;
}

@end
