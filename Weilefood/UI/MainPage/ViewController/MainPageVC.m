//
//  MainPageVC.m
//  Weilefood
//
//  Created by kelei on 15/7/25.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MainPageVC.h"

#import "DiscoveryVC.h"
#import "SharedAllListVC.h"
#import "ShareEditVC.h"
#import "LoginVC.h"

@interface MainPageVC ()

@property (nonatomic, strong) UIBarButtonItem *userItem;
@property (nonatomic, assign) BOOL isSetedSelectedIndex;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *discoveryButton;
@property (nonatomic, strong) UIButton *addShareButton;
@property (nonatomic, strong) UIButton *sharedListButton;

@end

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:22]};
    self.title = @"味了";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    
    NSArray *vcs = @[[[DiscoveryVC alloc] init],
                     [[SharedAllListVC alloc] init],
                     ];
    self.viewControllers = vcs;
    
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.discoveryButton];
    [self.footerView addSubview:self.addShareButton];
    [self.footerView addSubview:self.sharedListButton];
    
    [self _isSelectedDiscoveryTabBar:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@49);
    }];
    [self.discoveryButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discoveryButton.superview);
        make.right.equalTo(self.addShareButton.mas_left);
        make.top.bottom.equalTo(self.discoveryButton.superview);
    }];
    [self.addShareButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.discoveryButton);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(self.addShareButton.imageView.image.size.width));
    }];
    [self.sharedListButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addShareButton.mas_right);
        make.right.equalTo(self.discoveryButton.superview);
        make.top.bottom.equalTo(self.discoveryButton);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], self.userItem];
}

#pragma mark - private methons

- (void)_isSelectedDiscoveryTabBar:(BOOL)isSelectedDiscoveryTabBar {
    if (isSelectedDiscoveryTabBar) {
        self.selectedIndex = 0;
        self.discoveryButton.enabled = NO;
        self.sharedListButton.enabled = YES;
    }
    else {
        self.selectedIndex = 1;
        self.discoveryButton.enabled = YES;
        self.sharedListButton.enabled = NO;
    }
}

#pragma mark - private property methons

- (UIBarButtonItem *)userItem {
    if (!_userItem) {
        _userItem = [UIBarButtonItem createUserBarButtonItem];
    }
    return _userItem;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _footerView;
}

- (UIButton *)discoveryButton {
    if (!_discoveryButton) {
        _discoveryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _discoveryButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_discoveryButton setTitleColor:k_COLOR_MAROOM forState:UIControlStateNormal];
        [_discoveryButton setTitleColor:k_COLOR_ORANGE forState:UIControlStateDisabled];
        [_discoveryButton setTitle:@"发现" forState:UIControlStateNormal];
        [_discoveryButton setImage:[UIImage imageNamed:@"mainpage_baritem_icon_n"] forState:UIControlStateNormal];
        [_discoveryButton setImage:[UIImage imageNamed:@"mainpage_baritem_icon_h"] forState:UIControlStateDisabled];
        _discoveryButton.titleEdgeInsets = UIEdgeInsetsMake(14, -12, -14, 12);
        _discoveryButton.imageEdgeInsets = UIEdgeInsetsMake(-7, 16.5, 7, -16.5);
        _weak(self);
        [_discoveryButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self _isSelectedDiscoveryTabBar:YES];
        }];
    }
    return _discoveryButton;
}

- (UIButton *)addShareButton {
    if (!_addShareButton) {
        _addShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addShareButton setImage:[UIImage imageNamed:@"mainpage_add_icon_n"] forState:UIControlStateNormal];
        [_addShareButton setImage:[UIImage imageNamed:@"mainpage_add_icon_h"] forState:UIControlStateHighlighted];
        _weak(self);
        [_addShareButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                ShareEditVC *shareEditVC = [[ShareEditVC alloc] init];
                [self.navigationController pushViewController:shareEditVC animated:YES];
            }];
            
        }];
    }
    return _addShareButton;
}

- (UIButton *)sharedListButton {
    if (!_sharedListButton) {
        _sharedListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sharedListButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_sharedListButton setTitleColor:k_COLOR_MAROOM forState:UIControlStateNormal];
        [_sharedListButton setTitleColor:k_COLOR_ORANGE forState:UIControlStateDisabled];
        [_sharedListButton setTitle:@"美食圈" forState:UIControlStateNormal];
        [_sharedListButton setImage:[UIImage imageNamed:@"mainpage_baritem_icon_n"] forState:UIControlStateNormal];
        [_sharedListButton setImage:[UIImage imageNamed:@"mainpage_baritem_icon_h"] forState:UIControlStateDisabled];
        _sharedListButton.titleEdgeInsets = UIEdgeInsetsMake(14, -18, -14, 18);
        _sharedListButton.imageEdgeInsets = UIEdgeInsetsMake(-7, 16.5, 7, -16.5);
        _weak(self);
        [_sharedListButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self _isSelectedDiscoveryTabBar:NO];
        }];
    }
    return _sharedListButton;
}

@end
