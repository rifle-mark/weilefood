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
#import "InputView.h"

#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"
#import <UMengSocial/WXApi.h>

@interface LoginVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *contentView;

@property (nonatomic, strong) InputView *phoneView;
@property (nonatomic, strong) InputView *passwordView;
@property (nonatomic, strong) UIButton     *resetPasswordButton;
@property (nonatomic, strong) UIButton     *registerButton;
@property (nonatomic, strong) UIButton     *loginButton;

@property (nonatomic, strong) UILabel      *hintLabel;
@property (nonatomic, strong) UIView       *separateView;
@property (nonatomic, strong) UIButton     *weiboLoginButton;
@property (nonatomic, strong) UILabel      *weiboLabel;
@property (nonatomic, strong) UIButton     *weixinLoginButton;
@property (nonatomic, strong) UILabel      *weixinLabel;

@property (nonatomic, copy) LoggedBlock loggedBlock;

@end

@implementation LoginVC

+ (void)show {
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:YES completion:nil];
}

+ (void)needsLoginWithLoggedBlock:(LoggedBlock)block {
    WLUserModel *user = [WLDatabaseHelper user_find];
    if (user) {
        GCBlockInvoke(block, user);
    }
    else {
        LoginVC *vc = [[LoginVC alloc] init];
        vc.loggedBlock = block;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [UIBarButtonItem createCloseBarButtonItem]];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    
    [self.contentView addSubview:self.phoneView];
    [self.contentView addSubview:self.passwordView];
    [self.contentView addSubview:self.resetPasswordButton];
    [self.contentView addSubview:self.registerButton];
    [self.contentView addSubview:self.loginButton];
    [self.contentView addSubview:self.hintLabel];
    [self.contentView addSubview:self.separateView];
    [self.contentView addSubview:self.weiboLoginButton];
    [self.contentView addSubview:self.weiboLabel];
    if ([WXApi isWXAppInstalled]) {
        [self.contentView addSubview:self.weixinLoginButton];
        [self.contentView addSubview:self.weixinLabel];
    }
    [self.scrollView handleKeyboard];
    [self _addObserver];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    
    [self.phoneView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(15, 15, 0, 15));
    }];
    [self.passwordView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneView);
        make.top.equalTo(self.phoneView.mas_bottom).offset(5);
    }];
    [self.resetPasswordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom);
        make.left.equalTo(self.phoneView);
    }];
    [self.registerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneView);
        make.top.equalTo(self.resetPasswordButton.mas_bottom).offset(15);
        make.height.equalTo(@40);
        make.width.equalTo(self.loginButton);
    }];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.phoneView);
        make.top.width.height.equalTo(self.registerButton);
        make.left.equalTo(self.registerButton.mas_right).offset(15);
    }];
    [self.hintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).offset(50);
        make.left.equalTo(self.registerButton);
    }];
    [self.separateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.phoneView);
        make.height.equalTo(@1);
    }];
    
    if ([WXApi isWXAppInstalled]) {
        [self.weiboLoginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separateView.mas_bottom).offset(40);
            make.left.equalTo(self.separateView);
            make.width.equalTo(self.weixinLoginButton);
        }];
        [self.weixinLoginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.width.equalTo(self.weiboLoginButton);
            make.right.equalTo(self.separateView);
            make.left.equalTo(self.weiboLoginButton.mas_right).offset(15);
        }];
        [self.weixinLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.weixinLoginButton.mas_bottom).offset(15);
            make.centerX.equalTo(self.weixinLoginButton);
            make.height.equalTo(@(self.weixinLabel.font.lineHeight));
        }];
    }
    else {
        [self.weiboLoginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separateView.mas_bottom).offset(40);
            make.left.right.equalTo(self.separateView);
        }];
    }
    [self.weiboLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weiboLoginButton.mas_bottom).offset(15);
        make.centerX.equalTo(self.weiboLoginButton);
        make.height.equalTo(@(self.weiboLabel.font.lineHeight));
        make.bottom.equalTo(self.weiboLabel.superview).offset(-20);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_addObserver {
    _weak(self);
    [self addObserverForNotificationName:kNotificationUserLoginSucc usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (!notification.object || ![notification.object isKindOfClass:[WLUserModel class]]) {
            return;
        }
        [self dismissViewControllerAnimated:YES completion:^{
            _strong_check(self);
            GCBlockInvoke(self.loggedBlock, notification.object);
        }];
    }];
}

