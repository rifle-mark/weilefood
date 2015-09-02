//
//  MyMessageInfoVC.m
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyMessageInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

#import "LoginVC.h"
#import "MessageOwnInfoCell.h"
#import "MessageUserInfoCell.h"
#import "UITextView+Placeholder.h"

@interface MyMessageInfoVC ()

@property(nonatomic,strong)UITableView      *tableView;
@property(nonatomic,strong)UIView           *footerView;
@property(nonatomic,strong)UITextView       *textField;
@property(nonatomic,strong)UIButton         *sendButton;
@property(nonatomic,strong)UIView           *lineView;

@property(nonatomic, assign)CGFloat         keyboardHeight;

@property(nonatomic,strong)NSArray          *messageList;

@end

static NSString* kHintText = @"在这里说点什么吧...";
static NSUInteger kPageSize = 20;

@implementation MyMessageInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.nickName;

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.lineView];
    [self.footerView addSubview:self.textField];
    [self.footerView addSubview:self.sendButton];
    
    [self _setupObserver];
    [self _loadMessageListWithLatest:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview).with.offset(self.topLayoutGuide.length);
        make.left.right.equalTo(self.tableView.superview);
        make.bottom.equalTo(self.lineView.mas_top);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
        make.height.equalTo(@k1pxWidth);
    }];
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-self.keyboardHeight);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.footerView).offset(8);
        make.right.equalTo(self.sendButton.mas_left).offset(-8);
        make.bottom.equalTo(@-8);
        make.height.equalTo(@(MAX([self.sendButton backgroundImageForState:UIControlStateNormal].size.height, self.textField.contentSize.height)));
    }];
    [self.sendButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.footerView).offset(-8);
        make.bottom.equalTo(self.textField);
        make.size.mas_equalTo([self.sendButton backgroundImageForState:UIControlStateNormal].size);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private
- (void)_setupObserver {
    _weak(self);
    __block BOOL handled = NO;
    [self addObserverForNotificationName:UIKeyboardWillShowNotification usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (self.textField.isFirstResponder) {
            handled = YES;
            
            NSDictionary* info = [notification userInfo];
            CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            self.keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            [UIView animateWithDuration:duration animations:^{
                [self.view setNeedsLayout];
                [self.view layoutIfNeeded];
            }];
            
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messageList count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
    [self addObserverForNotificationName:UIKeyboardWillHideNotification usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (handled) {
            handled = NO;
            NSDictionary* info = [notification userInfo];
            CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            self.keyboardHeight = 0;
            self.textField.text = @"";
            [UIView animateWithDuration:duration animations:^{
                [self.view setNeedsLayout];
                [self.view layoutIfNeeded];
            }];
        }
    }];
    
    [self startObserveObject:self forKeyPath:@"messageList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
    
    [self startObserveObject:self.textField forKeyPath:@"contentSize" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.view setNeedsLayout];
    }];
}

- (void)_loadMessageListWithLatest:(BOOL)islatest {
    _weak(self);
    NSDate *maxDate = islatest?[NSDate dateWithTimeIntervalSince1970:0]:[self.messageList[0] createDate];
    [[WLServerHelper sharedInstance] message_getDialogListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
    }];
    
    [[WLServerHelper sharedInstance] message_getMessageListWithUserId:self.userId maxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        
        if ([maxDate timeIntervalSince1970] == 0) {
            self.messageList = [[apiResult reverseObjectEnumerator] allObjects];
        }
        else {
            NSMutableArray *tmp = [[[apiResult reverseObjectEnumerator] allObjects] mutableCopy];
            [tmp addObjectsFromArray:self.messageList];
            self.messageList = tmp;
        }
        
        if (kPageSize >= [apiResult count]) {
            self.tableView.header.hidden = YES;
        }
    }];
}

#pragma mark - property

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = k_COLOR_WHITESMOKE;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        [_tableView registerClass:[MessageUserInfoCell class] forCellReuseIdentifier:[MessageUserInfoCell reuseIdentify]];
        [_tableView registerClass:[MessageOwnInfoCell class] forCellReuseIdentifier:[MessageOwnInfoCell reuseIdentify]];
        
        _weak(self);
        [_tableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadMessageListWithLatest:NO];
        }];
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self,0);
            return [self.messageList count];
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            WLMessageModel *message = self.messageList[path.row];
            if (message.userId == [WLDatabaseHelper user_find].userId) {
                return [MessageOwnInfoCell cellHeightWithMessage:message];
            }
            else {
                return [MessageUserInfoCell cellHeightWithMessage:message];
            }
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            WLMessageModel *message = self.messageList[path.row];
            if (message.userId == [WLDatabaseHelper user_find].userId) {
                MessageOwnInfoCell *cell = [view dequeueReusableCellWithIdentifier:[MessageOwnInfoCell reuseIdentify] forIndexPath:path];
                cell.message = message;
                return cell;
            }
            else {
                MessageUserInfoCell *cell = [view dequeueReusableCellWithIdentifier:[MessageUserInfoCell reuseIdentify] forIndexPath:path];
                cell.message = message;
                return cell;
            }
        }];
    }
    
    return _tableView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_DARKGRAY;
    }
    return _lineView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _footerView;
}

- (UITextView *)textField {
    if (!_textField) {
        _textField = [[UITextView alloc] init];
        _textField.backgroundColor = k_COLOR_WHITE;
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.textColor = k_COLOR_DIMGRAY;
        _textField.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        _textField.layer.borderWidth = k1pxWidth;
        _textField.layer.cornerRadius = 4;
        _textField.placeholder = kHintText;
        _textField.placeholderColor = k_COLOR_DARKGRAY;
        _weak(self);
        [_textField withBlockForShouldChangeText:^BOOL(UITextView *view, NSRange range, NSString *text) {
            _strong_check(self, NO);
            return YES;
        }];
        [_textField withBlockForDidEndEditing:^(UITextView *view) {
            if (!view.text || view.text.length <= 0) {
                view.text = @"";
            }
        }];
    }
    return _textField;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_send_n"] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_send_h"] forState:UIControlStateHighlighted];
        _weak(self);
        [_sendButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            
            if (![WLDatabaseHelper user_find]) {
                [LoginVC needsLoginWithLoggedBlock:nil];
                return;
            }
            if ([self.textField.text isEqualToString:kHintText]) {
                [MBProgressHUD showErrorWithMessage:@"请填写内容"];
                return;
            }
            if (!self.textField.text) {
                
                [MBProgressHUD showErrorWithMessage:@"请填写内容"];
                return;
            }
            NSString *content = self.textField.text;
            [self.textField resignFirstResponder];
            
            [[WLServerHelper sharedInstance] message_addWithToUserId:self.userId content:content callback:^(WLApiInfoModel *apiInfo, WLMessageModel *apiResult, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                
                self.messageList = [self.messageList arrayByAddingObject:apiResult];
            }];
        }];
    }
    return _sendButton;
}

@end
