//
//  LaunchVC.m
//  Weilefood
//
//  Created by makewei on 15/9/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "LaunchVC.h"

@interface LaunchVC ()

@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIWebView   *webView;

@property (nonatomic, copy) LaunchVCFinishBlock finishBlock;

@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.backView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weile" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - public methods

- (void)finishBlock:(LaunchVCFinishBlock)finishBlock {
    self.finishBlock = finishBlock;
}

#pragma mark - private property methods

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.scrollEnabled = NO;
        _weak(self);
        [_webView withBlockForDidFinishLoad:^(UIWebView *view) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _strong_check(self);
                [self.view bringSubviewToFront:self.webView];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _strong_check(self);
                GCBlockInvoke(self.finishBlock);
            });
        }];
    }
    return _webView;
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        if (height == 480) {
            _backView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"启动画面01-4.png"]];
        }
        else if (height == 568) {
            _backView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"启动画面01-5.png"]];
        }
        else if (height == 667) {
            _backView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"启动画面01-6.png"]];
        }
        else if (height == 736) {
            _backView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"启动画面01-6plus.png"]];
        }
    }
    return _backView;
}

@end
