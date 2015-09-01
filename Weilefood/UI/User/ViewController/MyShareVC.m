//
//  MyShareVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyShareVC.h"

#import "WLShareCell.h"
#import "UserCenterUserInfoCell.h"
#import "WLModelHeader.h"
#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "ShareDetailVC.h"
#import "LoginVC.h"
#import "PictureShowVC.h"

@interface MyShareVC ()

@property(nonatomic,strong)UITableView      *tableView;

@property(nonatomic,strong)NSArray          *shareList;

@end

static NSInteger kPageSize = 20;

@implementation MyShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的发帖";
    // TODO:
    // 右上角添加操作：发帖
    
    [self.view addSubview:self.tableView];
    [self _setupObserver];
    [self.tableView.header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.tableView.superview);
        make.top.equalTo(self.tableView.superview).with.offset(self.topLayoutGuide.length);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private
- (void)_loadMyShareAtDate:(NSDate *)date pageSize:(NSUInteger)pageSize {
    _weak(self);
    [[WLServerHelper sharedInstance] share_getMyListWithMaxDate:date pageSize:pageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.shareList = [date timeIntervalSince1970]==0?apiResult:[self.shareList arrayByAddingObjectsFromArray:apiResult];
        self.tableView.footer.hidden = !apiResult || apiResult.count < pageSize;
    }];
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"shareList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - propertys 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[UserCenterUserInfoCell class] forCellReuseIdentifier:[UserCenterUserInfoCell reuseIdentify]];
        [_tableView registerClass:[WLShareCell class] forCellReuseIdentifier:[WLShareCell reuseIdentify]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        _weak(self);
        [_tableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadMyShareAtDate:[NSDate dateWithTimeIntervalSince1970:0] pageSize:kPageSize];
        }];
        [_tableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadMyShareAtDate:[[self.shareList lastObject] createDate] pageSize:kPageSize];
        }];
        
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.shareList.count +1;
        }];
        
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            if (path.row == 0) {
                return 170;
            }
            
            WLShareModel *share = self.shareList[path.row-1];
            return [WLShareCell heightWithComment:share screenWidth:[UIScreen mainScreen].bounds.size.width];
        }];
        
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            if (path.row == 0) {
                UserCenterUserInfoCell *cell = [view dequeueReusableCellWithIdentifier:[UserCenterUserInfoCell reuseIdentify]];
                if (!cell) {
                    cell = [[UserCenterUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UserCenterUserInfoCell reuseIdentify]];
                }
                cell.user = [WLDatabaseHelper user_find];
                
                return cell;
            }
            
            WLShareCell *cell = [view dequeueReusableCellWithIdentifier:[WLShareCell reuseIdentify]];
            cell.share = self.shareList[path.row-1];
            _weak(cell);
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
        
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            if (path.row >= [self.shareList count]+1) {
                return;
            }
            
            ShareDetailVC *detailVC = [[ShareDetailVC alloc] init];
            detailVC.share = self.shareList[path.row-1];
            [self.navigationController pushViewController:detailVC animated:YES];
        }];
    }
    
    return _tableView;
}

@end
