//
//  SettingClearCacheCell.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SettingClearCacheCell.h"

@interface SettingClearCacheCell ()

@property(nonatomic,strong)UILabel      *settingTitleL;
@property(nonatomic,strong)UILabel      *cacheL;
@property(nonatomic,strong)UIView       *lineV;

@end

@implementation SettingClearCacheCell

+ (NSString *)reuseIdentify {
    return  @"SettingClearCacheCellIdentify";
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        [self.contentView addSubview:self.settingTitleL];
        [self.contentView addSubview:self.cacheL];
        [self.contentView addSubview:self.lineV];
        
        [self _layoutSubViews];
        
        [self calculateAndRefreshCacheSize];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)calculateAndRefreshCacheSize {
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        self.cacheL.text = [NSString stringWithFormat:@"%.1fM", totalSize/1024.0/1024.0];
    }];
}

#pragma mark - private
- (void)_layoutSubViews {
    [self.settingTitleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.settingTitleL.superview);
        make.left.equalTo(self.settingTitleL.superview).with.offset(15);
    }];
    [self.cacheL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cacheL.superview);
        make.right.equalTo(self.cacheL.superview).with.offset(-15);
    }];
    [self.lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineV.superview);
        make.left.equalTo(self.lineV.superview).with.offset(15);
        make.right.equalTo(self.lineV.superview).with.offset(-15);
        make.height.equalTo(@(0.4));
    }];
}

#pragma mark - property
- (UILabel *)settingTitleL {
    if (!_settingTitleL) {
        _settingTitleL = [[UILabel alloc] init];
        _settingTitleL.font = [UIFont boldSystemFontOfSize:16];
        _settingTitleL.textColor = k_COLOR_SLATEGRAY;
        _settingTitleL.text = @"清理缓存";
    }
    return _settingTitleL;
}

- (UILabel *)cacheL {
    if (!_cacheL) {
        _cacheL = [[UILabel alloc] init];
        _cacheL.font = [UIFont boldSystemFontOfSize:15];
        _cacheL.textColor = k_COLOR_MEDIUMTURQUOISE;
        _cacheL.textAlignment = NSTextAlignmentRight;
    }
    return _cacheL;
}

- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineV;
}
@end
