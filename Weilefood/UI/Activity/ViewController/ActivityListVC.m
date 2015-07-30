//
//  ActivityListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ActivityListVC.h"
#import "ActivityCell.h"

@interface ActivityListVC ()

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation ActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [self.navigationController createUserBarButtonItem];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.topLayoutGuide.length);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - private methons

- (void)_addObserve {
    //    _weak(self);
    //    [self startObserveObject:self forKeyPath:@"sectionDataProducts" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
    //        _strong_check(self);
    //        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexProduct]];
    //    }];
}

- (void)_loadData {
    //    _weak(self);
    //    [[WLServerHelper sharedInstance] product_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
    //        _strong_check(self);
    //        if (error) {
    //            DLog(@"%@", error);
    //            return;
    //        }
    //        if (!apiInfo.isSuc) {
    //            [MBProgressHUD showErrorWithMessage:apiInfo.message];
    //            return;
    //        }
    //        self.sectionDataProducts = apiResult;
    //    }];
}

- (void)_loadMoreData {
    //    _weak(self);
}

#pragma mark - private property methons

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 280;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ActivityCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 5;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            ActivityCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            cell.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/a8014c086e061d95a0e7763979f40ad162d9ca0a.jpg";
            cell.name = @"魂牵梦萦影响力；影响力；影响力；影响力；";
            cell.city = @"成都";
            cell.participated = path.row % 2 == 0;
            switch (path.row % 3) {
                case 0: {
                    cell.beginDate = [NSDate dateWithYear:2015 month:8 day:5];
                    break;
                }
                case 1: {
                    cell.beginDate = [NSDate dateWithYear:2015 month:7 day:30];
                    break;
                }
                case 2: {
                    cell.beginDate = [NSDate dateWithYear:2015 month:7 day:1];
                    break;
                }
                default:
                    break;
            }
            cell.endDate = [cell.beginDate dateByAddingDays:2];
            return cell;
        }];
    }
    return _tableView;
}

@end
