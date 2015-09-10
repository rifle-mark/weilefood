//
//  HousekeeperIndexVC.m
//  Weilefood
//
//  Created by kelei on 15/8/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "HousekeeperIndexVC.h"
#import "NutritionCell.h"
#import "DoctorCell.h"

#import "NutritionInfoVC.h"
#import "DoctorInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface HousekeeperIndexVC ()

@property (nonatomic, strong) UIView   *channelsView;
@property (nonatomic, strong) UIButton *channelButton1;
@property (nonatomic, strong) UIButton *channelButton2;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL    selectedDoctor;
@property (nonatomic, strong) NSArray *dataList;

@end

static NSInteger const kPageSize       = 10;

@implementation HousekeeperIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"营养管家";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [UIBarButtonItem createUserBarButtonItemWithVC:self]];
    
    [self.channelsView addSubview:self.channelButton1];
    [self.channelsView addSubview:self.channelButton2];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.channelsView];
    
    [self _addObserve];
    
    self.selectedDoctor = NO;
    [self.tableView.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.channelsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0));
        make.height.equalTo(@37);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelsView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.channelButton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelsView).offset(1);
        make.left.bottom.equalTo(self.channelsView);
        make.width.equalTo(self.channelButton2);
    }];
    [self.channelButton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.channelButton1);
        make.left.equalTo(self.channelButton1.mas_right);
        make.right.equalTo(self.channelsView);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"dataList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    void (^callback)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) = ^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.dataList = isLatest ? apiResult : [self.dataList arrayByAddingObjectsFromArray:apiResult];
        self.tableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    };
    
    if (self.selectedDoctor) {
        NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLDoctorModel *)[self.dataList lastObject]).createDate;
        [[WLServerHelper sharedInstance] doctor_getListWithMaxDate:maxDate pageSize:kPageSize callback:callback];
    }
    else {
        NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLNutritionModel *)[self.dataList lastObject]).createDate;
        [[WLServerHelper sharedInstance] nutrition_getListWithMaxDate:maxDate pageSize:kPageSize callback:callback];
    }
}

- (void)_setTextColorWithChannelButton:(UIButton *)button isSelected:(BOOL)isSelected {
    [button setTitleColor:isSelected ? k_COLOR_THEME_NAVIGATIONBAR_TEXT : k_COLOR_TEAL forState:UIControlStateNormal];
}

- (UIButton *)_createChannelButton {
    return ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
        v.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        v;
    });
}

#pragma mark - private property methons

- (void)setSelectedDoctor:(BOOL)selectedDoctor {
    _selectedDoctor = selectedDoctor;
    [self _setTextColorWithChannelButton:self.channelButton1 isSelected:!selectedDoctor];
    [self _setTextColorWithChannelButton:self.channelButton2 isSelected:selectedDoctor];
}

- (UIView *)channelsView {
    if (!_channelsView) {
        _channelsView = [[UIView alloc] init];
        _channelsView.backgroundColor = k_COLOR_MEDIUMTURQUOISE;
    }
    return _channelsView;
}

- (UIButton *)channelButton1 {
    if (!_channelButton1) {
        _channelButton1 = [self _createChannelButton];
        [_channelButton1 setTitle:@"营养推荐" forState:UIControlStateNormal];
        _weak(self);
        [_channelButton1 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectedDoctor = NO;
            [self.tableView.header beginRefreshing];
        }];
    }
    return _channelButton1;
}

- (UIButton *)channelButton2 {
    if (!_channelButton2) {
        _channelButton2 = [self _createChannelButton];
        [_channelButton2 setTitle:@"家庭营养师" forState:UIControlStateNormal];
        _weak(self);
        [_channelButton2 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectedDoctor = YES;
            [self.tableView.header beginRefreshing];
        }];
    }
    return _channelButton2;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[NutritionCell class] forCellReuseIdentifier:[NutritionCell reuseIdentifier]];
        [_tableView registerClass:[DoctorCell class] forCellReuseIdentifier:[DoctorCell reuseIdentifier]];
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
            return self.dataList ? self.dataList.count : 0;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            if (self.selectedDoctor) {
                WLDoctorModel *doctor = self.dataList[path.row];
                return [DoctorCell cellHeightWithDesc:doctor.desc];
            }
            return [NutritionCell cellHeight];
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            if (self.selectedDoctor) {
                DoctorCell *cell = [view dequeueReusableCellWithIdentifier:[DoctorCell reuseIdentifier] forIndexPath:path];
                WLDoctorModel *doctor = self.dataList[path.row];
                cell.actionCount  = doctor.actionCount;
                cell.commentCount = doctor.commentCount;
                cell.imageUrl     = doctor.images;
                cell.name         = doctor.trueName;
                cell.score        = doctor.star;
                cell.desc         = doctor.desc;
                return cell;
            }
            NutritionCell *cell = [view dequeueReusableCellWithIdentifier:[NutritionCell reuseIdentifier] forIndexPath:path];
            WLNutritionModel *nutrition = self.dataList[path.row];
            cell.imageUrl     = nutrition.images;
            cell.name         = nutrition.title;
            cell.actionCount  = nutrition.actionCount;
            cell.commentCount = nutrition.commentCount;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            if (self.selectedDoctor) {
                WLDoctorModel *doctor = self.dataList[path.row];
                [self.navigationController pushViewController:[[DoctorInfoVC alloc] initWithDoctor:doctor] animated:YES];
                return;
            }
            WLNutritionModel *nutrition = self.dataList[path.row];
            [self.navigationController pushViewController:[[NutritionInfoVC alloc] initWithNutrition:nutrition] animated:YES];
        }];
    }
    return _tableView;
}

@end
