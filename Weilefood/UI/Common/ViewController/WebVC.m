//
//  WebVC.m
//  LawyerCenter
//
//  Created by kelei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) UIBarButtonItem *refreshItem;
@property (nonatomic, strong) UIBarButtonItem *stopItem;
@property (nonatomic, strong) UIWebView       *webView;
@property (nonatomic, copy  ) NSString        *url;
@end

@implementation WebVC

- (id)init {
    NSAssert(NO, @"请使用initWithURL:方法初始化本界面");
    return nil;
}

- (id)initWithTitle:(NSString *)title URL:(NSString *)url {
    if (self = [super init]) {
        self.title = title;
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_WHITE;
    [self.view addSubview:self.webView];
    
    self.navigationItem.leftBarButtonItems = @[self.backItem];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methods

- (void)_backItemAction {
    if (self.webView.canGoBack) {
        if (self.navigationItem.leftBarButtonItems.count == 1) {
            [self.navigationItem setLeftBarButtonItems:@[self.backItem, self.closeItem] animated:YES];
        }
        [self.webView goBack];
    }
    else {
        [self _cloaseItemAction];
    }
}

- (void)_cloaseItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_refreshItemAction {
    [self.webView reload];
}

- (void)_stopItemAction {
    [self.webView stopLoading];
    [self _showRefashOrStopControlButton];
}

- (void)_showRefashOrStopControlButton {
    UIBarButtonItem *item = [self.webView isLoading] ? self.stopItem : self.refreshItem;
    [self.navigationItem setRightBarButtonItem:item animated:YES];
}

#pragma mark - private property methods

- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(_backItemAction)];
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(_cloaseItemAction)];
    }
    return _closeItem;
}

- (UIBarButtonItem *)refreshItem {
    if (!_refreshItem) {
        _refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(_refreshItemAction)];
    }
    return _refreshItem;
}

- (UIBarButtonItem *)stopItem {
    if (!_stopItem) {
        _stopItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(_stopItemAction)];
    }
    return _stopItem;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _weak(self);
        [_webView withBlockForDidStartLoad:^(UIWebView *view) {
            _strong_check(self);
            [self _showRefashOrStopControlButton];
        }];
        [_webView withBlockForDidFinishLoad:^(UIWebView *view) {
            _strong_check(self);
            [self _showRefashOrStopControlButton];
        }];
        [_webView withBlockForDidFailLoad:^(UIWebView *view, NSError *error) {
            _strong_check(self);
            [self _showRefashOrStopControlButton];
        }];
        [_webView withBlockForShouldStartLoadRequest:^BOOL(UIWebView *view, NSURLRequest *request, UIWebViewNavigationType type) {
            view.scalesPageToFit = YES;
            return YES;
        }];
    }
    return _webView;
}

@end
