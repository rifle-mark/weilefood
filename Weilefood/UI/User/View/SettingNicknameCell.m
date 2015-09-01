//
//  SettingNicknameCell.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SettingNicknameCell.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

@interface SettingNicknameCell ()

@property(nonatomic,strong)UILabel      *settingTitleL;
@property(nonatomic,strong)UILabel      *nickNameL;
@property(nonatomic,strong)UIImageView  *arrawV;
@property(nonatomic,strong)UIView       *lineV;

@end

@implementation SettingNicknameCell

+ (NSString *)reuseIdentify {
    return  @"SettingNicknameCellIdentify";
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        [self.contentView addSubview:self.settingTitleL];
        [self.contentView addSubview:self.nickNameL];
        [self.contentView addSubview:self.arrawV];
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
    [self.arrawV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.arrawV.superview);
        make.right.equalTo(self.arrawV.superview).with.offset(-15);
        make.size.mas_equalTo(self.arrawV.image.size);
    }];
    [self.nickNameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nickNameL.superview);
        make.right.equalTo(self.arrawV.mas_left).with.offset(-4);
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
        self.nickNameL.text = self.user.nickName;
    }];
    
    [self addObserverForNotificationName:kNotificationUserInfoUpdate usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (self.user.userId == [WLDatabaseHelper user_find].userId) {
            self.user = [WLDatabaseHelper user_find];
        }
    }];
}

#pragma mark - property
- (UILabel *)settingTitleL {
    if (!_settingTitleL) {
        _settingTitleL = [[UILabel alloc] init];
        _settingTitleL.font = [UIFont boldSystemFontOfSize:16];
        _settingTitleL.textColor = k_COLOR_SLATEGRAY;
        _settingTitleL.text = @"昵称";
    }
    return _settingTitleL;
}

- (UILabel *)nickNameL {
    if (!_nickNameL) {
        _nickNameL = [[UILabel alloc] init];
        _nickNameL.font = [UIFont boldSystemFontOfSize:15];
        _nickNameL.textColor = k_COLOR_STAR_DUST;
        _nickNameL.textAlignment = NSTextAlignmentRight;
    }
    return _nickNameL;
}

- (UIImageView *)arrawV {
    if (!_arrawV) {
        _arrawV = [[UIImageView alloc] init];
        _arrawV.image = [UIImage imageNamed:@"discovery_all_icon_n"];
    }
    return _arrawV;
}

- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineV;
}
@end