- (void)_resetPasswordAction {
    [self.navigationController pushViewController:[[ResetPasswordVC alloc] init] animated:YES];
}

- (void)_registerAction {
    [self.navigationController pushViewController:[[RegisterVC alloc] init] animated:YES];
}

- (void)_loginAction {
    if (![self.phoneView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入手机号"];
        return;
    }
    if (![self.passwordView.text length]) {
        [MBProgressHUD showErrorWithMessage:@"请输入密码"];
        return;
    }
    
    _weak(self);
    self.loginButton.enabled = NO;
    [[WLServerHelper sharedInstance] user_loginWithUserName:self.phoneView.text password:self.passwordView.text callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
        _strong_check(self);
        self.loginButton.enabled = YES;
        ServerHelperErrorHandle;
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
    
    _weak(self);
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:type];
    snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response){
        _strong_check(self);
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:type];
            DLog(@"昵称:%@, uid:%@, token:%@, 头像链接:%@", snsAccount.userName, snsAccount.usid, snsAccount.accessToken, snsAccount.iconURL);
            
            [[WLServerHelper sharedInstance] user_socialLoginWithPlatform:platform openId:snsAccount.usid token:snsAccount.accessToken avatar:snsAccount.iconURL appId:@"" nickName:snsAccount.userName callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                DLog(@"第三方平台登录成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoginSucc object:apiResult];
            }];
        }
    });
}

#pragma mark - private property methons

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
        _phoneView.titleWidth = 55;
        _phoneView.titleLabel.text = @"用户名";
        _phoneView.textField.placeholder = @"请输入手机号码";
        _phoneView.textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneView;
}

- (InputView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[InputView alloc] init];
        _passwordView.titleWidth = 55;
        _passwordView.titleLabel.text = @"密码";
        _passwordView.textField.secureTextEntry = YES;
        _passwordView.textField.returnKeyType = UIReturnKeyDone;
        _weak(self);
        [_passwordView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [view resignFirstResponder];
            [self _loginAction];
            return NO;
        }];
    }
    return _passwordView;
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
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.layer.cornerRadius = 4;
        _registerButton.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_registerButton setTitleColor:k_COLOR_THEME_NAVIGATIONBAR_TEXT forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(_registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.layer.cornerRadius = 4;
        _loginButton.backgroundColor = k_COLOR_ORANGE;
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(_loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.textColor = k_COLOR_DIMGRAY;
        _hintLabel.font = [UIFont systemFontOfSize:14];
        _hintLabel.text = @"或用以下方式登录";
    }
    return _hintLabel;
}

- (UIView *)separateView {
    if (!_separateView) {
        _separateView = [[UIView alloc] init];
        _separateView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _separateView;
}

- (UIButton *)weiboLoginButton {
    if (!_weiboLoginButton) {
        _weiboLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboLoginButton setImage:[UIImage imageNamed:@"share_icon_weibo"] forState:UIControlStateNormal];
        [_weiboLoginButton addTarget:self action:@selector(_weiboLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboLoginButton;
}

- (UILabel *)weiboLabel {
    if (!_weiboLabel) {
        _weiboLabel = [[UILabel alloc] init];
        _weiboLabel.textColor = k_COLOR_DIMGRAY;
        _weiboLabel.font = [UIFont systemFontOfSize:14];
        _weiboLabel.text = @"微博登录";
    }
    return _weiboLabel;
}

- (UIButton *)weixinLoginButton {
    if (!_weixinLoginButton) {
        _weixinLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weixinLoginButton setImage:[UIImage imageNamed:@"share_icon_wx"] forState:UIControlStateNormal];
        [_weixinLoginButton addTarget:self action:@selector(_weixinLoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinLoginButton;
}

- (UILabel *)weixinLabel {
    if (!_weixinLabel) {
        _weixinLabel = [[UILabel alloc] init];
        _weixinLabel.textColor = k_COLOR_DIMGRAY;
        _weixinLabel.font = [UIFont systemFontOfSize:14];
        _weixinLabel.text = @"微信登录";
    }
    return _weixinLabel;
}

@end
