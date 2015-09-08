//
//  YeepayVC.m
//  Weilefood
//
//  Created by kelei on 15/9/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "YeepayVC.h"

@interface YeepayVC ()

@property (nonatomic, strong) UIWebView        *webView;

@property (nonatomic, copy  ) NSString         *url;
@property (nonatomic, copy  ) YeepayVCPayBlock payBlock;

@end

@implementation YeepayVC

+ (void)payWithUrl:(NSString *)url payBlock:(YeepayVCPayBlock)payBlock {
    YeepayVC *vc = [[YeepayVC alloc] init];
    vc.url = url;
    vc.payBlock = payBlock;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIViewController *currentVC = [[UIApplication sharedApplication] currentViewController];
    [currentVC presentViewController:nc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"易宝支付";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(_closeAction)];
    
    [self.view addSubview:self.webView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - private methods

- (void)_closeAction {
    [self dismissViewControllerAnimated:YES completion:^{
        GCBlockInvoke(self.payBlock, NO);
    }];
}

#pragma mark - private property methods

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _weak(self);
        [_webView withBlockForShouldStartLoadRequest:^BOOL(UIWebView *view, NSURLRequest *request, UIWebViewNavigationType type) {
            _strong_check(self, YES);
            
            if ([request.URL.path hasSuffix:@"success"]) {
                self.navigationItem.leftBarButtonItem = nil;
            }
            
            if ([request.URL.host isEqualToString:@"ybpayok"]) {
                [self dismissViewControllerAnimated:YES completion:^{
                    GCBlockInvoke(self.payBlock, YES);
                }];
            }
            else if ([request.URL.host isEqualToString:@"false"]) {
                [self _closeAction];
            }
            
            return YES;
        }];
    }
    return _webView;
}

@end
