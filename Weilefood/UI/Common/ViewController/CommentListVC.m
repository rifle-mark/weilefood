//
//  CommentListVC.m
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "CommentListVC.h"
#import "CommentCell.h"

#import "UITextView+Placeholder.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface CommentListVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIView      *footerView;
@property (nonatomic, strong) UITextView  *textView;
@property (nonatomic, strong) UIButton    *sendButton;

@property (nonatomic, assign) CGFloat                   keyboardHeight;
@property (nonatomic, assign) WLCommentType             type;
@property (nonatomic, assign) long long                 refId;
@property (nonatomic, assign) BOOL                      nowEnter;
@property (nonatomic, copy  ) CommentListVCDismissBlock dismissBlock;
@property (nonatomic, assign) NSInteger                 addCount;
@property (nonatomic, strong) NSArray                   *commentList;

@property (nonatomic, strong) WLCommentModel *replyComment;

@end

static NSString *const kHintText = @"在这里说点什么吧...";
static NSInteger const kPageSize = 10;

@implementation CommentListVC

+ (void)showWithType:(WLCommentType)type refId:(long long)refId dismissBlock:(CommentListVCDismissBlock)dismissBlock {
    [self showWithType:type refId:refId nowEnter:NO dismissBlock:dismissBlock];
}

+ (void)showWithType:(WLCommentType)type refId:(long long)refId nowEnter:(BOOL)nowEnter dismissBlock:(CommentListVCDismissBlock)dismissBlock {
    CommentListVC *vc = [[CommentListVC alloc] initWithType:type refId:refId nowEnter:nowEnter dismissBlock:dismissBlock];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:YES completion:nil];
}

- (id)init {
    NSAssert(NO, @"请使用initWithType:refId:dismissBlock:方法来实例化本界面");
    return nil;
}

- (id)initWithType:(WLCommentType)type refId:(long long)refId nowEnter:(BOOL)nowEnter dismissBlock:(CommentListVCDismissBlock)dismissBlock {
    if (self = [super init]) {
        self.addCount = 0;
        self.type = type;
        self.refId = refId;
        self.nowEnter = nowEnter;
        self.dismissBlock = dismissBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    self.view.backgroundColor = k_COLOR_WHITE;
    self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [UIBarButtonItem createCloseBarButtonItem]];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.textView];
    [self.footerView addSubview:self.sendButton];
    
    [self _addObserve];
    
    [self.tableView.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top);
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
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.footerView).offset(8);
        make.right.equalTo(self.sendButton.mas_left).offset(-8);
        make.bottom.equalTo(@-8);
        make.height.equalTo(@(MAX([self.sendButton backgroundImageForState:UIControlStateNormal].size.height, self.textView.contentSize.height)));
    }];
    [self.sendButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.footerView).offset(-8);
        make.bottom.equalTo(self.textView);
        make.size.mas_equalTo([self.sendButton backgroundImageForState:UIControlStateNormal].size);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.nowEnter) {
        [self.textView becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    GCBlockInvoke(self.dismissBlock, self.addCount);
}

#pragma mark - private methods

- (void)_addObserve {
    _weak(self);
    __block BOOL handled = NO;
    [self addObserverForNotificationName:UIKeyboardWillShowNotification usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (self.textView.isFirstResponder) {
            handled = YES;
            
            NSDictionary* info = [notification userInfo];
            CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            self.keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            [UIView animateWithDuration:duration animations:^{
                [self.view setNeedsLayout];
                [self.view layoutIfNeeded];
            }];
        }
    }];
    [self addObserverForNotificationName:UIKeyboardWillHideNotification usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (handled) {
            handled = NO;
            NSDictionary* info = [notification userInfo];
            CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
            self.keyboardHeight = 0;
            [UIView animateWithDuration:duration animations:^{
                [self.view setNeedsLayout];
                [self.view layoutIfNeeded];
            }];
        }
    }];
    [self startObserveObject:self forKeyPath:@"commentList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
    [self startObserveObject:self.textView forKeyPath:@"contentSize" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.view setNeedsLayout];
    }];
    [self startObserveObject:self forKeyPath:@"replyComment" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        if (self.replyComment) {
            self.textView.placeholder = [NSString stringWithFormat:@"回复%@：", self.replyComment.nickName];
        }
        else {
            self.textView.placeholder = kHintText;
        }
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLCommentModel *)[self.commentList lastObject]).createDate;
    [[WLServerHelper sharedInstance] comment_getListWithType:self.type refId:self.refId maxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.commentList = isLatest ? apiResult : [self.commentList arrayByAddingObjectsFromArray:apiResult];
        self.tableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

#pragma mark - private property methods

- (UITableView *)tableView {
    if (!_tableView) {
        static NSString *const kCellIdentifier = @"MYCELL";
        
        _tableView =  [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorColor = k_COLOR_LAVENDER;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:kCellIdentifier];
        _weak(self);
        [_tableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:YES];
        }];
        [_tableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:NO];
        }];
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.commentList ? self.commentList.count : 0;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            WLCommentModel *comment = self.commentList[path.row];
            CGFloat height = [CommentCell cellHeightWithToName:comment.toNickName content:comment.content];
            return height;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            CommentCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            WLCommentModel *comment = self.commentList[path.row];
            cell.avatarUrl = comment.avatar;
            cell.name      = comment.nickName;
            cell.toName    = comment.toNickName;
            cell.content   = comment.content;
            cell.time      = comment.createDate;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            self.replyComment = self.commentList[path.row];
            [self.textView becomeFirstResponder];
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

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = k_COLOR_WHITE;
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        _textView.layer.borderWidth = k1pxWidth;
        _textView.layer.cornerRadius = 4;
        _textView.placeholder = kHintText;
        _weak(self);
        [_textView withBlockForDidEndEditing:^(UITextView *view) {
            _strong_check(self);
            view.text = @"";
            self.replyComment = nil;
        }];
    }
    return _textView;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_send_n"] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_send_h"] forState:UIControlStateHighlighted];
        _weak(self);
        [_sendButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            if (!self.textView.text || self.textView.text.length <= 0 || [self.textView.text isEqualToString:kHintText]) {
                [MBProgressHUD showErrorWithMessage:@"请填写评论内容"];
                [self.textView becomeFirstResponder];
                return;
            }
            [MBProgressHUD showLoadingWithMessage:@"正在提交..."];
            [[WLServerHelper sharedInstance] comment_addWithType:self.type refId:self.refId content:self.textView.text parentId:(self.replyComment ? self.replyComment.commentId : 0) callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                [MBProgressHUD hideLoading];
                _strong_check(self);
                ServerHelperErrorHandle;
                self.addCount++;
                [self.textView resignFirstResponder];
                [self.tableView.header beginRefreshing];
                [MBProgressHUD showSuccessWithMessage:@"已发布"];
            }];
        }];
    }
    return _sendButton;
}

@end
