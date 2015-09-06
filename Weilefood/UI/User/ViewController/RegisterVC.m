//
//  RegisterVC.m
//  Weilefood
//
//  Created by kelei on 15/7/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "RegisterVC.h"
#import "InputView.h"
#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

@interface RegisterVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *contentView;
@property (nonatomic, strong) InputView    *phoneView;
@property (nonatomic, strong) InputView    *securityCodeView;
@property (nonatomic, strong) InputView    *passwordView;
@property (nonatomic, strong) InputView    *passwordConfirmView;
@property (nonatomic, strong) InputView    *nicknameView;
@property (nonatomic, strong) UIButton     *securityCodeButton;
@property (nonatomic, strong) UIButton     *submitButton;

@property (nonatomic, assign) BOOL      securityCodeButtonEnabled;
@property (nonatomic, assign) NSInteger securityCodeCountdown;
/// 最近一次获取到的手机验证码的手机号
@property (nonatomic, copy  ) NSString  *lastPhone;
/// 最近一次获取到的手机验证码
@property (nonatomic, copy  ) NSString  *lastSecurityCode;

@end

#define kPhoneNumberRegex @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
static NSInteger const kTitleWidth = 85;
static NSInteger const kSecurityCodeInterval = 60;//秒

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    [self.contentView addSubview:self.phoneView];
    [self.contentView addSubview:self.securityCodeView];
    [self.contentView addSubview:self.passwordView];
    [self.contentView addSubview:self.passwordConfirmView];
    [self.contentView addSubview:self.nicknameView];
    [self.contentView addSubview:self.securityCodeButton];
    [self.contentView addSubview:self.submitButton];
    
    [self.securityCodeView addSubview:self.securityCodeButton];
    
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
    
    [self.phoneView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(15, 15, 0, 15));
    }];
    [self.securityCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneView);
        make.top.equalTo(self.phoneView.mas_bottom).offset(5);
    }];
    [self.securityCodeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.securityCodeView);
        make.width.equalTo(@100);
    }];
    [self.securityCodeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.securityCodeView.titleLabel.mas_right).offset(10);
        make.right.equalTo(self.securityCodeButton.mas_left);
        make.top.bottom.equalTo(self.securityCodeView);
    }];
    [self.passwordView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.securityCodeView);
        make.top.equalTo(self.securityCodeView.mas_bottom).offset(5);
    }];
    [self.passwordConfirmView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.passwordView);
        make.top.equalTo(self.passwordView.mas_bottom).offset(5);
    }];
    [self.nicknameView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.passwordConfirmView);
        make.top.equalTo(self.passwordConfirmView.mas_bottom).offset(5);
    }];
    
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameView.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.nicknameView);
        make.bottom.equalTo(self.submitButton.superview).offset(-15);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_securityCodeAction {
    NSString *phoneNum = self.phoneView.text;
    if (![phoneNum length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入手机号"];
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kPhoneNumberRegex];
    if (![predicate evaluateWithObject:phoneNum]) {
        [MBProgressHUD showErrorWithMessage:@"手机号无效，请确认手机号是否输入正确"];
        return;
    }
    
    self.lastPhone = nil;
    self.lastSecurityCode = nil;
    _weak(self);
    self.securityCodeButtonEnabled = NO;
    [[WLServerHelper sharedInstance] user_getPhoneCodeWithPhoneNum:phoneNum callback:^(WLApiInfoModel *apiInfo, NSString *phoneCode, NSError *error) {
        _strong_check(self);
        self.securityCodeButtonEnabled = YES;
        ServerHelperErrorHandle;
        self.lastPhone = phoneNum;
        self.lastSecurityCode = phoneCode;
        DLog(@"验证码获取成功:%@", phoneCode);
        self.securityCodeButtonEnabled = NO;
        self.securityCodeCountdown = kSecurityCodeInterval;
        [self.securityCodeButton setTitle:[NSString stringWithFormat:@"%ld", (long)self.securityCodeCountdown] forState:UIControlStateDisabled];
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES action:^(NSTimer *timer) {
            _strong_check(self);
            self.securityCodeCountdown--;
            if (self.securityCodeCountdown <= 0) {
                [timer invalidate];
                self.securityCodeButtonEnabled = YES;
            }
            else {
                [self.securityCodeButton setTitle:[NSString stringWithFormat:@"%ld", (long)self.securityCodeCountdown] forState:UIControlStateDisabled];
            }
        }];
    }];
}

