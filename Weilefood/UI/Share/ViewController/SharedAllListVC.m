//
//  SharedAllListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SharedAllListVC.h"
#import "ShareDetailVC.h"
#import "MyShareVC.h"

#import "WLShareCell.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"
#import "LoginVC.h"
#import "PictureShowVC.h"

@interface SharedAllListVC ()

@property(nonatomic,strong)UITableView  *shareListTableV;

@property(nonatomic,strong)NSArray      *shareList;


@end

static NSUInteger kPageSize = 20;

@implementation SharedAllListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"美食圈"
                                                    image:[UIImage imageNamed:@"shared_baritem_icon_n"]
                                            selectedImage:[UIImage imageNamed:@"shared_baritem_icon_h"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.shareList = @[];
    
    [self.view addSubview:self.shareListTableV];
    
    [self _setupObserver];
    [self refreshList];
    
}

- (void)refreshList {
    [self.shareListTableV.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.shareListTableV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(self.topLayoutGuide.length);
        make.bottom.equalTo(self.view).with.offset(self.bottomLayoutGuide.length);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
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
            v.delaysContentTouches = NO;
            
            _weak(self);
            [v headerWithRefreshingBlock:^{
                _strong_check(self);
                [self _refreshCommentList];
            }];
            [v footerWithRefreshingBlock:^{
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
                _weak(cell);
                cell.userClickBlock = ^(WLShareModel *share) {
                    _strong_check(self);
                    MyShareVC *vc = [[MyShareVC alloc] init];
                    vc.userId = share.userId;
                    [self.navigationController pushViewController:vc animated:YES];
                };
                cell.likeActionBlock = ^(WLShareModel *share){
                    [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                        [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeApproval objectType:WLActionTypeShare objectId:share.shareId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                            _strong_check(cell);
                            ServerHelperErrorHandle;
                            cell.isLike = YES;
                            [cell addUpCount];
                        }];
                    }];
                };
                cell.commentActionBlock = ^(WLShareModel *share) {
                    _strong_check(self);
                    ShareDetailVC *detailVC = [[ShareDetailVC alloc] init];
                    detailVC.share = self.shareList[path.row];
                    [self.navigationController pushViewController:detailVC animated:YES];
                    [detailVC showCommentViewWithShare:share];
                };
                cell.picShowBlock = ^(NSArray *picUrlArray, NSInteger index) {
                    _strong_check(self);
                    PictureShowVC *picVC = [[PictureShowVC alloc] init];
                    picVC.picUrlArray = picUrlArray;
                    picVC.currentIndex = index;
                    [self.navigationController pushViewController:picVC animated:YES];
                };
                return cell;
            }];
            
            [v withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
                _strong_check(self);
                if (path.row >= [self.shareList count]) {
                    return;
                }
                
                ShareDetailVC *detailVC = [[ShareDetailVC alloc] init];
                detailVC.share = self.shareList[path.row];
                detailVC.shareDeleteSuccessBlock = ^(){
                    _strong_check(self);
                    [self.shareListTableV.header beginRefreshing];
                };
                [self.navigationController pushViewController:detailVC animated:YES];
            }];
            v;
        });
    }
    
    return _shareListTableV;
}

#pragma mark - Data
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"shareList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.shareListTableV reloadData];
    }];
}

- (void)_loadShareAtDate:(NSDate *)date pageSize:(NSUInteger)pageSize {
    _weak(self);
    [[WLServerHelper sharedInstance] share_getListWithMaxDate:date pageSize:pageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if ([self.shareListTableV.header isRefreshing]) {
            [self.shareListTableV.header endRefreshing];
        }
        if ([self.shareListTableV.footer isRefreshing]) {
            [self.shareListTableV.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.shareList = [date timeIntervalSince1970]==0?apiResult:[self.shareList arrayByAddingObjectsFromArray:apiResult];
        self.shareListTableV.footer.hidden = !apiResult || apiResult.count < pageSize;
    }];
}

- (void)_refreshCommentList {
    [self _loadShareAtDate:[NSDate dateWithTimeIntervalSince1970:0] pageSize:kPageSize];
}

- (void)_loadMoreComment {
    [self _loadShareAtDate:[[self.shareList lastObject] createDate] pageSize:kPageSize];
}

@end
