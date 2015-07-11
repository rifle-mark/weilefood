//
//  ViewController.m
//  LawyerCenter
//
//  Created by kelei on 15/6/19.
//  Copyright (c) 2015年 kelei. All rights reserved.
//


/**
 *  UIViewController中的代码结构参照本文
 */


#import "ViewController.h"

@interface ViewController ()<ViewControllerDelegate>

// 注意格式，属性名后面接类型名
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton    *loginButton;

@end

@implementation ViewController

#pragma mark - life cycle(生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    // 这里设置view样式，直接写代码不用单独封装方法
    self.view.backgroundColor = [UIColor whiteColor];
    // 这里添加subviews，view的创建都在property getter方法中实现，直接写代码不用单独封装方法
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    // 这里添加观察者，调用单独封装的方法_setupObserve
    [self _setupObserve];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 在viewDidLayoutSubviews设置subviews的约束，直接写代码不用单独封装方法
    // 这里使用mas_remake是因为在ViewController生命周期内viewDidLayoutSubviews可能触发多次。如：切换设备方向
    [self.userNameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.userNameTextField.superview).width.offset(20);
    }];
    [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.userNameTextField);
        make.top.equalTo(self.userNameTextField.mas_bottom).offset(20);
    }];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.passwordTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(20);
    }];
}

#pragma mark - public methods(实现公开方法)

- (NSData *)getDataWithStr:(NSString *)str {
    return nil;
}

#pragma mark - ViewControllerDelegate(协议实现)

- (void)handle {
    
}

#pragma mark - event response(实现响应事件)
#pragma 所有内部私有方法名都以“_”开头

- (void)_loginAction:(UIButton *)sender {
    
}

#pragma mark - private methods(实现私有方法)

- (void)_setupObserve {
    [self startObserveObject:self forKeyPath:@"str" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        NSLog(@"property str changed");
    }];
}

- (void)_handle2 {
    
}

#pragma mark - 属性方法

// 在property getter方法中实现view的创建初始化工作
- (UITextField *)userNameTextField {
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.placeholder = @"请输入登录名";
    }
    return _userNameTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(_loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
