//
//  SharedAllListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SharedAllListVC.h"

#import "WLShareCell.h"

@interface SharedAllListVC ()

@property(nonatomic,strong)UITableView  *shareListTableV;

@property(nonatomic,strong)NSArray      *shareList;
@property(nonatomic,strong)NSNumber     *currentPage;


@end

@implementation SharedAllListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"美食圈"
                                                    image:[UIImage imageNamed:@"shared_baritem_icon_n"]
                                            selectedImage:[UIImage imageNamed:@"shared_baritem_icon_h"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.shareListTableV];
    
    [self _setupObserver];
    
    self.currentPage = @0;
    [self.shareListTableV.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.shareListTableV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(self.topLayoutGuide.length);
        make.bottom.equalTo(self.view).with.offset(self.bottomLayoutGuide.length);
    }];
}

- (UITableView *)shareListTableV {
    if (!_shareListTableV) {
        _shareListTableV = ({
            UITableView *v = [[UITableView alloc] init];
            v.backgroundColor = k_COLOR_DARKGRAY;
            [v registerClass:[WLShareCell class] forCellReuseIdentifier:[WLShareCell reuseIdentify]];
            v.separatorStyle = UITableViewCellSeparatorStyleNone;
            v.showsVerticalScrollIndicator = NO;
            v.showsHorizontalScrollIndicator = NO;
            
            _weak(self);
            v.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                _strong_check(self);
                [self _refreshCommentList];
            }];
            v.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                _strong_check(self);
                [self _loadMoreComment];
            }];
            
            [v withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
                _strong_check(self, 0);
                return [self.shareList count];
            }];
            
            [v withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
                _strong_check(self, 0);
                return [WLShareCell heightWithComment:self.shareList[path.row] screenWidth:V_W_(self.view)];
            }];
            
            [v withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
                _strong_check(self, nil);
                WLShareCell *cell = [view dequeueReusableCellWithIdentifier:[WLShareCell reuseIdentify]];
                if (!cell) {
                    cell = [[WLShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[WLShareCell reuseIdentify]];
                }
                cell.share = self.shareList[path.row];
//                cell.isUped = [[CommunityLifeModel sharedModel] isWeiCommentUpWithCommentId:(cell.comment.commentId)];
                cell.isUped = YES;
                _weak(cell);
                cell.likeActionBlock = ^(WLShareModel *share){
//                    if (![[UserModel sharedModel] isNormalLogined]) {
//                        [SVProgressHUD showErrorWithStatus:@"请先登录"];
//                        return;
//                    }
//                    [[CommunityLifeModel sharedModel] asyncWeiUpWithCommentId:comment.commentId remoteBlock:^(BOOL isSuccess, NSString *msg, NSError *error) {
//                        _strong(cell);
//                        if (isSuccess) {
//                            [UserPointHandler addUserPointWithType:ActionUp showInfo:NO];
//                            cell.isUped = YES;
//                            [cell addUpCount];
//                            return;
//                        }
//                        [SVProgressHUD showErrorWithStatus:@"操作失败"];
//                    }];
                };
                cell.commentActionBlock = ^(WLShareModel *share) {
                    // TODO: open share detail VC
                };
                cell.picShowBlock = ^(NSArray *picUrlArray, NSInteger index) {
                    _strong(self);
//                    [self performSegueWithIdentifier:@"Segue_WeiCommentList_PictureShow" sender:@{@"dataArray":picUrlArray, @"Index":@(index)}];
                    // TODO: open picture show VC
                };
                return cell;
            }];
            
            [v withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
                _strong_check(self);
                if (path.row >= [self.shareList count]) {
                    return;
                }
                
                // TODO: open share detail VC
//                [self performSegueWithIdentifier:@"Segue_WeiComment_Detail" sender:[view cellForRowAtIndexPath:path]];
            }];
            v;
        });
    }
    
    return _shareListTableV;
}
//
//- (void)_setupTapGestureRecognizer {
//    _weak(self);
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] init];
//    [tap withBlockForShouldReceiveTouch:^BOOL(UIGestureRecognizer *gesture, UITouch *touch) {
//        _strong(self);
//        if (!CGRectContainsPoint(self.actionV.frame, [touch locationInView:self.contentV])) {
//            [self.actionV setHidden:YES];
//        }
//        if (!CGRectContainsPoint(self.deleteActionV.frame, [touch locationInView:self.deleteActionV])) {
//            [self.deleteActionV setHidden:YES];
//        }
//        return NO;
//    }];
//    [self.contentV addGestureRecognizer:tap];
//}

