//
//  LoginVC.m
//  Weilefood
//
//  Created by kelei on 15/7/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ResetPasswordVC.h"

#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

@interface LoginVC ()

@property (nonatomic, strong) UIView       *fixView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *contentView;

@property (nonatomic, strong) UITextField  *phoneTextField;
@property (nonatomic, strong) UITextField  *passwordTextField;
@property (nonatomic, strong) UIButton     *resetPasswordButton;
@property (nonatomic, strong) UIButton     *registerButton;
@property (nonatomic, strong) UIButton     *loginButton;

@property (nonatomic, strong) UILabel      *hintLabel;
@property (nonatomic, strong) UIView       *separateView;
@property (nonatomic, strong) UIButton     *weiboLoginButton;
@property (nonatomic, strong) UIButton     *weixinLoginButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.fixView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    [self.contentView addSubview:self.phoneTextField];
    [self.contentView addSubview:self.passwordTextField];
    [self.contentView addSubview:self.resetPasswordButton];
    [self.contentView addSubview:self.registerButton];
    [self.contentView addSubview:self.loginButton];
    [self.contentView addSubview:self.hintLabel];
    [self.contentView addSubview:self.separateView];
    [self.contentView addSubview:self.weiboLoginButton];
    [self.contentView addSubview:self.weixinLoginButton];
    
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
    [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(5);
        make.left.right.height.equalTo(self.phoneTextField);
    }];
    [self.resetPasswordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom);
        make.left.equalTo(self.phoneTextField);
    }];
    [self.registerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField);
        make.top.equalTo(self.resetPasswordButton.mas_bottom).offset(15);
        make.height.equalTo(@40);
        make.width.equalTo(self.loginButton);
    }];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordTextField);
        make.top.width.height.equalTo(self.registerButton);
        make.left.equalTo(self.registerButton.mas_right).offset(15);
    }];
    [self.hintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).offset(50);
        make.left.equalTo(self.registerButton);
    }];
    [self.separateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.passwordTextField);
        make.height.equalTo(@1);
    }];
    [self.weiboLoginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separateView.mas_bottom).offset(40);
        make.left.equalTo(self.separateView);
        make.width.equalTo(self.weixinLoginButton);
    }];
    [self.weixinLoginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.equalTo(self.weiboLoginButton);
        make.right.equalTo(self.separateView);
        make.left.equalTo(self.weiboLoginButton.mas_right).offset(15);
        make.bottomMargin.equalTo(@-15);
    }];
}

#pragma mark - private methons

- (void)_resetPasswordAction {
    [self.navigationController pushViewController:[[ResetPasswordVC alloc] init] animated:YES];
}

- (void)_registerAction {
    [self.navigationController pushViewController:[[RegisterVC alloc] init] animated:YES];
}

- (void)_loginAction {
    if (![self.phoneTextField.text length]) {
        [MBProgressHUD showErrorWithView:self.view message:@"请输入手机号"];
        return;
    }
    if (![self.passwordTextField.text length]) {
        [MBProgressHUD showErrorWithView:self.view message:@"请输入密码"];
        return;
    }
    
    _weak(self);
    self.loginButton.enabled = NO;
    [[WLServerHelper sharedInstance] user_loginWithUserName:self.phoneTextField.text password:self.passwordTextField.text callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
        _strong_check(self);
        self.loginButton.enabled = YES;
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithView:self.view message:apiInfo.message];
            return;
        }
        DLog(@"登录成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoginSucc object:apiResult];
    }];
}

- (void)_weiboLoginAction {
    [self _socialLoginWithUMType:UMShareToSina];
}

- (void)_weixinLoginAction {
    [self _socialLoginWithUMType:UMShareToWechatSession];
}

- (void)_socialLoginWithUMType:(NSString *)type {
    WLUserPlatform platform;
    
    if ([type isEqualToString:UMShareToSina]) {
        platform = WLUserPlatformSinaWeibo;
    }
    else if ([type isEqualToString:UMShareToWechatSession]) {
        platform = WLUserPlatformWechat;
    }
    else
        NSAssert(NO, @"不支持此平台登录");
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:type];
    snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:type];
            NSLog(@"昵称:%@, uid:%@, token:%@, 头像链接:%@", snsAccount.userName, snsAccount.usid, snsAccount.accessToken, snsAccount.iconURL);
            
            [[WLServerHelper sharedInstance] user_socialLoginWithPlatform:platform openId:snsAccount.usid token:snsAccount.accessToken avatar:snsAccount.iconURL appId:@"" nickName:snsAccount.userName callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
                if (error) {
                    DLog(@"%@", error);
                    return;
                }
                if (!apiInfo.isSuc) {
                    [MBProgressHUD showErrorWithView:self.view message:apiInfo.message];
                    return;
                }
                DLog(@"第三方平台登录成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoginSucc object:apiResult];
            }];
        }
    });
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

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton *)resetPasswordButton {
    if (!_resetPasswordButton) {
        _resetPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_resetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_resetPasswordButton addTarget:self action:@selector(_resetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetPasswordButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(_registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(_loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.textColor = [UIColor grayColor];
        _hintLabel.text = @"或用以下方式登录";
    }
    return _hintLabel;
}

- (UIView *)separateView {
    if (!_separateView) {
        _separateView = [[UIView alloc] init];
        _separateView.backgroundColor = [UIColor grayColor];
    }
    return _separateView;
}

- (UIButton *)weiboLoginButton {
    if (!_weiboLoginButton) {
        _weiboLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_weiboLoginButton setTitle:@"微博登录" forState:UIControlStateNormal];
        [_weiboLoginButton addTarget:self action:@selector(_weiboLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboLoginButton;
}

- (UIButton *)weixinLoginButton {
    if (!_weixinLoginButton) {
        _weixinLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_weixinLoginButton setTitle:@"微信登录" forState:UIControlStateNormal];
        [_weixinLoginButton addTarget:self action:@selector(_weixinLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinLoginButton;
}

@end
