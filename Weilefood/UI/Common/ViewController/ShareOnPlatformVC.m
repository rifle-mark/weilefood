//
//  ShareOnPlatformVC.m
//  Weilefood
//
//  Created by kelei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ShareOnPlatformVC.h"
#import <UMengSocial/WXApi.h>

@interface ShareOnPlatformVC ()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel  *weiboLabel;
@property (nonatomic, strong) UILabel  *wxLabel;
@property (nonatomic, strong) UILabel  *wxqLabel;
@property (nonatomic, strong) UIButton *weiboButton;
@property (nonatomic, strong) UIButton *wxButton;
@property (nonatomic, strong) UIButton *wxqButton;

@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, copy  ) NSString *desc;
@property (nonatomic, copy  ) NSString *shareUrl;

@property (nonatomic, assign) UIModalPresentationStyle pvcOldModalPresentationStyle;

@end

static NSInteger const kLabelTopMargin = 10;

@implementation ShareOnPlatformVC

+ (void)shareWithImageUrl:(NSString *)imageUrl title:(NSString *)title shareUrl:(NSString *)shareUrl {
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    BOOL isShowLoading = ![[SDWebImageManager sharedManager] cachedImageExistsForURL:url];
    if (isShowLoading) {
        [MBProgressHUD showLoadingWithMessage:nil];
    }
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (isShowLoading) {
            [MBProgressHUD hideLoading];
        }
        if (error) {
            DLog("%@", error);
            return;
        }
        ShareOnPlatformVC *vc = [[ShareOnPlatformVC alloc] init];
        vc.image    = image;
        vc.desc     = title;
        vc.shareUrl = shareUrl;
        UIViewController *pvc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (SYSTEM_VERSION_LESS_THAN(@"8")) {
            vc.pvcOldModalPresentationStyle = pvc.modalPresentationStyle;
            pvc.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        else {
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [pvc presentViewController:vc animated:NO completion:nil];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_CLEAR;
    self.view.layer.backgroundColor = k_COLOR_CLEAR.CGColor;
    
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.weiboLabel];
    [self.view addSubview:self.weiboButton];
    if ([WXApi isWXAppInstalled]) {
        [self.view addSubview:self.wxLabel];
        [self.view addSubview:self.wxqLabel];
        [self.view addSubview:self.wxButton];
        [self.view addSubview:self.wxqButton];
    }
    [self _setButtonAlpha:0];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if ([WXApi isWXAppInstalled]) {
        [self.weiboButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self.view);
        }];
        [self.wxButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.weiboButton.mas_right);
            make.centerY.width.equalTo(self.weiboButton);
        }];
        [self.wxqButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wxButton.mas_right);
            make.centerY.width.equalTo(self.wxButton);
            make.right.equalTo(self.view);
        }];
        [self.weiboLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.weiboButton);
            make.top.equalTo(self.weiboButton.mas_bottom).offset(kLabelTopMargin);
        }];
        [self.wxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.wxButton);
            make.top.equalTo(self.wxButton.mas_bottom).offset(kLabelTopMargin);
        }];
        [self.wxqLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.wxqButton);
            make.top.equalTo(self.wxqButton.mas_bottom).offset(kLabelTopMargin);
        }];
    }
    else {
        [self.weiboButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        [self.weiboLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.weiboButton);
            make.top.equalTo(self.weiboButton.mas_bottom).offset(kLabelTopMargin);
        }];
    }
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.backgroundColor = [k_COLOR_LAVENDER colorWithAlphaComponent:0.95].CGColor;
        [self _setButtonAlpha:1];
    }];
}

#pragma mare - private methods

- (void)_closeSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.backgroundColor = k_COLOR_CLEAR.CGColor;
        [self _setButtonAlpha:0];
    } completion:^(BOOL finished) {
        if (self.presentingViewController && SYSTEM_VERSION_LESS_THAN(@"8")) {
            self.presentingViewController.modalPresentationStyle = self.pvcOldModalPresentationStyle;
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)_shareWithType:(NSString *)type {
    // 微信分享给朋友可以有“标题”和“说明”，这里只需要“说明”及可，所以把标题置空。
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
    
    _weak(self);
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[type]
                                                       content:self.desc
                                                         image:self.image
                                                      location:nil
                                                   urlResource:nil
                                           presentedController:self
                                                    completion:^(UMSocialResponseEntity *response) {
                                                        _strong_check(self);
                                                        if (response.responseCode == UMSResponseCodeSuccess) {
                                                            [MBProgressHUD showSuccessWithMessage:@"分享成功"];
                                                            [self _closeSelf];
                                                        }
                                                        else if (response.responseCode == UMSResponseCodeCancel) {
                                                        }
                                                        else {
                                                            [MBProgressHUD showErrorWithMessage:@"分享失败"];
                                                        }
                                                    }];
}

- (void)_setButtonAlpha:(CGFloat)alpha {
    self.weiboButton.alpha = alpha;
    self.wxButton.alpha    = alpha;
    self.wxqButton.alpha   = alpha;
    self.weiboLabel.alpha  = alpha;
    self.wxLabel.alpha     = alpha;
    self.wxqLabel.alpha    = alpha;
}

- (UIButton *)_createButtonWithImageNamed:(NSString *)imageNamed {
    return ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        [v setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
        v;
    });
}

- (UILabel *)_createLabelWithText:(NSString *)text {
    return ({
        UILabel *v = [[UILabel alloc] init];
        v.font = [UIFont systemFontOfSize:13];
        v.textColor = k_COLOR_SLATEGRAY;
        v.text = text;
        v;
    });
}

#pragma mark - private property methods

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weak(self);
        [_closeButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self _closeSelf];
        }];
    }
    return _closeButton;
}

- (UIButton *)weiboButton {
    if (!_weiboButton) {
        _weiboButton = [self _createButtonWithImageNamed:@"share_icon_weibo"];
        _weak(self);
        [_weiboButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self _shareWithType:UMShareToSina];
        }];
    }
    return _weiboButton;
}

- (UIButton *)wxButton {
    if (!_wxButton) {
        _wxButton = [self _createButtonWithImageNamed:@"share_icon_wx"];
        _weak(self);
        [_wxButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self _shareWithType:UMShareToWechatSession];
        }];
    }
    return _wxButton;
}

- (UIButton *)wxqButton {
    if (!_wxqButton) {
        _wxqButton = [self _createButtonWithImageNamed:@"share_icon_wxq"];
        _weak(self);
        [_wxqButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self _shareWithType:UMShareToWechatTimeline];
        }];
    }
    return _wxqButton;
}

- (UILabel *)weiboLabel {
    if (!_weiboLabel) {
        _weiboLabel = [self _createLabelWithText:@"新浪微博"];
    }
    return _weiboLabel;
}

- (UILabel *)wxLabel {
    if (!_wxLabel) {
        _wxLabel = [self _createLabelWithText:@"微信好友"];
    }
    return _wxLabel;
}

- (UILabel *)wxqLabel {
    if (!_wxqLabel) {
        _wxqLabel = [self _createLabelWithText:@"微信朋友圈"];
    }
    return _wxqLabel;
}

@end
