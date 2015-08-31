//
//  SettingLogOutCell.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SettingLogOutCell.h"

@interface SettingLogOutCell ()

@property(nonatomic,strong)UIButton     *logOutBtn;

@end

@implementation SettingLogOutCell

+ (NSString *)reuseIdentify {
    return  @"SettingLogOutCellIdentify";
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.logOutBtn];
        
        [self _layoutSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - private
- (void)_layoutSubViews {
    [self.logOutBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logOutBtn.superview).with.offset(20);
        make.right.equalTo(self.logOutBtn.superview).with.offset(-20);
        make.centerY.equalTo(self.logOutBtn.superview);
        make.height.equalTo(@43);
    }];
}

#pragma mark - property
- (UIButton *)logOutBtn {
    if (!_logOutBtn) {
        _logOutBtn = [[UIButton alloc] init];
        _logOutBtn.clipsToBounds = YES;
        _logOutBtn.layer.cornerRadius = 4;
        _logOutBtn.backgroundColor = k_COLOR_GOLDENROD;
        [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logOutBtn setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_logOutBtn setTitleColor:k_COLOR_WHITESMOKE forState:UIControlStateHighlighted];
        _logOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        _weak(self);
        [_logOutBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.logOutBlock);
        }];
    }
    
    return _logOutBtn;
}

@end
