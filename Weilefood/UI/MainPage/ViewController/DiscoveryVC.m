//
//  DiscoveryVC.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DiscoveryVC.h"

#import "DiscoveryCollectionHeaderView.h"
#import "DiscoveryCollectionCell.h"
#import <SwipeView/SwipeView.h>

#import "MarketIndexPageVC.h"
#import "ForwardBuyListVC.h"
#import "ActivityListVC.h"
#import "VideoListVC.h"

#import "ProductInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface DiscoveryVC () <UICollectionViewDataSource, UICollectionViewDelegate, SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) SwipeView     *bannerView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView   *leftImageView;
@property (nonatomic, strong) UILabel       *leftLabel;
@property (nonatomic, strong) UIButton      *leftButton;
@property (nonatomic, strong) UIImageView   *middleImageView;
@property (nonatomic, strong) UILabel       *middleLabel;
@property (nonatomic, strong) UIButton      *middleButton;
@property (nonatomic, strong) UIImageView   *rightImageView;
@property (nonatomic, strong) UILabel       *rightLabel;
@property (nonatomic, strong) UIButton      *rightButton;
@property (nonatomic, strong) UIImageView   *videoImageView;

@property (nonatomic, strong) UIView           *fixView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray             *bannerAdDatas;
@property (nonatomic, strong) NSArray             *sectionDataProducts;
@property (nonatomic, strong) NSArray             *sectionDataForwardBuys;
@property (nonatomic, strong) NSArray             *sectionDataNutritions;
@property (nonatomic, strong) NSArray             *sectionDataActivitys;

@end

static NSInteger const kHeaderBannerHeight  = 160;
static NSInteger const kHeaderButtonWidth   = 80;
static NSInteger const kHeaderButtonHeight  = 126;
static NSInteger const kHeaderAdHeight      = 88;

static NSString *const kCellIdentifier      = @"MYCELL";
static NSString *const kHeaderIdentifier    = @"HEADER";
static NSInteger const kCellMargin          = 10;

static NSInteger const kSectionCount           = 4;
static NSInteger const kSectionIndexProduct    = 0;
static NSInteger const kSectionIndexForwardBuy = 1;
static NSInteger const kSectionIndexNutrition  = 2;
static NSInteger const kSectionIndexActivity   = 3;

static NSInteger const kBannerAdImageChangeDelay = 4;

@implementation DiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                    image:[UIImage imageNamed:@"discovery_baritem_icon_n"]
                                            selectedImage:[UIImage imageNamed:@"discovery_baritem_icon_h"]];
    
    NSArray *array = @[self.bannerView,         self.pageControl,
                       self.leftImageView,      self.leftLabel,     self.leftButton,
                       self.middleImageView,    self.middleLabel,   self.middleButton,
                       self.rightImageView,     self.rightLabel,    self.rightButton,
                       self.videoImageView,
                       ];
    for (UIView *view in array) {
        [self.headerView addSubview:view];
    }
    
    [self.collectionView addSubview:self.headerView];
    
    [self.view addSubview:self.fixView];
    [self.view addSubview:self.collectionView];
    
    [self _addObserve];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0));
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
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bannerView);
        make.bottom.equalTo(self.bannerView);
        make.height.equalTo(@30);
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
    NSArray *views = @[@[self.leftImageView, self.leftLabel, self.leftButton],
                       @[self.middleImageView, self.middleLabel, self.middleButton],
                       @[self.rightImageView, self.rightLabel, self.rightButton],
                       ];
    for (NSArray *array in views) {
        UIImageView *imgView = array[0];
        UILabel *label = array[1];
        UIButton *btn = array[2];
        [imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.centerY.equalTo(btn).offset(-15);
        }];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgView);
            make.top.equalTo(imgView.mas_bottom).offset(10);
        }];
    }
    
    [self.videoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleButton.mas_bottom);
        make.left.right.equalTo(self.videoImageView.superview);
        make.bottomMargin.equalTo(@0);
    }];
}

#pragma mark - SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return self.bannerAdDatas ? self.bannerAdDatas.count : 0;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView = nil;
    if (!view) {
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = swipeView.bounds;
    }
    else {
        imageView = (UIImageView *)view;
    }
    WLAdModel *ad = self.bannerAdDatas[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:ad.images]];
    return imageView;
}

