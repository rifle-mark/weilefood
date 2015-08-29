//
//  SelectPayPlatformVC.m
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SelectPayPlatformVC.h"

@interface SelectPayPlatformVC ()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, strong) UILabel  *moneyLabel;
@property (nonatomic, strong) UIButton *alipayButton;
@property (nonatomic, strong) UIButton *weixinButton;
@property (nonatomic, strong) UIButton *yeepayButton;

@property (nonatomic, assign) BOOL isShowContent;
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, copy) SelectPayPlatformVCSelectBlock selectBlock;

@property (nonatomic, assign) UIModalPresentationStyle pvcOldModalPresentationStyle;

@end

@implementation SelectPayPlatformVC

+ (void)selectPayPlatformWithMoney:(CGFloat)money selectBlock:(SelectPayPlatformVCSelectBlock)selectBlock {
    SelectPayPlatformVC *vc = [[SelectPayPlatformVC alloc] init];
    vc.money = money;
    vc.selectBlock = selectBlock;
    UIViewController *pvc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (SYSTEM_VERSION_LESS_THAN(@"8")) {
        vc.pvcOldModalPresentationStyle = pvc.modalPresentationStyle;
        pvc.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    else {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [pvc presentViewController:vc animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_CLEAR;
    self.view.layer.backgroundColor = k_COLOR_CLEAR.CGColor;
    
    self.isShowContent = NO;
    
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.alipayButton];
    [self.contentView addSubview:self.weixinButton];
    [self.contentView addSubview:self.yeepayButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (self.isShowContent) {
            make.bottom.equalTo(self.view);
        }
        else {
            make.top.equalTo(self.view.mas_bottom);
        }
    }];
    [self.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 11, 0, 11));
        make.height.equalTo(@46);
    }];
    [self.weixinButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.moneyLabel);
        make.top.equalTo(self.moneyLabel.mas_bottom);
        make.height.equalTo(@40);
    }];
    [self.alipayButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.weixinButton);
        make.top.equalTo(self.weixinButton.mas_bottom).offset(8);
    }];
    [self.yeepayButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.alipayButton);
        make.top.equalTo(self.alipayButton.mas_bottom).offset(8);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.backgroundColor = [k_COLOR_BLACK colorWithAlphaComponent:0.5].CGColor;
        self.isShowContent = YES;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - public methods

- (void)dismissSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.backgroundColor = k_COLOR_CLEAR.CGColor;
        self.isShowContent = NO;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.presentingViewController && SYSTEM_VERSION_LESS_THAN(@"8")) {
            self.presentingViewController.modalPresentationStyle = self.pvcOldModalPresentationStyle;
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - private methods

- (void)_buttonAction:(UIButton *)sender {
    GCBlockInvoke(self.selectBlock, self, sender.tag);
}

- (UIButton *)_createButtonWithPlatform:(SelectPayPlatform)platform {
    return ({
        NSString *title = nil;
        switch (platform) {
            case SelectPayPlatformWeixin:
                title = @"微信支付";
                break;
            case SelectPayPlatformYeepay:
                title = @"易宝支付";
                break;
            default:
                title = @"支付宝支付";
                break;
        }
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.backgroundColor = k_COLOR_MEDIUM_AQUAMARINE;
        v.titleLabel.font = [UIFont systemFontOfSize:17];
        v.layer.cornerRadius = 3;
        v.tag = platform;
        [v setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [v setTitle:title forState:UIControlStateNormal];
        [v addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        v;
    });
}

#pragma mark - private property methods

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weak(self);
        [_closeButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self dismissSelf];
        }];
    }
    return _closeButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = k_COLOR_WHITE;
    }
    return _contentView;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = k_COLOR_LUST;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f", self.money];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
        [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"总计:" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
        [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:moneyStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
        _moneyLabel.attributedText = attributedText;
    }
    return _moneyLabel;
}

- (UIButton *)alipayButton {
    if (!_alipayButton) {
        _alipayButton = [self _createButtonWithPlatform:SelectPayPlatformAlipay];
    }
    return _alipayButton;
}

- (UIButton *)weixinButton {
    if (!_weixinButton) {
        _weixinButton = [self _createButtonWithPlatform:SelectPayPlatformWeixin];
    }
    return _weixinButton;
}

- (UIButton *)yeepayButton {
    if (!_yeepayButton) {
        _yeepayButton = [self _createButtonWithPlatform:SelectPayPlatformYeepay];
    }
    return _yeepayButton;
}

@end
