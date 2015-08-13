//
//  ActivityListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ActivityListVC.h"
#import "ActivityCell.h"

#import "CitySelectVC.h"
#import "ActivityInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface ActivityListVC ()

@property (nonatomic, strong) UIButton    *cityButton;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) WLActivityCityModel *city;
@property (nonatomic, strong) NSArray             *activityList;

@end

static NSString *const kCellIdentifier = @"MYCELL";
static NSInteger const kPageSize       = 10;

@implementation ActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc] initWithCustomView:self.cityButton];
    UIBarButtonItem *userItem = [UIBarButtonItem createUserBarButtonItem];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], userItem, cityItem];
    
    [self.view addSubview:self.tableView];
    
    [self _addObserve];
    
    self.city = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"city" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        NSString *cityName = self.city ? self.city.city : @"所有城市";
        [self.cityButton setTitle:cityName forState:UIControlStateNormal];
        [self.cityButton setImageToRight];
        CGRect frame = self.cityButton.frame;
        frame.size.height = 24;
        frame.size.width += 10;
        self.cityButton.frame = frame;
        [self.tableView.header beginRefreshing];
    }];
    [self startObserveObject:self forKeyPath:@"activityList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSString *cityName = self.city ? self.city.city : @"";
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLActivityModel *)[self.activityList lastObject]).createDate;
    [[WLServerHelper sharedInstance] activity_getListWithCity:cityName maxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.activityList = isLatest ? apiResult : [self.activityList arrayByAddingObjectsFromArray:apiResult];
        self.tableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

#pragma mark - private property methons

- (UIButton *)cityButton {
    if (!_cityButton) {
        _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityButton.backgroundColor = [k_COLOR_BLACK colorWithAlphaComponent:0.2];
        _cityButton.layer.cornerRadius = 4;
        _cityButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cityButton.adjustsImageWhenHighlighted = NO;
        [_cityButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_cityButton setImage:[UIImage imageNamed:@"market_arrow_down"] forState:UIControlStateNormal];
        _weak(self);
        [_cityButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            CitySelectVC *vc = [[CitySelectVC alloc] init];
            [vc selectedCity:^(CitySelectVC *sender, WLActivityCityModel *activityCity) {
                _strong_check(self);
                self.city = activityCity;
                [sender dismissViewControllerAnimated:YES completion:nil];
            }];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:nc animated:YES completion:nil];
        }];
    }
    return _cityButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = [ActivityCell cellHeight];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ActivityCell class] forCellReuseIdentifier:kCellIdentifier];
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
            return self.activityList ? self.activityList.count : 0;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            ActivityCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            WLActivityModel *activity = self.activityList[path.row];
            cell.imageUrl     = activity.banner;
            cell.name         = activity.title;
            cell.beginDate    = activity.startDate;
            cell.endDate      = activity.endDate;
            cell.participated = activity.isJoin;
            cell.state        = activity.state;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLActivityModel *activity = self.activityList[path.row];
            [self.navigationController pushViewController:[[ActivityInfoVC alloc] initWithActivity:activity] animated:YES];
        }];
    }
    return _tableView;
}

@end
