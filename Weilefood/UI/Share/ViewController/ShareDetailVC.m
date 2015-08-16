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

@property(nonatomic,strong)NSArray          *commentList;
@property(nonatomic,strong)NSNumber         *currentPage;

@end

@implementation ShareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.commentDetailTableV];
    [self.view addSubview:self.commentV];
    [self.view addSubview:self.deleteActionV];
    
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
                            [self _showCommentViewWithComment:share];
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
            v.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _strong(self);
                [self _refreshCommentList];
            }];
            v.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                _strong(self);
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
    [self startObserveObject:self forKeyPath:@"commentList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.commentDetailTableV reloadData];
    }];
    
    [self addObserverForNotificationName:UIKeyboardWillShowNotification usingBlock:^(NSNotification *noti) {
        _strong(self);
        NSNumber *duration = [noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        [UIView animateWithDuration:[duration doubleValue] delay:0.0f options:[curve integerValue]<<16 animations:^(){
            [self.commentV mas_remakeConstraints:^(MASConstraintMaker *make) {
                _strong(self);
                CGRect keyboardBounds = [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
                CGFloat keyboardHeight = keyboardBounds.size.height;
                make.left.right.equalTo(self.view);
                make.height.equalTo(@50);
                make.bottom.equalTo(self.view).with.offset(keyboardHeight<=self.bottomLayoutGuide.length?(-self.bottomLayoutGuide.length):(-keyboardHeight));
            }];
            [self.view layoutIfNeeded];
        } completion:nil];
    }];
    
    [self addObserverForNotificationName:UIKeyboardWillHideNotification usingBlock:^(NSNotification *noti) {
        _strong(self);
        NSNumber *duration = [noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        self.commentV.comment = nil;
        
        [UIView animateWithDuration:[duration doubleValue] delay:0.0f options:[curve integerValue]<<16 animations:^(){
            [self.commentV mas_remakeConstraints:^(MASConstraintMaker *make) {
                _strong(self);
                make.left.right.equalTo(self.view);
                make.height.equalTo(@50);
                make.bottom.equalTo(self.view);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished){
            _strong(self);
            [self.commentV setHidden:YES];
        }];
    }];
}

- (void)_showCommentViewWithComment:(WLShareModel*)comment {
    if (![self.commentV isHidden]) {
        return;
    }
    self.commentV.comment = comment;
    _weak(self);
    [self.commentV mas_remakeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view);
    }];
    self.commentV.hidden = NO;
    [self.commentV becomeFirstResponder];
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
    }];
}

@end
