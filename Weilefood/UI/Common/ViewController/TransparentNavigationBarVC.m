//
//  TransparentNavigationBarVC.m
//  Weilefood
//
//  Created by kelei on 15/8/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "TransparentNavigationBarVC.h"

@interface TransparentNavigationBarVC ()

@property (nonatomic, strong) UIView *statusBarView;

@end

@implementation TransparentNavigationBarVC

- (id)init {
    if (self = [super init]) {
        _navigationBarAlpha = -1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar addSubview:self.statusBarView];
    
    if (self.navigationBarAlpha == -1) {
        self.navigationBarAlpha = 0;
    }
    else {
        // 这段解决：
        // iOS8中进入此界面后，从屏幕左边缘往右滑一点，再松开，navigationBar显示了背景色的问题
        self.navigationBarAlpha += 0.01;
        self.navigationBarAlpha -= 0.01;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.statusBarView removeFromSuperview];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = nil;
    
//    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.titleTextAttributes = nil;
    self.navigationController.navigationBar.tintColor = k_COLOR_THEME_NAVIGATIONBAR_TEXT;
}

#pragma mark - private property methods

- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    }
    return _statusBarView;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
    if (_navigationBarAlpha == navigationBarAlpha) {
        return;
    }
    _navigationBarAlpha = navigationBarAlpha;
    self.statusBarView.backgroundColor = [k_COLOR_THEME_NAVIGATIONBAR colorWithAlphaComponent:_navigationBarAlpha];
    
//    self.navigationController.navigationBar.alpha = _navigationBarAlpha;
    self.navigationController.navigationBar.tintColor = [k_COLOR_THEME_NAVIGATIONBAR_TEXT colorWithAlphaComponent:_navigationBarAlpha];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [k_COLOR_WHITE colorWithAlphaComponent:_navigationBarAlpha]};
    self.navigationController.navigationBar.backgroundColor = self.statusBarView.backgroundColor;
}

@end
