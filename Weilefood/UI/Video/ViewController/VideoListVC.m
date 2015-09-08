//
//  VideoListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "VideoListVC.h"
#import "VideoCollectionCell.h"

#import "VideoInfoVC.h"
#import "LoginVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface VideoListVC ()

@property (nonatomic, strong) UIImageView      *bannerImageView;
@property (nonatomic, strong) UIView           *lineView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat bannerImageHeight;
@property (nonatomic, strong) NSArray *videoList;

@end

static NSString *const kCellIdentifier   = @"MYCELL";
static NSString *const kHeaderIdentifier = @"MYHEADER";
static NSInteger const kCellMargin       = 10;
static NSInteger const kLineViewHeight   = 8;

static NSInteger const kPageSize       = 10;

@implementation VideoListVC

- (id)init {
    if (self = [super init]) {
        _bannerImageHeight = V_W_([UIApplication sharedApplication].keyWindow) * 5.0 / 8.0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [UIBarButtonItem createUserBarButtonItem]];
    
    [self.view addSubview:self.collectionView];
    
    [self _addObserve];
    
    [self _loadBannerImageData];
    [self.collectionView.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"videoList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadData];
    }];
}

- (void)_loadBannerImageData {
    _weak(self);
    [[WLServerHelper sharedInstance] video_getAdImageWithCallback:^(WLApiInfoModel *apiInfo, WLVideoAdImageModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        [self.bannerImageView my_setImageWithURL:[NSURL URLWithString:apiResult.videoListPic]];
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLVideoModel *)[self.videoList lastObject]).createDate;
    [[WLServerHelper sharedInstance] video_getListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.collectionView.header.isRefreshing) {
            [self.collectionView.header endRefreshing];
        }
        if (self.collectionView.footer.isRefreshing) {
            [self.collectionView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.videoList = isLatest ? apiResult : [self.videoList arrayByAddingObjectsFromArray:apiResult];
        self.collectionView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

#pragma mark - private property methons

- (UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc] init];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bannerImageView.clipsToBounds = YES;
    }
    return _bannerImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIImageView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(0, self.bannerImageHeight + kLineViewHeight);
        CGFloat cellWidth = ([UIApplication sharedApplication].keyWindow.bounds.size.width - kCellMargin * 3) / 2.0;
        layout.itemSize = CGSizeMake(cellWidth, [VideoCollectionCell cellHeightWithCellWidth:cellWidth]);
        layout.sectionInset = UIEdgeInsetsMake(kCellMargin, kCellMargin, kCellMargin, kCellMargin);
        layout.minimumLineSpacing = kCellMargin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = k_COLOR_WHITE;
        [_collectionView registerClass:[VideoCollectionCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
        _weak(self);
        [_collectionView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:YES];
        }];
        [_collectionView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:NO];
        }];
        [_collectionView withBlockForSupplementaryElement:^UICollectionReusableView *(UICollectionView *view, NSString *kind, NSIndexPath *path) {
            _strong_check(self, nil);
            if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
                return nil;
            }
            UICollectionReusableView *headerView = [view dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderIdentifier forIndexPath:path];
            [headerView addSubview:self.bannerImageView];
            [headerView addSubview:self.lineView];
            [self.bannerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.bannerImageView.superview);
                make.height.equalTo(@(self.bannerImageHeight));
            }];
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.left.right.equalTo(self.lineView.superview);
                make.top.equalTo(self.bannerImageView.mas_bottom);
            }];
            return headerView;
        }];
        [_collectionView withBlockForItemNumber:^NSInteger(UICollectionView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.videoList ? self.videoList.count : 0;
        }];
        [_collectionView withBlockForItemCell:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            VideoCollectionCell *cell = [view dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:path];
            WLVideoModel *video = self.videoList[path.item];
            cell.imageUrl = video.images;
            cell.title    = video.title;
            cell.isVideo  = video.videoUrl && (video.videoUrl.length > 0);
            return cell;
        }];
        [_collectionView withBlockForItemDidSelect:^(UICollectionView *view, NSIndexPath *path) {
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                WLVideoModel *video = self.videoList[path.item];
                [self.navigationController pushViewController:[[VideoInfoVC alloc] initWithVideo:video] animated:YES];
            }];
        }];
    }
    return _collectionView;
}

@end
