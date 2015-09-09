//
//  MyMessageVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyMessageVC.h"
#import "MessageDialogCell.h"
#import "MyMessageInfoVC.h"

#import "WLModelHeader.h"
#import "WLServerHelperHeader.h"

@interface MyMessageVC ()

@property(nonatomic,strong)UITableView      *tableView;

@property(nonatomic,strong)NSArray          *messageList;

@end

static NSUInteger kPageSize = 20;
@implementation MyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"私信";
    
    [self.view addSubview:self.tableView];
    
    [self _setupObserver];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview).with.offset(self.topLayoutGuide.length);
        make.left.right.bottom.equalTo(self.tableView.superview);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.header beginRefreshing];
}

#pragma mark - private
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"messageList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_loadDialogListIsLatest:(BOOL)islatest {
    NSDate *maxDate = islatest?[NSDate dateWithTimeIntervalSince1970:0]:[[self.messageList lastObject] followDate];
    _weak(self);
    [[WLServerHelper sharedInstance] message_getDialogListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
        if ([maxDate timeIntervalSince1970] == 0) {
            self.messageList = apiResult;
        }
        else {
            self.messageList = [self.messageList arrayByAddingObjectsFromArray:apiResult];
        }

        self.tableView.footer.hidden = [apiResult count] < kPageSize;
    }];
}

#pragma mark - property
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MessageDialogCell class] forCellReuseIdentifier:[MessageDialogCell reuseIdentify]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _weak(self);
        [_tableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDialogListIsLatest:YES];
        }];
        [_tableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDialogListIsLatest:NO];
        }];
        
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return [self.messageList count];
        }];
        
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            return 75;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self,nil);
            MessageDialogCell *cell = [view dequeueReusableCellWithIdentifier:[MessageDialogCell reuseIdentify] forIndexPath:path];
            cell.dialog = self.messageList[path.row];
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLDialogModel *dialog = self.messageList[path.row];
            MyMessageInfoVC *vc = [[MyMessageInfoVC alloc] init];
            vc.userId = dialog.followId;
            vc.nickName = dialog.nickName;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _tableView;
}

@end
