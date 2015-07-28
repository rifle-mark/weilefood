//
//  MarketIndexPageVC.m
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MarketIndexPageVC.h"
#import "MarketProductCell.h"

@interface MarketIndexPageVC ()

@property (nonatomic, strong) UIView   *channelsView;
@property (nonatomic, strong) UIButton *channelButton1;
@property (nonatomic, strong) UIButton *channelButton2;
@property (nonatomic, strong) UIButton *channelButton3;
@property (nonatomic, strong) UILabel  *arrowLabel;

@property (nonatomic, strong) UIView   *childChannelsView;
@property (nonatomic, strong) UIButton *childChannelAllButton;
@property (nonatomic, strong) UIButton *childChannelButton1;
@property (nonatomic, strong) UIButton *childChannelButton2;
@property (nonatomic, strong) UIButton *childChannelButton3;
@property (nonatomic, strong) UIButton *childChannelButton4;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowChildChannelsView;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation MarketIndexPageVC

- (id)init {
    if (self = [super init]) {
        _isShowChildChannelsView = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"集市";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.channelButton1 addSubview:self.arrowLabel];
    [self.channelsView addSubview:self.channelButton1];
    [self.channelsView addSubview:self.channelButton2];
    [self.channelsView addSubview:self.channelButton3];
    [self.childChannelsView addSubview:self.childChannelAllButton];
    [self.childChannelsView addSubview:self.childChannelButton1];
    [self.childChannelsView addSubview:self.childChannelButton2];
    [self.childChannelsView addSubview:self.childChannelButton3];
    [self.childChannelsView addSubview:self.childChannelButton4];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.childChannelsView];
    [self.view addSubview:self.channelsView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.channelsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0));
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelsView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.childChannelsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@80);
        if (self.isShowChildChannelsView) {
            make.top.equalTo(self.channelsView.mas_bottom);
        }
        else {
            make.bottom.equalTo(self.channelsView);
        }
    }];
    
    [self.channelButton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.channelsView);
        make.width.equalTo(self.channelButton2);
    }];
    [self.channelButton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.channelButton1);
        make.left.equalTo(self.channelButton1.mas_right);
    }];
    [self.channelButton3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.channelButton2);
        make.left.equalTo(self.channelButton2.mas_right);
        make.right.equalTo(self.channelsView);
    }];
    [self.arrowLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.channelButton1).centerOffset(CGPointMake(30, 0));
    }];
    
    [self.childChannelAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.childChannelsView);
        make.width.equalTo(self.childChannelButton1);
    }];
    [self.childChannelButton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.equalTo(self.childChannelAllButton);
        make.left.equalTo(self.childChannelAllButton.mas_right);
    }];
    [self.childChannelButton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.equalTo(self.childChannelButton1);
        make.left.equalTo(self.childChannelButton1.mas_right);
    }];
    [self.childChannelButton3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.equalTo(self.childChannelButton2);
        make.left.equalTo(self.childChannelButton2.mas_right);
    }];
    [self.childChannelButton4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.equalTo(self.childChannelButton3);
        make.left.equalTo(self.childChannelButton3.mas_right);
        make.right.equalTo(self.childChannelsView);
    }];
}

#pragma mark - private methons

- (void)_addObserve {
//    _weak(self);
//    [self startObserveObject:self forKeyPath:@"sectionDataProducts" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
//        _strong_check(self);
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexProduct]];
//    }];
//    [self startObserveObject:self forKeyPath:@"sectionDataForwardBuys" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
//        _strong_check(self);
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexForwardBuy]];
//    }];
//    [self startObserveObject:self forKeyPath:@"sectionDataVideos" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
//        _strong_check(self);
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexVideo]];
//    }];
//    [self startObserveObject:self forKeyPath:@"sectionDataActivitys" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
//        _strong_check(self);
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexActivity]];
//    }];
}

