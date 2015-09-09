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
@property(nonatomic,strong)UIImageView          *newMessageImageView;

@property(nonatomic,copy)OnShareClickBlock      shareBlock;
@property(nonatomic,copy)OnMsgClickBlock        msgBlock;
@property(nonatomic,copy)OnShopCarClickBlock    shopCarBlock;
@end

@implementation UserCenterMiddleCell

+ (NSString*)reuseIdentify {
    return @"UserCenterMiddleCellIdentify";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_WHITESMOKE;
        
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.msgBtn];
        [self.contentView addSubview:self.shopCarBtn];
        [self.contentView addSubview:self.newMessageImageView];
        
        self.displayNewMessage = NO;
        [self _layoutSubViews];
        
    }
    return self;
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

#pragma mark - public methods

- (void)setDisplayNewMessage:(BOOL)displayNewMessage {
    _displayNewMessage = displayNewMessage;
    self.newMessageImageView.hidden = !displayNewMessage;
}

#pragma mark - private method

- (void)_layoutSubViews {
    
    [self.msgBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.msgBtn.superview);
        make.top.equalTo(self.shareBtn.superview).with.offset(15);
        make.bottom.equalTo(self.shareBtn.superview).with.offset(-4);
        make.width.equalTo(@100);
    }];
    
    [self.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.msgBtn);
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        make.centerX.equalTo(self.msgBtn.mas_left).with.offset(-(screenWidth-100)/4);
    }];
    
    [self.shopCarBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.msgBtn);
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        make.centerX.equalTo(self.msgBtn.mas_right).with.offset((screenWidth-100)/4);
    }];
    
    [self.newMessageImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.msgBtn).offset(10);
    }];
}

#pragma mark - propertys

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        _shareBtn.backgroundColor = k_COLOR_CLEAR;
        [_shareBtn setImage:[UIImage imageNamed:@"share_btn_n"] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"我的发帖" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_shareBtn setTitleColor:k_COLOR_STAR_DUST forState:UIControlStateNormal];
        [_shareBtn setImageToTop];
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
        [_msgBtn setTitle:@"我的私信" forState:UIControlStateNormal];
        _msgBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_msgBtn setTitleColor:k_COLOR_STAR_DUST forState:UIControlStateNormal];
        [_msgBtn setImageToTop];
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
        [_shopCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
        _shopCarBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [_shopCarBtn setTitleColor:k_COLOR_STAR_DUST forState:UIControlStateNormal];
        [_shopCarBtn setImageToTop];
        _weak(self);
        [_shopCarBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.shopCarBlock);
        }];
    }
    return _shopCarBtn;
}

- (UIImageView *)newMessageImageView {
    if (!_newMessageImageView) {
        _newMessageImageView = [[UIImageView alloc] init];
        _newMessageImageView.image = [UIImage imageNamed:@"icon_newmessage"];
    }
    return _newMessageImageView;
}

@end
