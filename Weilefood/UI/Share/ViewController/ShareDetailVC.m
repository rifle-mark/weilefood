//
//  WeiCommentDetailVC.m
//  Sunflower
//
//  Created by makewei on 15/6/2.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "ShareDetailVC.h"
#import "LoginVC.h"

#import "WLShareCell.h"
#import "WLShareSubCommentCell.h"
#import "WLShareSubCommentView.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"
#import "WLDatabaseHelperHeader.h"

#import "UIMenuController+UserInfo.h"
//#import "PictureShowVC.h"

@interface ShareDetailVC ()

@property(nonatomic,strong)UITableView      *commentDetailTableV;
@property(nonatomic,strong)WLShareSubCommentView *commentV;
@property(nonatomic,strong)UIImageView      *deleteActionV;
@property(nonatomic,strong)UIView           *footerView;
@property(nonatomic,strong)UITextView       *textField;
@property(nonatomic,strong)UIButton         *sendButton;
@property(nonatomic,strong)UIView           *lineView;

@property(nonatomic, assign)CGFloat         keyboardHeight;

@property(nonatomic,strong)NSArray          *commentList;
@property(nonatomic,strong)NSNumber         *currentPage;

@end

static NSString *const kHintText = @"在这里说点什么吧...";

@implementation ShareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"分享详情";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStyleDone target:self action:@selector(_policeShare:)];
    rightItem.tintColor = k_COLOR_WHITE;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.commentDetailTableV];
    [self.view addSubview:self.commentV];
    [self.view addSubview:self.deleteActionV];
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.lineView];
    [self.footerView addSubview:self.textField];
    [self.footerView addSubview:self.sendButton];
    
    [self _setupObserver];
    [self _refreshCommentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.commentDetailTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.commentDetailTableV.superview);
        make.top.equalTo(self.commentDetailTableV.superview).with.offset(self.topLayoutGuide.length);
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
    
    [self.commentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.commentV.superview);
        make.height.equalTo(@50);
    }];
    [self.deleteActionV setHidden:YES];
    
    [self _setupTapGestureRecognizer];
    
    FixesViewDidLayoutSubviewsiOS7Error
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Coding View
- (UITableView *)commentDetailTableV {
    if (!_commentDetailTableV) {
        _commentDetailTableV = ({
            UITableView *v = [[UITableView alloc] init];
            [v registerClass:[WLShareCell class] forCellReuseIdentifier:[WLShareCell reuseIdentify]];
            [v registerClass:[WLShareSubCommentCell class] forCellReuseIdentifier:[WLShareSubCommentCell reuseIdentify]];
            v.showsHorizontalScrollIndicator = NO;
            v.showsVerticalScrollIndicator = NO;
            v.separatorStyle = UITableViewCellSeparatorStyleNone;
            v.allowsSelection = NO;
            v.backgroundColor = k_COLOR_WHITESMOKE;
            _weak(self);
            [v withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
                _strong(self);
                return [self.commentList count] + 1;
            }];
            
            [v withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
                _strong(self);
                if (path.row == 0) {
                    return [WLShareCell heightWithComment:self.share screenWidth:V_W_(self.view)];
                }
                
                else {
                    return [WLShareSubCommentCell heightWithComment:self.commentList[path.row-1] screenWidth:V_W_(self.view)];
                }
            }];
            
            [v withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
                _strong(self);
                if (path.row == 0) {
                    WLShareCell *cell = [view dequeueReusableCellWithIdentifier:[WLShareCell reuseIdentify]];
                    if (!cell) {
                        cell = [[WLShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WLShareCell reuseIdentify]];
                    }
                    cell.share = self.share;
                    _weak(cell);
                    cell.likeActionBlock = ^(WLShareModel *share){
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeApproval objectType:WLActionTypeShare objectId:share.shareId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                                _strong_check(cell);
                                cell.isLike = YES;
                                [cell addUpCount];
                            }];
                        }];
                    };
                    cell.commentActionBlock = ^(WLShareModel *share) {
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            _strong_check(self);
                            [self showCommentViewWithComment:share];
                        }];
                        
                    };
                    cell.picShowBlock = ^(NSArray *picUrlArray, NSInteger index) {
                        _strong_check(self);
                        // TODO:
                        // show pic VC
                    };
                    return cell;
                }
                else {
                    WLShareSubCommentCell *cell = [view dequeueReusableCellWithIdentifier:[WLShareSubCommentCell reuseIdentify]];
                    if (!cell) {
                        cell = [[WLShareSubCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WLShareSubCommentCell reuseIdentify]];
                    }
                    
                    cell.comment = self.commentList[path.row - 1];
                    _weak(cell);
                    cell.longTapBlock = ^(WLCommentModel *comment) {
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            _strong_check(cell);
                            _strong_check(self);
                            UIMenuController *menu = (UIMenuController*)[UIMenuController sharedMenuController];
                            UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyComment:)];
                            UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteComment:)];
                            if (comment.userId == [WLDatabaseHelper user_find].userId) {
                                [menu setMenuItems:@[copy, delete]];
                            }
                            else {
                                [menu setMenuItems:@[copy]];
                            }

                            menu.userInfo = @{@"Comment":comment};

                            [menu setTargetRect:[cell convertRect:cell.bounds toView:self.view] inView:self.view];
                            [menu setMenuVisible:YES animated:YES];
                        }];
                        
                    };
                    return cell;
                }
            }];
            [v headerWithRefreshingBlock:^{
                _strong_check(self);
                [self _refreshCommentList];
            }];
            [v footerWithRefreshingBlock:^{
                _strong_check(self);
                [self _loadMoreComment];
            }];
            v;
        });
    }
    
    return _commentDetailTableV;
}

