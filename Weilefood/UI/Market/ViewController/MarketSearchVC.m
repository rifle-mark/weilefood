//
//  MarketSearchVC.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MarketSearchVC.h"
#import "MarketProductCell.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface MarketSearchVC ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *productList;

@end

static NSInteger const kPageSize = 10;
static NSString *const kCellIdentifier = @"MYCELL";

@implementation MarketSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchTextField;
    self.view.backgroundColor = k_COLOR_WHITE;
    
    [self.view addSubview:self.tableView];
    
    [self _addObserve];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
    [super viewWillDisappear:animated];
}

#pragma mark - private methods

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"productList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        self.tableView.footer.hidden = (self.productList.count < kPageSize) || (self.productList.count % kPageSize != 0);
        [self.tableView reloadData];
    }];
}

- (void)_search {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    _weak(self);
    [MBProgressHUD showLoadingWithMessage:@"正在搜索..."];
    [[WLServerHelper sharedInstance] product_searchWithKeyword:self.searchTextField.text maxDate:date pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        [MBProgressHUD hideLoading];
        _strong_check(self);
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        self.productList = apiResult;
    }];
}

- (void)_loadMore {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    if (self.productList && (self.productList.count > 0)) {
        WLProductModel *product = [self.productList lastObject];
        date = product.createDate;
    }
    _weak(self);
    [[WLServerHelper sharedInstance] product_searchWithKeyword:self.searchTextField.text maxDate:date pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        self.productList = [self.productList arrayByAddingObjectsFromArray:apiResult];
    }];
}

#pragma mark - private property methods

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
        _searchTextField.frame = CGRectMake(0, 0, V_W_([UIApplication sharedApplication].keyWindow) - 50, 35);
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.tintColor = k_COLOR_THEME_NAVIGATIONBAR;
        _searchTextField.placeholder = @"请输入关键字进行搜索";
        _weak(self);
        [_searchTextField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong(self);
            if (!self) {
                return NO;
            }
            if (!view.text && view.text.length <= 0) {
                return NO;
            }
            [self _search];
            [view resignFirstResponder];
            return NO;
        }];
    }
    return _searchTextField;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 340;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MarketProductCell class] forCellReuseIdentifier:kCellIdentifier];
        _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMore)];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong(self);
            if (!self) {
                return 0;
            }
            return self.productList ? self.productList.count : 0;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong(self);
            if (!self) {
                return nil;
            }
            MarketProductCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            WLProductModel *product = self.productList[path.row];
            cell.imageUrl = product.images;
            cell.tagType = product.channelId;
            cell.name = product.productName;
            cell.number = product.count;
            cell.price = product.price;
            cell.actionCount = product.actionCount;
            cell.commentCount = product.commentCount;
            return cell;
        }];
    }
    return _tableView;
}

@end
