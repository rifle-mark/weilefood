//
//  MainPageVC.m
//  Weilefood
//
//  Created by kelei on 15/7/25.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MainPageVC.h"
#import "MainPageCollectionHeaderView.h"
#import "MainPageCollectionCell.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface MainPageVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView   *headerView;
@property (nonatomic, strong) UIView   *bannerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView   *adView;

@property (nonatomic, strong) UIView   *fixView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *sectionDataProducts;
@property (nonatomic, strong) NSArray *sectionDataForwardBuys;
@property (nonatomic, strong) NSArray *sectionDataVideos;
@property (nonatomic, strong) NSArray *sectionDataActivitys;

@end

static NSInteger const kHeaderBannerHeight  = 100;
static NSInteger const kHeaderButtonWidth   = 80;
static NSInteger const kHeaderButtonHeight  = 80;
static NSInteger const kHeaderAdHeight      = 80;

static NSString *const kCellIdentifier      = @"MYCELL";
static NSString *const kHeaderIdentifier    = @"HEADER";
static NSInteger const kCellMargin          = 10;

static NSInteger const kSectionCount           = 4;
static NSInteger const kSectionIndexProduct    = 0;
static NSInteger const kSectionIndexForwardBuy = 1;
static NSInteger const kSectionIndexVideo      = 2;
static NSInteger const kSectionIndexActivity   = 3;

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"味了";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.headerView addSubview:self.bannerView];
    [self.headerView addSubview:self.leftButton];
    [self.headerView addSubview:self.middleButton];
    [self.headerView addSubview:self.rightButton];
    [self.headerView addSubview:self.adView];
    
    [self.collectionView addSubview:self.headerView];
    
    [self.view addSubview:self.fixView];
    [self.view addSubview:self.collectionView];
    
    [self _addObserve];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0));
    }];
    [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kHeaderBannerHeight + kHeaderButtonHeight + kHeaderAdHeight));
        make.bottom.equalTo(@0);
    }];
    [self.bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bannerView.superview);
        make.height.equalTo(@(kHeaderBannerHeight));
    }];
    [self.middleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom);
        make.centerX.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(kHeaderButtonWidth, kHeaderButtonHeight));
    }];
    CGFloat buttonMargin = ([UIApplication sharedApplication].keyWindow.bounds.size.width - kHeaderButtonWidth * 3) / 4.0;
    [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.middleButton);
        make.left.equalTo(@(buttonMargin));
    }];
    [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.middleButton);
        make.right.equalTo(@(-buttonMargin));
    }];
    [self.adView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleButton.mas_bottom);
        make.left.right.equalTo(self.adView.superview);
        make.bottomMargin.equalTo(@0);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case kSectionIndexProduct:
            return self.sectionDataProducts.count;
            break;
        case kSectionIndexForwardBuy:
            return self.sectionDataForwardBuys.count;
            break;
        case kSectionIndexVideo:
            return self.sectionDataVideos.count;
            break;
        case kSectionIndexActivity:
            return self.sectionDataActivitys.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return nil;
    }
    MainPageCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:kHeaderIdentifier
                                                                                         forIndexPath:indexPath];
    switch (indexPath.section) {
        case kSectionIndexProduct: {
            headerView.title = @"市集";
            headerView.allButtonActionBlock = ^(){
                [MBProgressHUD showErrorWithMessage:@"查看市集"];
            };
            break;
        }
        case kSectionIndexForwardBuy: {
            headerView.title = @"预购";
            headerView.allButtonActionBlock = ^(){
                [MBProgressHUD showErrorWithMessage:@"查看预购"];
            };
            break;
        }
        case kSectionIndexVideo: {
            headerView.title = @"课堂";
            headerView.allButtonActionBlock = ^(){
                [MBProgressHUD showErrorWithMessage:@"查看课堂"];
            };
            break;
        }
        case kSectionIndexActivity: {
            headerView.title = @"活动";
            headerView.allButtonActionBlock = ^(){
                [MBProgressHUD showErrorWithMessage:@"查看活动"];
            };
            break;
        }
        default:
            return nil;
            break;
    }
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageUrl = nil;
    NSString *title = nil;
    CGFloat money = 0;
    switch (indexPath.section) {
        case kSectionIndexProduct: {
            WLProductModel *product = self.sectionDataProducts[indexPath.item];
            imageUrl = product.images;
            title = product.productName;
            money = product.price;
            break;
        }
        case kSectionIndexForwardBuy: {
            WLForwardBuyModel *forwardBuy = self.sectionDataForwardBuys[indexPath.item];
            imageUrl = forwardBuy.banner;
            title = forwardBuy.title;
            money = forwardBuy.price;
            break;
        }
        case kSectionIndexVideo: {
            WLVideoModel *video = self.sectionDataVideos[indexPath.item];
            imageUrl = video.images;
            title = video.title;
            money = 0;
            break;
        }
        case kSectionIndexActivity: {
            WLActivityModel *activity = self.sectionDataActivitys[indexPath.item];
            imageUrl = activity.banner;
            title = activity.title;
            money = activity.price;
            break;
        }
        default:
            return nil;
            break;
    }
    
    MainPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                             forIndexPath:indexPath];
    cell.imageUrl = imageUrl;
    cell.title = title;
    cell.money = money;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"sectionDataProducts" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexProduct]];
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataForwardBuys" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexForwardBuy]];
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataVideos" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexVideo]];
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataActivitys" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexActivity]];
    }];
}

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] product_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        self.sectionDataProducts = apiResult;
    }];
    [[WLServerHelper sharedInstance] forwardBuy_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        self.sectionDataForwardBuys = apiResult;
    }];
    [[WLServerHelper sharedInstance] video_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        self.sectionDataVideos = apiResult;
    }];
    [[WLServerHelper sharedInstance] activity_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (error) {
            DLog(@"%@", error);
            return;
        }
        if (!apiInfo.isSuc) {
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        self.sectionDataActivitys = apiResult;
    }];
}

#pragma mark - private property methons

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

- (UIView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[UIView alloc] init];
        _bannerView.backgroundColor = [UIColor grayColor];
    }
    return _bannerView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftButton.backgroundColor = [UIColor greenColor];
        [_leftButton setTitle:@"集市" forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UIButton *)middleButton {
    if (!_middleButton) {
        _middleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _middleButton.backgroundColor = [UIColor greenColor];
        [_middleButton setTitle:@"预购" forState:UIControlStateNormal];
    }
    return _middleButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.backgroundColor = [UIColor greenColor];
        [_rightButton setTitle:@"课堂" forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (UIView *)adView {
    if (!_adView) {
        _adView = [[UIView alloc] init];
        _adView.backgroundColor = [UIColor yellowColor];
    }
    return _adView;
}

- (UIView *)fixView {
    if (!_fixView) {
        _fixView = [[UIView alloc] init];
    }
    return _fixView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(0, 40);
        CGFloat cellWidth = ([UIApplication sharedApplication].keyWindow.bounds.size.width - kCellMargin * 3) / 2.0;
        layout.itemSize = CGSizeMake(cellWidth, cellWidth + 50);
        layout.sectionInset = UIEdgeInsetsMake(0, kCellMargin, kCellMargin, kCellMargin);
        layout.minimumLineSpacing = kCellMargin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(kHeaderBannerHeight + kHeaderButtonHeight + kHeaderAdHeight, 0, 0, 0);
        [_collectionView registerClass:[MainPageCollectionCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [_collectionView registerClass:[MainPageCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
    }
    return _collectionView;
}

@end
