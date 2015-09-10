//
//  DiscoveryVC.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DiscoveryVC.h"

#import "DiscoveryCollectionHeaderView.h"
#import "DiscoveryCollectionSectionHeaderView.h"
#import "DiscoveryCollectionCell.h"

#import "LoginVC.h"
#import "MarketIndexPageVC.h"
#import "ForwardBuyListVC.h"
#import "ActivityListVC.h"
#import "VideoListVC.h"
#import "HousekeeperIndexVC.h"

#import "ProductInfoVC.h"
#import "ForwardBuyInfoVC.h"
#import "ActivityInfoVC.h"
#import "NutritionInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"
#import "WLAdHelper.h"

@interface DiscoveryVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    CGFloat _cellWidth;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) DiscoveryCollectionHeaderView *headerView;

@property (nonatomic, strong) NSArray  *bannerAdDatas;
@property (nonatomic, strong) NSString *videoAdImage;
@property (nonatomic, strong) NSArray  *sectionDataProducts;
@property (nonatomic, strong) NSArray  *sectionDataForwardBuys;
@property (nonatomic, strong) NSArray  *sectionDataNutritions;
@property (nonatomic, strong) NSArray  *sectionDataActivitys;

@end

static NSString *const kCellIdentifier          = @"MYCELL";
static NSString *const kHeaderIdentifier        = @"HEADER";
static NSString *const kSectionHeaderIdentifier = @"SECTIONHEADER";
static NSInteger const kCellMargin              = 10;

static NSInteger const kSectionIndexHeader     = 0;
static NSInteger const kSectionIndexProduct    = 1;
static NSInteger const kSectionIndexForwardBuy = 2;
static NSInteger const kSectionIndexNutrition  = 3;
static NSInteger const kSectionIndexActivity   = 4;