#pragma mark - SwipeViewDelegate

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    self.pageControl.currentPage = swipeView.currentPage;
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_autoNextBannerAdImage) object:nil];
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate {
    [self performSelector:@selector(_autoNextBannerAdImage) withObject:nil afterDelay:kBannerAdImageChangeDelay];
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    // TODO: 进入广告界面
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
    DiscoveryCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                   withReuseIdentifier:kHeaderIdentifier
                                                                                          forIndexPath:indexPath];
    _weak(self);
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
                DLog(@"");
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
        case kSectionIndexNutrition: {
            WLNutritionModel *nutrition = self.sectionDataNutritions[indexPath.item];
            imageUrl = nutrition.images;
            title = nutrition.title;
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
    
    DiscoveryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                              forIndexPath:indexPath];
    cell.imageUrl = imageUrl;
    cell.title = title;
    cell.money = money;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kSectionIndexProduct: {
            WLProductModel *product = self.sectionDataProducts[indexPath.item];
            [self.navigationController pushViewController:[[ProductInfoVC alloc] initWithProduct:product] animated:YES];
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
        [self.bannerView reloadData];
        self.pageControl.numberOfPages = self.bannerView.numberOfPages;
        [self performSelector:@selector(_autoNextBannerAdImage) withObject:nil afterDelay:kBannerAdImageChangeDelay];
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
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:kSectionIndexActivity]];
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
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:apiResult.videoIndexPic]];
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

- (void)_autoNextBannerAdImage {
    if (self.bannerView.numberOfPages > 0 && !self.bannerView.decelerating) {
        NSInteger newPage = self.bannerView.currentPage + 1;
        if (newPage >= self.bannerView.numberOfPages) {
            newPage = 0;
        }
        [self.bannerView scrollToPage:newPage duration:0.3];
    }
    [self performSelector:@selector(_autoNextBannerAdImage) withObject:nil afterDelay:kBannerAdImageChangeDelay];
}

- (UILabel *)_createButtonLabel {
    return ({
        UILabel *v = [[UILabel alloc] init];
        v.font = [UIFont systemFontOfSize:15];
        v.textColor = k_COLOR_MAROOM;
        v;
    });
}

#pragma mark - private property methons

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

- (SwipeView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[SwipeView alloc] init];
        _bannerView.backgroundColor = [UIColor grayColor];
        _bannerView.pagingEnabled = YES;
        _bannerView.wrapEnabled = YES;
        _bannerView.dataSource = self;
        _bannerView.delegate = self;
    }
    return _bannerView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"discovery_market_icon"];
    }
    return _leftImageView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [self _createButtonLabel];
        _leftLabel.text = @"集市";
    }
    return _leftLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _weak(self);
        [_leftButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self.navigationController pushViewController:[[MarketIndexPageVC alloc] init] animated:YES];
        }];
    }
    return _leftButton;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.image = [UIImage imageNamed:@"discovery_forwardbuy_icon"];
    }
    return _middleImageView;
}

- (UILabel *)middleLabel {
    if (!_middleLabel) {
        _middleLabel = [self _createButtonLabel];
        _middleLabel.text = @"预购";
    }
    return _middleLabel;
}

- (UIButton *)middleButton {
    if (!_middleButton) {
        _middleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _weak(self);
        [_middleButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self.navigationController pushViewController:[[ForwardBuyListVC alloc] init] animated:YES];
        }];
    }
    return _middleButton;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"discovery_right_icon"];
    }
    return _rightImageView;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [self _createButtonLabel];
        _rightLabel.text = @"营养推荐";
    }
    return _rightLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _weak(self);
        [_rightButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            DLog(@"");
        }];
    }
    return _rightButton;
}

- (UIImageView *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
        _videoImageView.userInteractionEnabled = YES;
        _weak(self);
        [_videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(UIGestureRecognizer *gesture) {
            _strong_check(self);
            [self.navigationController pushViewController:[[VideoListVC alloc] init] animated:YES];
        }]];
    }
    return _videoImageView;
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
        layout.headerReferenceSize = CGSizeMake(0, [DiscoveryCollectionHeaderView viewHeight]);
        CGFloat cellWidth = ([UIApplication sharedApplication].keyWindow.bounds.size.width - kCellMargin * 3) / 2.0;
        layout.itemSize = CGSizeMake(cellWidth, [DiscoveryCollectionCell cellHeightWithCellWidth:cellWidth]);
        layout.sectionInset = UIEdgeInsetsMake(0, kCellMargin, kCellMargin, kCellMargin);
        layout.minimumLineSpacing = kCellMargin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(kHeaderBannerHeight + kHeaderButtonHeight + kHeaderAdHeight, 0, 0, 0);
        [_collectionView registerClass:[DiscoveryCollectionCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [_collectionView registerClass:[DiscoveryCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
    }
    return _collectionView;
}

@end
