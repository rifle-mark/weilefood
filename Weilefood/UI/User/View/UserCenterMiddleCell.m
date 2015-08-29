//
//  UserCenterMiddleCell.m
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UserCenterMiddleCell.h"

@interface UserCenterMiddleCell ()

@property(nonatomic,strong)UIButton             *shareBtn;
@property(nonatomic,strong)UIButton             *msgBtn;
@property(nonatomic,strong)UIButton             *shopCarBtn;

@property(nonatomic,copy)OnShareClickBlock      shareBlock;
@property(nonatomic,copy)OnMsgClickBlock        msgBlock;
@property(nonatomic,copy)OnShopCarClickBlock    shopCarBlock;
@end

@implementation UserCenterMiddleCell

+ (NSString*)reuseIdentify {
    return @"UserCenterMiddleCellIdentify";
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_WHITESMOKE;
        
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.msgBtn];
        [self.contentView addSubview:self.shopCarBtn];
        
        [self _layoutSubViews];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)onMsgClickBlock:(OnMsgClickBlock)block {
    self.msgBlock = block;
}
- (void)onShareClickBlock:(OnShareClickBlock)block {
    self.shareBlock = block;
}
- (void)onShopCarClickBlock:(OnShopCarClickBlock)block {
    self.shopCarBlock = block;
}

#pragma mark - private method

- (void)_layoutSubViews {
    
    [self.msgBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.msgBtn.superview);
        make.top.equalTo(self.shareBtn.superview).with.offset(15);
        make.bottom.equalTo(self.shareBtn.superview).with.offset(-4);
        make.width.equalTo(@90);
    }];
    
    [self.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.msgBtn);
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        make.centerX.equalTo(self.msgBtn.mas_left).with.offset(-(screenWidth-90)/4);
    }];
    
    [self.shopCarBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.msgBtn);
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        make.centerX.equalTo(self.msgBtn.mas_right).with.offset((screenWidth-90)/4);
    }];
}

#pragma mark - propertys
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        _shareBtn.backgroundColor = k_COLOR_CLEAR;
        [_shareBtn setImage:[UIImage imageNamed:@"share_btn_n"] forState:UIControlStateNormal];
        _weak(self);
        [_shareBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.shareBlock);
        }];
    }
    
    return _shareBtn;
}

- (UIButton *)msgBtn {
    if (!_msgBtn) {
        _msgBtn = [[UIButton alloc] init];
        _msgBtn.backgroundColor = k_COLOR_CLEAR;
        [_msgBtn setImage:[UIImage imageNamed:@"msg_btn_n"] forState:UIControlStateNormal];
        _weak(self);
        [_msgBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.msgBlock);
        }];
    }
    return _msgBtn;
}

- (UIButton *)shopCarBtn {
    if (!_shopCarBtn) {
        _shopCarBtn = [[UIButton alloc] init];
        _shopCarBtn.backgroundColor = k_COLOR_CLEAR;
        [_shopCarBtn setImage:[UIImage imageNamed:@"shopcar_btn_n"] forState:UIControlStateNormal];
        _weak(self);
        [_shopCarBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.shopCarBlock);
        }];
    }
    return _shopCarBtn;
}
@end