@implementation DiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellWidth = (SCREEN_WIDTH - kCellMargin * 3) / 2.0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                    image:[UIImage imageNamed:@"discovery_baritem_icon_n"]
                                            selectedImage:[UIImage imageNamed:@"discovery_baritem_icon_h"]];
    
    [self.view addSubview:self.collectionView];
    
    [self _addObserve];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0));
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kSectionIndexActivity + (self.sectionDataActivitys && self.sectionDataActivitys.count > 0 ? 1 : 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case kSectionIndexProduct:
            return self.sectionDataProducts.count;
            break;
        case kSectionIndexForwardBuy:
            return self.sectionDataForwardBuys.count;
            break;
        case kSectionIndexNutrition:
            return self.sectionDataNutritions.count;
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
    
    _weak(self);
    if (indexPath.section == kSectionIndexHeader) {
        DiscoveryCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                       withReuseIdentifier:kHeaderIdentifier
                                                                                              forIndexPath:indexPath];
        if (self.headerView == headerView) {
            return headerView;
        }
        headerView.bannerImageUrls = [self _getBannerImages];
        headerView.videoImageUrl = self.videoAdImage;
        [headerView bannerImageClickBlock:^(NSInteger index) {
            _strong_check(self);
            WLAdModel *ad = self.bannerAdDatas[index];
            [WLAdHelper openWithAd:ad];
        }];
        [headerView marketClickBlock:^{
            _strong_check(self);
            [self.navigationController pushViewController:[[MarketIndexPageVC alloc] init] animated:YES];
        }];
        [headerView forwardbuyClickBlock:^{
            _strong_check(self);
            [self.navigationController pushViewController:[[ForwardBuyListVC alloc] init] animated:YES];
        }];
        [headerView nutritionClickBlock:^{
            _strong_check(self);
            [self.navigationController pushViewController:[[HousekeeperIndexVC alloc] init] animated:YES];
        }];
        [headerView videoImageClickBlock:^{
            _strong_check(self);
            [self.navigationController pushViewController:[[VideoListVC alloc] init] animated:YES];
        }];
        self.headerView = headerView;
        return headerView;
    }

    DiscoveryCollectionSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                          withReuseIdentifier:kSectionHeaderIdentifier
                                                                                                 forIndexPath:indexPath];
    switch (indexPath.section) {
        case kSectionIndexProduct: {
            headerView.title = @"集市";
            headerView.allButtonActionBlock = ^(){
                _strong_check(self);
                [self.navigationController pushViewController:[[MarketIndexPageVC alloc] init] animated:YES];
            };
            break;
        }
        case kSectionIndexForwardBuy: {
            headerView.title = @"预购";
            headerView.allButtonActionBlock = ^(){
                _strong_check(self);
                [self.navigationController pushViewController:[[ForwardBuyListVC alloc] init] animated:YES];
            };
            break;
        }
        case kSectionIndexNutrition: {
            headerView.title = @"营养推荐";
            headerView.allButtonActionBlock = ^(){
                _strong_check(self);
                [self.navigationController pushViewController:[[HousekeeperIndexVC alloc] init] animated:YES];
            };
            break;
        }
        case kSectionIndexActivity: {
            headerView.title = @"活动";
            headerView.allButtonActionBlock = ^(){
                _strong_check(self);
                [self.navigationController pushViewController:[[ActivityListVC alloc] init] animated:YES];
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
    BOOL showMoney = YES;
    switch (indexPath.section) {
        case kSectionIndexProduct: {
            WLProductModel *product = self.sectionDataProducts[indexPath.item];
            imageUrl = product.images;
            title    = product.productName;
            money    = product.price;
            break;
        }
        case kSectionIndexForwardBuy: {
            WLForwardBuyModel *forwardBuy = self.sectionDataForwardBuys[indexPath.item];
            imageUrl = forwardBuy.banner;
            title    = forwardBuy.title;
            money    = forwardBuy.price;
            break;
        }
        case kSectionIndexNutrition: {
            WLNutritionModel *nutrition = self.sectionDataNutritions[indexPath.item];
            imageUrl  = nutrition.images;
            title     = nutrition.title;
            showMoney = NO;
            break;
        }
        case kSectionIndexActivity: {
            WLActivityModel *activity = self.sectionDataActivitys[indexPath.item];
            imageUrl = activity.banner;
            title    = activity.title;
            money    = activity.price;
            break;
        }
        default:
            return nil;
            break;
    }
    
    DiscoveryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                              forIndexPath:indexPath];
    cell.imageUrl  = imageUrl;
    cell.title     = title;
    cell.money     = money;
    cell.showMoney = showMoney;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = V_W_(self.view);
    return CGSizeMake(width, section == 0 ? [DiscoveryCollectionHeaderView viewHeight] : [DiscoveryCollectionSectionHeaderView viewHeight]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kCellMargin, section == kSectionIndexHeader ? 0 : kCellMargin, kCellMargin);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_cellWidth, [DiscoveryCollectionCell cellHeightWithCellWidth:_cellWidth showMoney:indexPath.section != kSectionIndexNutrition]);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kSectionIndexProduct: {
            WLProductModel *product = self.sectionDataProducts[indexPath.item];
            [self.navigationController pushViewController:[[ProductInfoVC alloc] initWithProduct:product] animated:YES];
            break;
        }
        case kSectionIndexForwardBuy: {
            WLForwardBuyModel *forwardBuy = self.sectionDataForwardBuys[indexPath.item];
            [self.navigationController pushViewController:[[ForwardBuyInfoVC alloc] initWithForwardBuy:forwardBuy] animated:YES];
            break;
        }
        case kSectionIndexActivity: {
            WLActivityModel *activity = self.sectionDataActivitys[indexPath.item];
            [self.navigationController pushViewController:[[ActivityInfoVC alloc] initWithActivity:activity] animated:YES];
            break;
        }
        case kSectionIndexNutrition: {
            WLNutritionModel *nutrition = self.sectionDataNutritions[indexPath.item];
            [self.navigationController pushViewController:[[NutritionInfoVC alloc] initWithNutrition:nutrition] animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    
    [self startObserveObject:self forKeyPath:@"bannerAdDatas" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        self.headerView.bannerImageUrls = [self _getBannerImages];
    }];
    [self startObserveObject:self forKeyPath:@"videoAdImage" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        self.headerView.videoImageUrl = self.videoAdImage;
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataProducts" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexProduct]];
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataForwardBuys" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexForwardBuy]];
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataNutritions" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexNutrition]];
    }];
    [self startObserveObject:self forKeyPath:@"sectionDataActivitys" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadData];
    }];
}

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] ad_getListWithCallback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.bannerAdDatas = apiResult;
    }];
    [[WLServerHelper sharedInstance] video_getAdImageWithCallback:^(WLApiInfoModel *apiInfo, WLVideoAdImageModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.videoAdImage = apiResult.videoIndexPic;
    }];
    [[WLServerHelper sharedInstance] product_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.sectionDataProducts = apiResult;
    }];
    [[WLServerHelper sharedInstance] forwardBuy_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.sectionDataForwardBuys = apiResult;
    }];
    [[WLServerHelper sharedInstance] nutrition_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.sectionDataNutritions = apiResult;
    }];
    [[WLServerHelper sharedInstance] activity_getListWithPageIndex:1 pageSize:4 callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.sectionDataActivitys = apiResult;
    }];
}

- (NSArray *)_getBannerImages {
    NSMutableArray *ret = [NSMutableArray array];
    for (WLAdModel *ad in self.bannerAdDatas) {
        [ret addObject:ad.images];
    }
    return ret;
}

#pragma mark - private property methons

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = kCellMargin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DiscoveryCollectionCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [_collectionView registerClass:[DiscoveryCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
        [_collectionView registerClass:[DiscoveryCollectionSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderIdentifier];
    }
    return _collectionView;
}

@end
