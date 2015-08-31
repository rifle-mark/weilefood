//
//  SettingAvatarCell.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SettingAvatarCell.h"
#import "WLModelHeader.h"
#import "WLDatabaseHelperHeader.h"

@interface SettingAvatarCell ()

@property(nonatomic,strong)UILabel      *settingTitleL;
@property(nonatomic,strong)UIImageView  *avatarV;
@property(nonatomic,strong)UIView       *lineV;

@end

@implementation SettingAvatarCell

+ (NSString *)reuseIdentify {
    return  @"SettingAvatarCellIdentify";
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        [self.contentView addSubview:self.settingTitleL];
        [self.contentView addSubview:self.avatarV];
        [self.contentView addSubview:self.lineV];
        
        [self _layoutSubViews];
        [self _setupObserver];
        
        self.user = [WLDatabaseHelper user_find];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - private
- (void)_layoutSubViews {
    [self.settingTitleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.settingTitleL.superview);
        make.left.equalTo(self.settingTitleL.superview).with.offset(15);
    }];
    [self.avatarV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarV.superview);
        make.right.equalTo(self.avatarV.superview).with.offset(-15);
        make.width.height.equalTo(@80);
    }];
    [self.lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineV.superview);
        make.left.equalTo(self.lineV.superview).with.offset(15);
        make.right.equalTo(self.lineV.superview).with.offset(-15);
        make.height.equalTo(@(0.4));
    }];
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"user" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.avatarV my_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:80 height:80 urlString:self.user.avatar]];
    }];
    
    [self addObserverForNotificationName:kNotificationUserInfoUpdate usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (self.user.userId == [WLDatabaseHelper user_find].userId) {
            self.user = [WLDatabaseHelper user_find];
        }
    }];
}

#pragma mark - property
- (UIImageView *)avatarV {
    if (!_avatarV) {
        _avatarV = [[UIImageView alloc] init];
        _avatarV.clipsToBounds = YES;
        _avatarV.layer.cornerRadius = 40;
    }
    return _avatarV;
}
- (UILabel *)settingTitleL {
    if (!_settingTitleL) {
        _settingTitleL = [[UILabel alloc] init];
        _settingTitleL.font = [UIFont boldSystemFontOfSize:16];
        _settingTitleL.textColor = k_COLOR_SLATEGRAY;
        _settingTitleL.text = @"头像";
    }
    return _settingTitleL;
}
- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineV;
}

@end
