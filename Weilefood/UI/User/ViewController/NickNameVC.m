//
//  NickNameVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "NickNameVC.h"

#import "UITextView+Placeholder.h"

#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

@interface NickNameVC ()

@property(nonatomic,strong)UIBarButtonItem  *saveBarItem;
@property(nonatomic,strong)UITextView       *textField;

@property(nonatomic,strong)WLUserModel      *user;

@end

@implementation NickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.user = [WLDatabaseHelper user_find];
    
    self.navigationItem.title = @"昵称";
    self.navigationItem.rightBarButtonItem = self.saveBarItem;
    
    self.view.backgroundColor = k_COLOR_WHITE;
    [self.view addSubview:self.textField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    _weak(self);
    [tap withBlockForShouldReceiveTouch:^BOOL(UIGestureRecognizer *gesture, UITouch *touch) {
        _strong_check(self, NO);
        if (!CGRectContainsPoint(self.textField.frame, [touch locationInView:self.view])) {
            [self.textField resignFirstResponder];
        }
        return NO;
    }];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.superview).with.offset(15);
        make.right.equalTo(self.textField.superview).with.offset(-15);
        make.top.equalTo(self.textField.superview).with.offset(self.topLayoutGuide.length+15);
        make.height.equalTo(@40);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private
- (void)_saveNickName:(id)sender {
    
    if ([self.textField.text isEqualToString:@"请输入昵称"]) {
        [MBProgressHUD showErrorWithMessage:@"请输入您的昵称"];
        return;
    }
    if ([self.textField.text isEqualToString:self.user.nickName]) {
        return;
    }
    
    [[WLServerHelper sharedInstance] user_updateWithNickName:self.textField.text avatar:[WLDatabaseHelper user_find].avatar callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
        ServerHelperErrorHandle;
        
        if (apiResult) {
            [WLDatabaseHelper user_save:apiResult];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserInfoUpdate object:nil];
            [MBProgressHUD showSuccessWithMessage:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [MBProgressHUD showErrorWithMessage:@"修改失败，请检查网络"];
        }
    }];
}

#pragma mark - property
- (UIBarButtonItem *)saveBarItem {
    if (!_saveBarItem) {
        _saveBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(_saveNickName:)];
        _saveBarItem.tintColor = k_COLOR_WHITE;
    }
    return _saveBarItem;
}

- (UITextView *)textField {
    if (!_textField) {
        _textField = [[UITextView alloc] init];
        _textField.placeholder = [NSString isNilEmptyOrBlankString:self.user.nickName]?@"请输入昵称":self.user.nickName;
        _textField.placeholderColor = k_COLOR_DIMGRAY;
        _textField.textColor = k_COLOR_DIMGRAY;
        _textField.backgroundColor = k_COLOR_WHITESMOKE;
        _textField.clipsToBounds = YES;
        _textField.layer.cornerRadius = 4;
        _textField.textContainerInset = UIEdgeInsetsMake(12, 10, 12, 10);
        _textField.font = [UIFont boldSystemFontOfSize:16];

        [_textField withBlockForDidChanged:^(UITextView *view) {
            if ([view.text length] > 10) {
                [MBProgressHUD showErrorWithMessage:@"昵称太长了"];
                view.text = [view.text substringWithRange:NSMakeRange(0, 10)];
            }
        }];
    }
    
    return _textField;
}

@end
