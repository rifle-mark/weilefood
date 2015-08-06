//
//  ProductSectionHeaderView.m
//  Weilefood
//
//  Created by kelei on 15/8/6.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ProductSectionHeaderView.h"

@interface ProductSectionHeaderView ()

@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIView   *lineView;

@property (nonatomic, copy) GCAOPInterceptorBlock actionBlock;
@property (nonatomic, copy) GCAOPInterceptorBlock commentBlock;
@property (nonatomic, copy) GCAOPInterceptorBlock shareBlock;

@end

static NSInteger const kButtonMargin = 10;
static NSInteger const kButtonHeight = 30;
static NSInteger const kLineHeight = 4;

@implementation ProductSectionHeaderView

+ (CGFloat)viewHeight {
    return kButtonMargin * 2 + kButtonHeight + kLineHeight;
}

- (id)init {
    if (self = [super init]) {
        [self addSubview:self.actionButton];
        [self addSubview:self.commentButton];
        [self addSubview:self.shareButton];
        [self addSubview:self.lineView];
        
        [self _makeConstraints];
    }
    return self;
}

- (void)_makeConstraints {
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(kButtonMargin);
        make.height.equalTo(@(kButtonHeight));
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.actionButton);
        make.left.equalTo(self.actionButton.mas_right).offset(5);
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.actionButton);
        make.right.equalTo(self).offset(-kButtonMargin);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(kLineHeight));
    }];
}

#pragma mark - public methods

- (void)setActionCount:(NSInteger)actionCount {
    _actionCount = actionCount;
    [self.actionButton setTitle:[NSString stringWithFormat:@"%ld", (long)actionCount] forState:UIControlStateNormal];
}

- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld", (long)commentCount] forState:UIControlStateNormal];
}

- (void)actionBlock:(GCAOPInterceptorBlock)block {
    self.actionBlock = block;
}

- (void)commentBlock:(GCAOPInterceptorBlock)block {
    self.commentBlock = block;
}

- (void)shareBlock:(GCAOPInterceptorBlock)block {
    self.shareBlock = block;
}

#pragma mark - private property methods

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _actionButton.layer.borderColor = k_COLOR_GOLDENROD.CGColor;
        _actionButton.layer.borderWidth = 1;
        [_actionButton setTitleColor:k_COLOR_GOLDENROD forState:UIControlStateNormal];
        _weak(self);
        [_actionButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.actionBlock);
        }];
    }
    return _actionButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _commentButton.layer.borderColor = k_COLOR_GOLDENROD.CGColor;
        _commentButton.layer.borderWidth = 1;
        [_commentButton setTitleColor:k_COLOR_GOLDENROD forState:UIControlStateNormal];
        _weak(self);
        [_commentButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.commentBlock);
        }];
    }
    return _commentButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _shareButton.backgroundColor = k_COLOR_GOLDENROD;
        [_shareButton setTitleColor:k_COLOR_GOLDENROD forState:UIControlStateNormal];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        _weak(self);
        [_shareButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.shareBlock);
        }];
    }
    return _shareButton;
}

@end
