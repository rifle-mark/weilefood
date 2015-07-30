//
//  ForwardBuyListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ForwardBuyListVC.h"
#import "ForwardBuyCell.h"

@interface ForwardBuyListVC ()

@property (nonatomic, strong) UIView   *channelsView;
@property (nonatomic, strong) UIButton *channelButton1;
@property (nonatomic, strong) UIButton *channelButton2;

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation ForwardBuyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预购";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [self.navigationController createUserBarButtonItem];
    
    [self.channelsView addSubview:self.channelButton1];
    [self.channelsView addSubview:self.channelButton2];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.channelsView];
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
        make.top.bottom.width.equalTo(self.channelButton1);
        make.left.equalTo(self.channelButton1.mas_right);
        make.right.equalTo(self.channelsView);
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
        [_channelButton1 setTitle:@"私房菜" forState:UIControlStateNormal];
        [self _setTextColorWithChannelButton:_channelButton1 isSelected:YES];
    }
    return _channelButton1;
}

- (UIButton *)channelButton2 {
    if (!_channelButton2) {
        _channelButton2 = [self _createChannelButton];
        [_channelButton2 setTitle:@"季节性商品" forState:UIControlStateNormal];
        [self _setTextColorWithChannelButton:_channelButton2 isSelected:NO];
    }
    return _channelButton2;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 280;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ForwardBuyCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 5;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            ForwardBuyCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            cell.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/a8014c086e061d95a0e7763979f40ad162d9ca0a.jpg";
            cell.name = @"魂牵梦萦影响力；影响力；影响力；影响力；";
            cell.number = 50;
            cell.price = 123.12;
            cell.actionCount = 10;
            cell.commentCount = 9;
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