- (WLShareSubCommentView *)commentV {
    if (!_commentV) {
        _commentV = ({
            _weak(self);
            WLShareSubCommentView* view = [[WLShareSubCommentView alloc] init];
            [view withSubmitAction:^(NSString *commentContent, NSNumber *rootCommentID) {
                _strong_check(self);
                [self.commentV resignFirstResponder];
                [self.commentV clearContent];
                [[WLServerHelper sharedInstance] comment_addWithType:WLCommentTypeShare refId:self.share.shareId content:commentContent parentId:0 callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    [self _refreshCommentList];
                    [MBProgressHUD showSuccessWithMessage:@"评论成功"];
                    return;
                }];
            }];
            view;
        });
        _commentV.hidden = YES;
    }
    return _commentV;
}

- (UIImageView *)deleteActionV {
    if (!_deleteActionV) {
        _deleteActionV = [[UIImageView alloc] init];
        _deleteActionV.userInteractionEnabled = YES;
        _deleteActionV.image = [UIImage imageNamed:@"p_weicomment_action_btn"];
        UIButton *deleteBtn = [[UIButton alloc] init];
        deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [deleteBtn setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [deleteBtn setTitleColor:k_COLOR_SLATEGRAY forState:UIControlStateHighlighted];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteActionV addSubview:deleteBtn];
        _weak(self);
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(_deleteActionV);
        }];
        [deleteBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self.deleteActionV setHidden:YES];
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                if (!self.share) {
                    return;
                }
                [[WLServerHelper sharedInstance] share_deleteWithShareId:self.share.shareId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    
                    [MBProgressHUD showSuccessWithMessage:@"删除成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }];
        }];
    }
    return _deleteActionV;
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
        _textField.textColor = k_COLOR_DARKGRAY;
        _textField.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        _textField.layer.borderWidth = k1pxWidth;
        _textField.layer.cornerRadius = 4;
        _textField.text = kHintText;
        [_textField withBlockForShouldBeginEditing:^BOOL(UITextView *view) {
            if (![WLDatabaseHelper user_find])
            {
                [LoginVC needsLoginWithLoggedBlock:nil];
                return NO;
            }
            else {
                return YES;
            }
        }];
        [_textField withBlockForDidBeginEditing:^(UITextView *view) {
            if ([view.text isEqualToString:kHintText]) {
                view.text = @"";
            }
        }];
        [_textField withBlockForDidEndEditing:^(UITextView *view) {
            if (!view.text || view.text.length <= 0) {
                view.text = kHintText;
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
                [MBProgressHUD showErrorWithMessage:@"请填写评论内容"];
                [self.textField becomeFirstResponder];
                return;
            }
            if (!self.textField.text || self.textField.text.length <= 5) {
                [MBProgressHUD showErrorWithMessage:@"评论内容太少，多写一点吧"];
                [self.textField becomeFirstResponder];
                return;
            }
            [self.textField resignFirstResponder];
            
            [MBProgressHUD showLoadingWithMessage:@"正在提交..."];
            [[WLServerHelper sharedInstance] comment_addWithType:WLCommentTypeShare refId:self.share.shareId content:self.textField.text parentId:0 callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                [MBProgressHUD hideLoading];
                _strong_check(self);
                ServerHelperErrorHandle;
                self.textField.text = @"";
                [MBProgressHUD showSuccessWithMessage:@"已发布"];
            }];
        }];
    }
    return _sendButton;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)copyComment:(id)sender {
    NSDictionary *userInfo = [sender userInfo];
    WLCommentModel *comment = (WLCommentModel*)[userInfo objectForKey:@"Comment"];
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    [pastboard setString:comment.content];
}