#pragma mark - Data
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"shareList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.shareListTableV reloadData];
        
//        if ([UserModel sharedModel].isNormalLogined) {
//            UserInfo *cUser = [UserModel sharedModel].currentNormalUser;
//            for (WeiCommentInfo *info in self.commentList) {
//                WeiCommentAction *action = [[[MKWModelHandler defaultHandler] queryObjectsForEntity:k_ENTITY_WEICOMMENTACTION predicate:[NSPredicate predicateWithFormat:@"commentId=%@ AND userId=%@", info.commentId, cUser.userId]] firstObject];
//                if (!action) {
//                    action = [[MKWModelHandler defaultHandler] insertNewObjectForEntityForName:k_ENTITY_WEICOMMENTACTION];
//                    action.commentId = info.commentId;
//                    action.userId = cUser.userId;
//                }
//                action.isRead = @(YES);
//            }
//        }
    }];
}

- (void)_loadShareAtPage:(NSNumber *)page pageSize:(NSNumber *)pageSize {
    _weak(self);
//    if (self.isMine) {
//        [[CommunityLifeModel sharedModel] asyncMyWeiListWithCommunityId:[[CommonModel sharedModel] currentCommunityId] parentId:@0 page:page pageSize:pageSize cacheBlock:nil remoteBlock:^(NSArray *commentList, NSNumber *cPage, NSError *error) {
//            _strong(self);
//            if (self.commentTableV.header.isRefreshing) {
//                [self.commentTableV.header endRefreshing];
//            }
//            if (self.commentTableV.footer.isRefreshing) {
//                [self.commentTableV.footer endRefreshing];
//            }
//            if (!error) {
//                if ([cPage integerValue] == 1) {
//                    self.currentPage = cPage;
//                    self.commentList = commentList;
//                }
//                else if ([commentList count]>0) {
//                    self.currentPage = cPage;
//                    NSMutableArray *tmp = [self.commentList mutableCopy];
//                    [tmp addObjectsFromArray:commentList];
//                    self.commentList = tmp;
//                }
//            }
//        }];
//    }
//    else {
    
    // TODO: get share list
//        [[CommunityLifeModel sharedModel] asyncWeiListWithCommunityId:[[CommonModel sharedModel] currentCommunityId] parentId:@0 page:page pageSize:pageSize cacheBlock:nil remoteBlock:^(NSArray *commentList, NSNumber *cPage, NSError *error) {
//            _strong(self);
//            if (self.commentTableV.header.isRefreshing) {
//                [self.commentTableV.header endRefreshing];
//            }
//            if (self.commentTableV.footer.isRefreshing) {
//                [self.commentTableV.footer endRefreshing];
//            }
//            if (!error) {
//                if ([cPage integerValue] == 1) {
//                    self.currentPage = cPage;
//                    self.commentList = commentList;
//                }
//                else if ([commentList count]>0) {
//                    self.currentPage = cPage;
//                    NSMutableArray *tmp = [self.commentList mutableCopy];
//                    [tmp addObjectsFromArray:commentList];
//                    self.commentList = tmp;
//                }
//                
//                if ([commentList count] > 0 && [UserModel sharedModel].isNormalLogined) {
//                    for (WeiCommentInfo *info in commentList) {
//                        WeiCommentAction *action = [[[MKWModelHandler defaultHandler] queryObjectsForEntity:k_ENTITY_WEICOMMENTACTION predicate:[NSPredicate predicateWithFormat:@"commentId=%@", info.commentId]] firstObject];
//                        if (!action) {
//                            action = [[MKWModelHandler defaultHandler] insertNewObjectForEntityForName:k_ENTITY_WEICOMMENTACTION];
//                            action.commentId = info.commentId;
//                            action.userId = [UserModel sharedModel].currentNormalUser.userId;
//                        }
//                        action.isRead = @(YES);
//                    }
//                }
//            }
//        }];
//    }
}

- (void)_refreshCommentList {
    [self _loadShareAtPage:@1 pageSize:@20];
}

- (void)_loadMoreComment {
    [self _loadShareAtPage:@([self.currentPage integerValue] + 1) pageSize:@20];
}

@end