- (BOOL)_checkInput {
    if (![self.phoneView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入手机号"];
        return NO;
    }
    if (![self.securityCodeView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入验证码"];
        return NO;
    }
    if (![self.passwordView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入密码"];
        return NO;
    }
    if (![self.passwordConfirmView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入重复密码"];
        return NO;
    }
    if (![self.nicknameView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入昵称"];
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kPhoneNumberRegex];
    if (![predicate evaluateWithObject:self.phoneView.text]) {
        [MBProgressHUD showErrorWithMessage:@"手机号无效，请确认手机号是否输入正确"];
        return NO;
    }
    if (!self.lastPhone || !self.lastSecurityCode) {
        [MBProgressHUD showErrorWithMessage:@"请获取手机验证码"];
        return NO;
    }
    if (![self.lastPhone isEqualToString:self.phoneView.text]) {
        [MBProgressHUD showErrorWithMessage:@"请重新获取手机验证码"];
        return NO;
    }
    if (![[self.securityCodeView.text uppercaseString] isEqualToString:self.lastSecurityCode]) {
        [MBProgressHUD showErrorWithMessage:@"验证码错误"];
        return NO;
    }
    if (self.passwordView.text.length < 6) {
        [MBProgressHUD showErrorWithMessage:@"密码不能少于6个字符"];
        return NO;
    }
    if (![self.passwordView.text isEqualToString:self.passwordConfirmView.text]) {
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
    [[WLServerHelper sharedInstance] user_regWithUserName:self.phoneView.text password:self.passwordView.text nickname:self.nicknameView.text callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
        _strong_check(self);
        self.submitButton.enabled = YES;
        ServerHelperErrorHandle;
        DLog(@"注册成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoginSucc object:apiResult];
    }];
}

#pragma mark - private property methons

- (void)setSecurityCodeButtonEnabled:(BOOL)securityCodeButtonEnabled {
    self.securityCodeButton.enabled = securityCodeButtonEnabled;
    self.securityCodeButton.backgroundColor = securityCodeButtonEnabled ? k_COLOR_ORANGE : k_COLOR_STAR_DUST;
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

- (InputView *)phoneView {
    if (!_phoneView) {
        _phoneView = [[InputView alloc] init];
        _phoneView.titleWidth = kTitleWidth;
        _phoneView.titleLabel.text = @"用户名";
        _phoneView.textField.placeholder = @"请输入手机号码";
        _phoneView.textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneView;
}

- (InputView *)securityCodeView {
    if (!_securityCodeView) {
        _securityCodeView = [[InputView alloc] init];
        _securityCodeView.titleWidth = kTitleWidth;
        _securityCodeView.titleLabel.text = @"验证码";
        _securityCodeView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _securityCodeView.textField.returnKeyType = UIReturnKeyNext;
        _weak(self);
        [_securityCodeView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self.passwordView.textField becomeFirstResponder];
            return NO;
        }];
    }
    return _securityCodeView;
}

- (InputView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[InputView alloc] init];
        _passwordView.titleWidth = kTitleWidth;
        _passwordView.titleLabel.text = @"密码";
        _passwordView.textField.secureTextEntry = YES;
        _passwordView.textField.returnKeyType = UIReturnKeyNext;
        _weak(self);
        [_passwordView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self.passwordConfirmView.textField becomeFirstResponder];
            return NO;
        }];
    }
    return _passwordView;
}

- (InputView *)passwordConfirmView {
    if (!_passwordConfirmView) {
        _passwordConfirmView = [[InputView alloc] init];
        _passwordConfirmView.titleWidth = kTitleWidth;
        _passwordConfirmView.titleLabel.text = @"再次输入密码";
        _passwordConfirmView.textField.secureTextEntry = YES;
        _passwordConfirmView.textField.returnKeyType = UIReturnKeyNext;
        _weak(self);
        [_passwordConfirmView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self.nicknameView.textField becomeFirstResponder];
            return NO;
        }];
    }
    return _passwordConfirmView;
}

- (InputView *)nicknameView {
    if (!_nicknameView) {
        _nicknameView = [[InputView alloc] init];
        _nicknameView.titleWidth = kTitleWidth;
        _nicknameView.titleLabel.text = @"昵称";
        _nicknameView.textField.returnKeyType = UIReturnKeyDone;
        _weak(self);
        [_nicknameView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self _registerAction];
            return NO;
        }];
    }
    return _nicknameView;
}

- (UIButton *)securityCodeButton {
    if (!_securityCodeButton) {
        _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _securityCodeButton.layer.cornerRadius = 4;
        _securityCodeButton.backgroundColor = k_COLOR_ORANGE;
        _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_securityCodeButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_securityCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_securityCodeButton addTarget:self action:@selector(_securityCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _securityCodeButton;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.layer.cornerRadius = 4;
        _submitButton.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton setTitleColor:k_COLOR_THEME_NAVIGATIONBAR_TEXT forState:UIControlStateNormal];
        [_submitButton setTitle:@"注册" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(_registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

@end
