//
//  FeedBackVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "FeedBackVC.h"

#import "UITextView+Placeholder.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"
#import "UIScrollView+Keyboard.h"

@interface FeedBackVC ()

@property(nonatomic,strong)UIScrollView     *scrollerV;
@property(nonatomic,strong)UIView           *contentV;
@property(nonatomic,strong)UITextView       *feedBackT;
@property(nonatomic,strong)UITextView       *userInfoT;

@property(nonatomic,strong)UIBarButtonItem  *sendBarItem;

@end

static NSString *feedBackPlaceHolder = @"对于\"味了\"有任何建议或疑问，都可以畅所欲言，谢谢。";
static NSString *userInfoPlaceHolder = @"请输入QQ/邮箱/手机号";

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意见反馈";
    self.navigationItem.rightBarButtonItem = self.sendBarItem;
    
    [self.view addSubview:self.scrollerV];
    [self.scrollerV addSubview:self.contentV];
    [self.contentV addSubview:self.feedBackT];
    [self.contentV addSubview:self.userInfoT];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.scrollerV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollerV.superview);
        make.top.equalTo(self.scrollerV.superview).with.offset(self.topLayoutGuide.length);
        make.bottom.equalTo(self.scrollerV.superview).with.offset(-self.bottomLayoutGuide.length);
    }];
    
    [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentV.superview);
    }];
    
    [self.feedBackT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedBackT.superview).with.offset(10);
        make.left.equalTo(self.feedBackT.superview).with.offset(10);
        make.right.equalTo(self.feedBackT.superview).with.offset(-10);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width-20));
        make.height.equalTo(@180);
    }];
    
    [self.userInfoT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedBackT.mas_bottom).with.offset(5);
        make.left.right.equalTo(self.feedBackT);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.userInfoT.superview);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.feedBackT resignFirstResponder];
    [self.userInfoT resignFirstResponder];
}

#pragma mark - private

- (void)_sendFeedBack:(id)sender {
    if ([self.feedBackT.text isEqualToString:feedBackPlaceHolder] || [NSString isNilEmptyOrBlankString:self.feedBackT.text]) {
        [MBProgressHUD showErrorWithMessage:@"请输入您的建议或疑问"];
        return;
    }
    if ([self.userInfoT.text isEqualToString:userInfoPlaceHolder] || [NSString isNilEmptyOrBlankString:self.userInfoT.text]) {
        [MBProgressHUD showErrorWithMessage:@"请输入您的联系信息"];
        return;
    }
    
    _weak(self);
    [[WLServerHelper sharedInstance] feedBack_addWithContent:self.feedBackT.text userInfo:self.userInfoT.text callback:^(WLApiInfoModel *apiInfo, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        [MBProgressHUD showSuccessWithMessage:@"发送反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - property
- (UIScrollView *)scrollerV {
    if (!_scrollerV) {
        _scrollerV = [[UIScrollView alloc] init];
        _scrollerV.showsHorizontalScrollIndicator = NO;
        _scrollerV.showsVerticalScrollIndicator = NO;
        _scrollerV.backgroundColor = k_COLOR_WHITE;
    }
    return _scrollerV;
}

- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.backgroundColor = k_COLOR_WHITE;
    }
    return _contentV;
}

- (UITextView *)feedBackT {
    if (!_feedBackT) {
        _feedBackT = [[UITextView alloc] init];
        _feedBackT.showsHorizontalScrollIndicator = NO;
        _feedBackT.showsVerticalScrollIndicator = NO;
        _feedBackT.font = [UIFont boldSystemFontOfSize:15];
        _feedBackT.textColor = k_COLOR_DIMGRAY;
        _feedBackT.placeholderColor = k_COLOR_STAR_DUST;
        _feedBackT.backgroundColor = k_COLOR_WHITESMOKE;
        _feedBackT.clipsToBounds = YES;
        _feedBackT.layer.cornerRadius = 4;
        _feedBackT.textContainer.lineFragmentPadding = 0;
        _feedBackT.textContainerInset = UIEdgeInsetsMake(12, 5, 12, 5);
        _feedBackT.placeholder = feedBackPlaceHolder;
    }
    
    return _feedBackT;
}

- (UITextView *)userInfoT {
    if (!_userInfoT) {
        _userInfoT = [[UITextView alloc] init];
        _userInfoT.showsVerticalScrollIndicator = NO;
        _userInfoT.showsHorizontalScrollIndicator = NO;
        _userInfoT.backgroundColor = k_COLOR_WHITESMOKE;
        _userInfoT.textColor = k_COLOR_DIMGRAY;
        _userInfoT.textContainer.maximumNumberOfLines = 1;
        _userInfoT.layer.cornerRadius = 4;
        _userInfoT.clipsToBounds = YES;
        _userInfoT.textContainer.lineFragmentPadding = 0;
        _userInfoT.textContainerInset = UIEdgeInsetsMake(12, 5, 12, 5);
        _userInfoT.font = [UIFont boldSystemFontOfSize:16];
        _userInfoT.placeholder = userInfoPlaceHolder;
    }
    return _userInfoT;
}

- (UIBarButtonItem *)sendBarItem {
    if (!_sendBarItem) {
        _sendBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(_sendFeedBack:)];
        _sendBarItem.tintColor = k_COLOR_WHITESMOKE;
    }
    return _sendBarItem;
}
@end
