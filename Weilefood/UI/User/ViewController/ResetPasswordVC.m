//
//  ResetPasswordVC.m
//  Weilefood
//
//  Created by kelei on 15/7/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

@interface ResetPasswordVC ()

@property (nonatomic, strong) UIView       *fixView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *contentView;

@property (nonatomic, strong) UITextField  *phoneTextField;
@property (nonatomic, strong) UITextField  *securityCodeTextField;
@property (nonatomic, strong) UITextField  *passwordTextField;
@property (nonatomic, strong) UITextField  *passwordConfirmTextField;

@property (nonatomic, strong) UIButton     *securityCodeButton;
@property (nonatomic, strong) UIButton     *submitButton;

/// 最近一次获取到的手机验证码
@property (nonatomic, copy  ) NSString     *lastSecurityCode;

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.fixView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    [self.contentView addSubview:self.phoneTextField];
    [self.contentView addSubview:self.securityCodeTextField];
    [self.contentView addSubview:self.passwordTextField];
    [self.contentView addSubview:self.passwordConfirmTextField];
    [self.contentView addSubview:self.securityCodeButton];
    [self.contentView addSubview:self.submitButton];
    
    [self.scrollView handleKeyboard];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@(self.topLayoutGuide.length));
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    [self.phoneTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(15, 15, 0, 15));
        make.height.equalTo(@40);
    }];
    [self.securityCodeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(5);
        make.left.height.equalTo(self.phoneTextField);
        make.right.equalTo(self.securityCodeButton.mas_left).offset(-5);
    }];
    [self.securityCodeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securityCodeTextField);
        make.right.height.equalTo(self.phoneTextField);
        make.width.equalTo(@100);
    }];
    [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securityCodeTextField.mas_bottom).offset(5);
        make.left.right.height.equalTo(self.phoneTextField);
    }];
    [self.passwordConfirmTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(5);
        make.left.right.height.equalTo(self.phoneTextField);
    }];
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordConfirmTextField.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.phoneTextField);
        make.bottom.equalTo(self.submitButton.superview).offset(-15);
    }];
}

#pragma mark - private methons

- (void)_securityCodeAction {
    NSString *phoneNum = self.phoneTextField.text;
    if (![phoneNum length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入手机号"];
        return;
    }
    
    _weak(self);
    self.securityCodeButton.enabled = NO;
    [[WLServerHelper sharedInstance] user_getPhoneCodeWithPhoneNum:phoneNum callback:^(WLApiInfoModel *apiInfo, NSString *phoneCode, NSError *error) {
        _strong_check(self);
        self.securityCodeButton.enabled = YES;
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        
        self.lastSecurityCode = phoneCode;
        DLog(@"验证码获取成功:%@", phoneCode);
        self.securityCodeButton.enabled = NO;
        [self performSelector:@selector(_enabledSecurityCodeButton) withObject:self afterDelay:20];
    }];
}

- (void)_enabledSecurityCodeButton {
    self.securityCodeButton.enabled = YES;
}

- (BOOL)_checkInput {
    if (![self.phoneTextField.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入手机号"];
        return NO;
    }
    if (![self.securityCodeTextField.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入验证码"];
        return NO;
    }
    if (![self.passwordTextField.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入新密码"];
        return NO;
    }
    if (![self.passwordConfirmTextField.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入重复密码"];
        return NO;
    }
    
    if (!self.lastSecurityCode) {
        [MBProgressHUD showErrorWithMessage:@"请获取手机验证码"];
        return NO;
    }
    if (![[self.securityCodeTextField.text uppercaseString] isEqualToString:self.lastSecurityCode]) {
        [MBProgressHUD showErrorWithMessage:@"验证码错误"];
        return NO;
    }
    if (self.passwordTextField.text.length < 6) {
        [MBProgressHUD showErrorWithMessage:@"密码不能少于6个字符"];
        return NO;
    }
    if (![self.passwordTextField.text isEqualToString:self.passwordConfirmTextField.text]) {
        [MBProgressHUD showErrorWithMessage:@"两次密码输入不一致"];
        return NO;
    }
    
    return YES;
}

- (void)_registerAction {
    if (![self _checkInput]) {
        return;
    }
    
    _weak(self);
    self.submitButton.enabled = NO;
    [[WLServerHelper sharedInstance] user_resetPasswordWithPhoneNum:self.phoneTextField.text password:self.passwordTextField.text callback:^(WLApiInfoModel *apiInfo, NSError *error) {
        _strong_check(self);
        self.submitButton.enabled = YES;
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        [MBProgressHUD showSuccessWithMessage:@"新密码设置成功！"];
    }];
}

#pragma mark - private property methons

- (UIView *)fixView{
    if (!_fixView) {
        _fixView = [[UIView alloc] init];
    }
    return _fixView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextField;
}

- (UITextField *)securityCodeTextField {
    if (!_securityCodeTextField) {
        _securityCodeTextField = [[UITextField alloc] init];
        _securityCodeTextField.placeholder = @"请输入短信验证码";
        _securityCodeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _securityCodeTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UITextField *)passwordConfirmTextField {
    if (!_passwordConfirmTextField) {
        _passwordConfirmTextField = [[UITextField alloc] init];
        _passwordConfirmTextField.placeholder = @"再次输入密码";
        _passwordConfirmTextField.secureTextEntry = YES;
    }
    return _passwordConfirmTextField;
}

- (UIButton *)securityCodeButton {
    if (!_securityCodeButton) {
        _securityCodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_securityCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_securityCodeButton addTarget:self action:@selector(_securityCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _securityCodeButton;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_submitButton setTitle:@"完成" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(_registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

@end
