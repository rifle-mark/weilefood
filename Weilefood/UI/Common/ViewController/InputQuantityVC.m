//
//  InputQuantityVC.m
//  Weilefood
//
//  Created by kelei on 15/8/14.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "InputQuantityVC.h"

@interface InputQuantityVC ()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *quantityTitleLabel;
@property (nonatomic, strong) UILabel *quantityLabel;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *lessButton;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, assign) BOOL isShowContent;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, copy) EnterQuantityBlock enterQuantityBlock;

@property (nonatomic, assign) UIModalPresentationStyle pvcOldModalPresentationStyle;

@end

static NSInteger const kWhiteHeight = 105;
static NSInteger const kButtonHeight = 49;

@implementation InputQuantityVC

+ (void)inputQuantityWithEnterBlock:(EnterQuantityBlock)enterBlock {
    InputQuantityVC *vc = [[InputQuantityVC alloc] init];
    vc.enterQuantityBlock = enterBlock;
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
    
    self.quantity = 1;
    self.isShowContent = NO;
    
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.quantityTitleLabel];
    [self.contentView addSubview:self.quantityLabel];
    [self.contentView addSubview:self.addButton];
    [self.contentView addSubview:self.lessButton];
    [self.contentView addSubview:self.enterButton];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kWhiteHeight + kButtonHeight));
        if (self.isShowContent) {
            make.bottom.equalTo(self.view);
        }
        else {
            make.top.equalTo(self.view.mas_bottom);
        }
    }];
    [self.quantityTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@0);
        make.bottom.equalTo(self.enterButton.mas_top);
    }];
    [self.addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(self.quantityTitleLabel);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.quantityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.mas_left).offset(k1pxWidth);
        make.centerY.equalTo(self.addButton);
        make.size.mas_equalTo(CGSizeMake(60, 50));
    }];
    [self.lessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.quantityLabel.mas_left).offset(k1pxWidth);
        make.centerY.equalTo(self.quantityLabel);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.enterButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.enterButton.superview);
        make.height.equalTo(@(kButtonHeight));
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

#pragma mark - private property methods

- (void)setQuantity:(NSInteger)quantity {
    if (quantity < 1) {
        return;
    }
    _quantity = quantity;
    self.quantityLabel.text = [NSString stringWithFormat:@"%ld", (long)quantity];
    self.lessButton.enabled = quantity > 1;
}

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

- (UILabel *)quantityTitleLabel {
    if (!_quantityTitleLabel) {
        _quantityTitleLabel = [[UILabel alloc] init];
        _quantityTitleLabel.font = [UIFont systemFontOfSize:16];
        _quantityTitleLabel.textColor = k_COLOR_DIMGRAY;
        _quantityTitleLabel.text = @"选择数量";
    }
    return _quantityTitleLabel;
}

- (UILabel *)quantityLabel {
    if (!_quantityLabel) {
        _quantityLabel = [[UILabel alloc] init];
        _quantityLabel.font = [UIFont systemFontOfSize:20];
        _quantityLabel.textColor = k_COLOR_ORANGE;
        _quantityLabel.textAlignment = NSTextAlignmentCenter;
        _quantityLabel.layer.borderWidth = k1pxWidth;
        _quantityLabel.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
    }
    return _quantityLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.layer.borderWidth = k1pxWidth;
        _addButton.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        [_addButton setImage:[UIImage imageNamed:@"btn_add_n"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"btn_add_d"] forState:UIControlStateDisabled];
        _weak(self);
        [_addButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.quantity++;
        }];
    }
    return _addButton;
}

- (UIButton *)lessButton {
    if (!_lessButton) {
        _lessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lessButton.layer.borderWidth = k1pxWidth;
        _lessButton.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        [_lessButton setImage:[UIImage imageNamed:@"btn_less_n"] forState:UIControlStateNormal];
        [_lessButton setImage:[UIImage imageNamed:@"btn_less_d"] forState:UIControlStateDisabled];
        _weak(self);
        [_lessButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.quantity--;
        }];
    }
    return _lessButton;
}

- (UIButton *)enterButton {
    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterButton.backgroundColor = k_COLOR_ORANGE;
        [_enterButton setTitle:@"确定" forState:UIControlStateNormal];
        [_enterButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        _weak(self);
        [_enterButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.enterQuantityBlock, self, self.quantity);
        }];
    }
    return _enterButton;
}

@end
