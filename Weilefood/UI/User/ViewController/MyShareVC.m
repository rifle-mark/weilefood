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

#import "ShareEditVC.h"
#import "MyMessageInfoVC.h"

@interface MyShareVC ()

@property(nonatomic,strong)UITableView      *tableView;
@property(nonatomic,strong)UIBarButtonItem  *rightBarItem;

@property(nonatomic,strong)NSArray          *shareList;
@property(nonatomic,copy)NSString           *nickName;

@end

static NSInteger kPageSize = 20;

@implementation MyShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WLUserModel *currentUser = [WLDatabaseHelper user_find];
    self.navigationItem.title = self.userId == currentUser.userId?@"我的发帖":@"用户发帖";
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
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
- (void)_loadShareAtDate:(NSDate *)date pageSize:(NSUInteger)pageSize {
    _weak(self);
    WLUserModel *currentUser = [WLDatabaseHelper user_find];
    void (^loadCallback)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) = ^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
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
    };
    if (self.userId == currentUser.userId) {
        [[WLServerHelper sharedInstance] share_getMyListWithMaxDate:date pageSize:pageSize callback:loadCallback];
    }
    else {
        [[WLServerHelper sharedInstance] share_getListWithUserId:self.userId MaxDate:date pageSize:pageSize callback:loadCallback];
    }
    
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"shareList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_addShare:(id)sender {
    
}

- (void)_sendMessage:(id)sender {
    
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
            [self _loadShareAtDate:[NSDate dateWithTimeIntervalSince1970:0] pageSize:kPageSize];
        }];
        [_tableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadShareAtDate:[[self.shareList lastObject] createDate] pageSize:kPageSize];
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
                WLUserModel *currentUser = [WLDatabaseHelper user_find];
                if (self.userId == currentUser.userId) {
                    cell.user = [WLDatabaseHelper user_find];
                }
                else {
                    _weak(cell);
                    [[WLServerHelper sharedInstance] user_getUserBaseInfoWithUserId:self.userId callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
                        _strong_check(cell);
                        ServerHelperErrorHandle;
                        
                        cell.user = apiResult;
                        self.nickName = apiResult.nickName;
                    }];
                }
                [cell hidUserPoint];
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

- (UIBarButtonItem *)rightBarItem {
    if (!_rightBarItem) {
        NSString *imageName = self.userId == [WLDatabaseHelper user_find].userId?@"nav_addShare":@"nav_sendMessage";
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 70, 30);
        
        _weak(self);
        [btn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            if (self.userId == [WLDatabaseHelper user_find].userId) {
                ShareEditVC *vc = [[ShareEditVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                MyMessageInfoVC *vc = [[MyMessageInfoVC alloc] init];
                vc.userId = self.userId;
                vc.nickName = self.nickName;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    }
    return _rightBarItem;
}

@end
