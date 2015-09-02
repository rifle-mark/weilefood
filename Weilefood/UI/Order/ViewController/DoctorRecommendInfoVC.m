//
//  DoctorRecommendInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorRecommendInfoVC.h"
#import "WLServerHelperHeader.h"

@interface DoctorRecommendInfoVC ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) long long orderId;
@end

@implementation DoctorRecommendInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithOrderId:方法初始化本界面");
    return nil;
}

- (id)initWithOrderId:(long long)orderId {
    if (self = [super init]) {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"餐食建议搭配表";
    self.view.backgroundColor = k_COLOR_WHITE;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:[[WLServerHelper sharedInstance] getDoctorRecommendInfoUrlWithOrderId:self.orderId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private property methods

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

@end