- (void)setIsShowChildChannelsView:(BOOL)isShowChildChannelsView animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.isShowChildChannelsView = isShowChildChannelsView;
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }];
    }
    else {
        self.isShowChildChannelsView = isShowChildChannelsView;
        [self.view setNeedsLayout];
    }
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
//    [[WLServerHelper sharedInstance] forwardBuy_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
//        _strong_check(self);
//        if (error) {
//            DLog(@"%@", error);
//            return;
//        }
//        if (!apiInfo.isSuc) {
//            [MBProgressHUD showErrorWithMessage:apiInfo.message];
//            return;
//        }
//        self.sectionDataForwardBuys = apiResult;
//    }];
//    [[WLServerHelper sharedInstance] video_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
//        _strong_check(self);
//        if (error) {
//            DLog(@"%@", error);
//            return;
//        }
//        if (!apiInfo.isSuc) {
//            [MBProgressHUD showErrorWithMessage:apiInfo.message];
//            return;
//        }
//        self.sectionDataVideos = apiResult;
//    }];
//    [[WLServerHelper sharedInstance] activity_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
//        _strong_check(self);
//        if (error) {
//            DLog(@"%@", error);
//            return;
//        }
//        if (!apiInfo.isSuc) {
//            [MBProgressHUD showErrorWithMessage:apiInfo.message];
//            return;
//        }
//        self.sectionDataActivitys = apiResult;
//    }];
}

#pragma mark - private property methons

- (UIView *)channelsView {
    if (!_channelsView) {
        _channelsView = [[UIView alloc] init];
        _channelsView.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
    }
    return _channelsView;
}

- (UIButton *)channelButton1 {
    if (!_channelButton1) {
        _channelButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_channelButton1 setTitle:@"优选" forState:UIControlStateNormal];
        [_channelButton1 setTitleColor:k_COLOR_THEME_NAVIGATIONBAR_TEXT forState:UIControlStateNormal];
        
        _weak(self);
        [_channelButton1 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self setIsShowChildChannelsView:!self.isShowChildChannelsView animated:YES];
        }];
    }
    return _channelButton1;
}

- (UIButton *)channelButton2 {
    if (!_channelButton2) {
        _channelButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_channelButton2 setTitle:@"洋货" forState:UIControlStateNormal];
        [_channelButton2 setTitleColor:k_COLOR_THEME_NAVIGATIONBAR_TEXT forState:UIControlStateNormal];
    }
    return _channelButton2;
}

- (UIButton *)channelButton3 {
    if (!_channelButton3) {
        _channelButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_channelButton3 setTitle:@"餐具" forState:UIControlStateNormal];
        [_channelButton3 setTitleColor:k_COLOR_THEME_NAVIGATIONBAR_TEXT forState:UIControlStateNormal];
    }
    return _channelButton3;
}

- (UILabel *)arrowLabel {
    if (!_arrowLabel) {
        _arrowLabel = [[UILabel alloc] init];
        _arrowLabel.text = @"⌄";
        _arrowLabel.textColor = k_COLOR_THEME_NAVIGATIONBAR_TEXT;
    }
    return _arrowLabel;
}

- (UIView *)childChannelsView {
    if (!_childChannelsView) {
        _childChannelsView = [[UIView alloc] init];
        _childChannelsView.backgroundColor = k_COLOR_WHITE;
    }
    return _childChannelsView;
}

- (UIButton *)childChannelAllButton {
    if (!_childChannelAllButton) {
        _childChannelAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_childChannelAllButton setTitle:@"全部" forState:UIControlStateNormal];
    }
    return _childChannelAllButton;
}

- (UIButton *)childChannelButton1 {
    if (!_childChannelButton1) {
        _childChannelButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_childChannelButton1 setTitle:@"粮油调料" forState:UIControlStateNormal];
    }
    return _childChannelButton1;
}

- (UIButton *)childChannelButton2 {
    if (!_childChannelButton2) {
        _childChannelButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_childChannelButton2 setTitle:@"养生煲汤" forState:UIControlStateNormal];
    }
    return _childChannelButton2;
}

- (UIButton *)childChannelButton3 {
    if (!_childChannelButton3) {
        _childChannelButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_childChannelButton3 setTitle:@"特色美食" forState:UIControlStateNormal];
    }
    return _childChannelButton3;
}

- (UIButton *)childChannelButton4 {
    if (!_childChannelButton4) {
        _childChannelButton4 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_childChannelButton4 setTitle:@"精选菜品" forState:UIControlStateNormal];
    }
    return _childChannelButton4;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 150;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MarketProductCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 10;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            MarketProductCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            cell.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/a8014c086e061d95a0e7763979f40ad162d9ca0a.jpg";
            cell.name = @"魂牵梦萦影响力；影响力；影响力；影响力；";
            cell.number = 50;
            cell.price = 123.12;
            cell.actionCount = 10;
            cell.commentCount = 9;
            return cell;
        }];
    }
    return _tableView;
}

@end