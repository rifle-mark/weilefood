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
static NSInteger const kLineHeight = 7;

@implementation ProductSectionHeaderView

+ (CGFloat)viewHeight {
    return kButtonMargin * 2 + [UIImage imageNamed:@"productinfo_btn_action_n"].size.height + kLineHeight;
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
        make.size.mas_equalTo([self.actionButton backgroundImageForState:UIControlStateNormal].size);
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
        [_actionButton setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_actionButton setBackgroundImage:[UIImage imageNamed:@"productinfo_btn_action_n"] forState:UIControlStateNormal];
        [_actionButton setBackgroundImage:[UIImage imageNamed:@"productinfo_btn_action_h"] forState:UIControlStateHighlighted];
        [_actionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
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
        [_commentButton setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"productinfo_btn_comment_n"] forState:UIControlStateNormal];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"productinfo_btn_comment_h"] forState:UIControlStateHighlighted];
        [_commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
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
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"productinfo_btn_share_n"] forState:UIControlStateNormal];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"productinfo_btn_share_h"] forState:UIControlStateHighlighted];
        _weak(self);
        [_shareButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.shareBlock);
        }];
    }
    return _shareButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineView;
}

@end
