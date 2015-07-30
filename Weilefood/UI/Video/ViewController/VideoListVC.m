//
//  VideoListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "VideoListVC.h"
#import "VideoCell.h"

@interface VideoListVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bannerImageView;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation VideoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [self.navigationController createUserBarButtonItem];
    
    [self.view addSubview:self.tableView];
    
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/a8014c086e061d95a0e7763979f40ad162d9ca0a.jpg"]];
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
        _tableView.tableHeaderView = self.bannerImageView;
        [_tableView registerClass:[VideoCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 5;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            VideoCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            cell.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/a8014c086e061d95a0e7763979f40ad162d9ca0a.jpg";
            cell.name = @"魂牵梦萦影响力；影响力；影响力；影响力；";
            cell.actionCount = path.row;
            cell.commentCount = path.row;
            cell.points = path.row * 111;
            return cell;
        }];
    }
    return _tableView;
}

- (UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc] init];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bannerImageView.clipsToBounds = YES;
        CGFloat viewWidth = V_W_([UIApplication sharedApplication].keyWindow);
        _bannerImageView.frame = CGRectMake(0, 0, viewWidth, viewWidth * 1.0 / 2.0);
    }
    return _bannerImageView;
}

@end
