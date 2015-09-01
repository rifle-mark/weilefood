//
//  MyFavoriateVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyFavoriteVC.h"
#import "MyFavoriteCell.h"

#import "ProductInfoVC.h"
#import "ForwardBuyInfoVC.h"
#import "ActivityInfoVC.h"
#import "VideoInfoVC.h"
#import "NutritionInfoVC.h"
#import "DoctorInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface MyFavoriteVC ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *actionList;

@end

@implementation MyFavoriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = k_COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.tableView.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methods

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    static NSUInteger const kPageSize = 10;
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLActionModel *)[self.actionList lastObject]).createDate;
    [[WLServerHelper sharedInstance] action_myFavoriteListWithType:WLActionTypeAll maxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.actionList = isLatest ? apiResult : [self.actionList arrayByAddingObjectsFromArray:apiResult];
        [self.tableView reloadData];
        self.tableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

#pragma mark - private property methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = [MyFavoriteCell cellHeight];
        [_tableView registerClass:[MyFavoriteCell class] forCellReuseIdentifier:[MyFavoriteCell reuseIdentifier]];
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
            return self.actionList ? self.actionList.count : 0;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            MyFavoriteCell *cell = [view dequeueReusableCellWithIdentifier:[MyFavoriteCell reuseIdentifier] forIndexPath:path];
            WLActionModel *action = self.actionList[path.row];
            switch (action.type) {
                case WLActionTypeProduct: {
                    cell.type = @"集市";
                    cell.typeColor = k_COLOR_GOLDENROD;
                    break;
                }
                case WLActionTypeActivity: {
                    cell.type = @"活动";
                    cell.typeColor = k_COLOR_ORANGE;
                    break;
                }
                case WLActionTypeForwardBuy: {
                    cell.type = @"预购";
                    cell.typeColor = k_COLOR_ANZAC;
                    break;
                }
                case WLActionTypeNutrition: {
                    cell.type = @"营养推荐";
                    cell.typeColor = k_COLOR_MEDIUM_AQUAMARINE;
                    break;
                }
                case WLActionTypeVideo: {
                    cell.type = @"视频";
                    cell.typeColor = k_COLOR_LUST;
                    break;
                }
                case WLActionTypeDoctor: {
                    cell.type = @"家庭营养师";
                    cell.typeColor = k_COLOR_MEDIUMTURQUOISE;
                    break;
                }
                default: {
                    cell.type = @"其它";
                    cell.typeColor = k_COLOR_GOLDENROD;
                    break;
                }
            }
            cell.title = action.remark;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLActionModel *action = self.actionList[path.row];
            switch (action.type) {
                case WLActionTypeProduct: {
                    WLProductModel *product = [[WLProductModel alloc] init];
                    product.productId = (unsigned long)action.refId;
                    [self.navigationController pushViewController:[[ProductInfoVC alloc] initWithProduct:product] animated:YES];
                    break;
                }
                case WLActionTypeActivity: {
                    WLActivityModel *activity = [[WLActivityModel alloc] init];
                    activity.activityId = (unsigned long)action.refId;
                    [self.navigationController pushViewController:[[ActivityInfoVC alloc] initWithActivity:activity] animated:YES];
                    break;
                }
                case WLActionTypeForwardBuy: {
                    WLForwardBuyModel *forwardBuy = [[WLForwardBuyModel alloc] init];
                    forwardBuy.forwardBuyId = (unsigned long)action.refId;
                    [self.navigationController pushViewController:[[ForwardBuyInfoVC alloc] initWithForwardBuy:forwardBuy] animated:YES];
                    break;
                }
                case WLActionTypeNutrition: {
                    WLNutritionModel *nutrition = [[WLNutritionModel alloc] init];
                    nutrition.classId = action.refId;
                    [self.navigationController pushViewController:[[NutritionInfoVC alloc] initWithNutrition:nutrition] animated:YES];
                    break;
                }
                case WLActionTypeVideo: {
                    WLVideoModel *video = [[WLVideoModel alloc] init];
                    video.videoId = (unsigned long)action.refId;
                    [self.navigationController pushViewController:[[VideoInfoVC alloc] initWithVideo:video] animated:YES];
                    break;
                }
                case WLActionTypeDoctor: {
                    WLDoctorModel *doctor = [[WLDoctorModel alloc] init];
                    doctor.doctorId = action.refId;
                    [self.navigationController pushViewController:[[DoctorInfoVC alloc] initWithDoctor:doctor] animated:YES];
                    break;
                }
                default:
                    break;
            }
        }];
    }
    return _tableView;
}

@end