- (void)deleteComment:(id)sender {
    _weak(self);
    NSDictionary *userInfo = [sender userInfo];
    WLCommentModel *comment = (WLCommentModel*)[userInfo objectForKey:@"Comment"];
    [[WLServerHelper sharedInstance] comment_deleteWithCommentId:comment.commentId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        [self _refreshCommentList];
    }];
}


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
        _strong(self);
        [self.commentDetailTableV reloadData];
    }];
    
    [self startObserveObject:self.textField forKeyPath:@"contentSize" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.view setNeedsLayout];
    }];
}

- (void)showCommentViewWithComment:(WLShareModel*)comment {
//    if (![self.commentV isHidden]) {
//        return;
//    }
//    self.commentV.comment = comment;
//    _weak(self);
//    [self.commentV mas_remakeConstraints:^(MASConstraintMaker *make) {
//        _strong(self);
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(@50);
//        make.bottom.equalTo(self.view);
//    }];
//    self.commentV.hidden = NO;
//    [self.commentV becomeFirstResponder];
}

- (void)_setupTapGestureRecognizer {
    _weak(self);
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] init];
    [tap withBlockForShouldReceiveTouch:^BOOL(UIGestureRecognizer *gesture, UITouch *touch) {
        _strong(self);
        if (!CGRectContainsPoint(self.deleteActionV.frame, [touch locationInView:self.deleteActionV])) {
            [self.deleteActionV setHidden:YES];
        }
        
        if (!CGRectContainsPoint(self.commentV.frame, [touch locationInView:self.view])) {
            [self.commentV resignFirstResponder];
        }
        return NO;
    }];
    [self.view addGestureRecognizer:tap];
}
#pragma mark - Data



- (void)_refreshCommentList {
    if (!self.share) {
        return;
    }
    _weak(self);
    [[WLServerHelper sharedInstance] comment_getListWithType:WLCommentTypeShare refId:self.share.shareId maxDate:[NSDate dateWithTimeIntervalSince1970:0] pageSize:20 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        [self.commentDetailTableV.header endRefreshing];
        [self.commentDetailTableV.footer endRefreshing];
        
        ServerHelperErrorHandle;
        self.commentList = apiResult;
        
        self.commentDetailTableV.footer.hidden = !apiResult || apiResult.count < 20;
    }];
}

- (void)_loadMoreComment {
    if (!self.share) {
        return;
    }
    _weak(self);
    [[WLServerHelper sharedInstance] comment_getListWithType:WLCommentTypeShare refId:self.share.shareId maxDate:[self.commentList.lastObject createDate] pageSize:20 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        [self.commentDetailTableV.header endRefreshing];
        [self.commentDetailTableV.footer endRefreshing];
        
        ServerHelperErrorHandle;
        NSMutableArray *tmpCommentList = [self.commentList mutableCopy];
        [tmpCommentList addObjectsFromArray:apiResult];
        self.commentList = tmpCommentList;
        
        self.commentDetailTableV.footer.hidden = !apiResult || apiResult.count < 20;
    }];
}

- (void)_policeShare:(id)sender {
    _weak(self);
    [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
        _strong_check(self);
        [[WLServerHelper sharedInstance] share_policeWithShareId:self.share.shareId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
            ServerHelperErrorHandle;
            
            [MBProgressHUD showSuccessWithMessage:@"举报成功"];
        }];
    }];
}

@end
