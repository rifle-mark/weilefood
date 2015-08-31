//
//  MyVideoVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyVideoVC.h"
#import "VideoCollectionCell.h"

#import "VideoInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface MyVideoVC ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *videoList;

@end

@implementation MyVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [UIBarButtonItem createUserBarButtonItem]];
    
    [self.view addSubview:self.collectionView];
    
    [self _addObserve];
    
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

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    static NSInteger const kPageSize = 10;
    _weak(self);
    NSUInteger pageIndex = self.videoList ? (self.videoList.count / kPageSize) + 1 : 1;
    [[WLServerHelper sharedInstance] video_getMyListWithPageIndex:pageIndex pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        static NSString *const kCellIdentifier   = @"MYCELL";
        static NSInteger const kCellMargin       = 10;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat cellWidth = ([UIApplication sharedApplication].keyWindow.bounds.size.width - kCellMargin * 3) / 2.0;
        layout.itemSize = CGSizeMake(cellWidth, [VideoCollectionCell cellHeightWithCellWidth:cellWidth]);
        layout.sectionInset = UIEdgeInsetsMake(kCellMargin, kCellMargin, kCellMargin, kCellMargin);
        layout.minimumLineSpacing = kCellMargin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[VideoCollectionCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _weak(self);
        [_collectionView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:YES];
        }];
        [_collectionView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:NO];
        }];
        [_collectionView withBlockForItemNumber:^NSInteger(UICollectionView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.videoList ? self.videoList.count : 0;
        }];
        [_collectionView withBlockForItemCell:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            VideoCollectionCell *cell = [view dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:path];
            WLVideoModel *video = self.videoList[path.item];
            cell.imageUrl     = video.images;
            cell.title        = video.title;
            cell.points       = video.points;
            cell.isVideo      = video.videoUrl && (video.videoUrl.length > 0);
            cell.isFavorite   = video.isFav;
            cell.showFavorite = NO;
            return cell;
        }];
        [_collectionView withBlockForItemDidSelect:^(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self);
            WLVideoModel *video = self.videoList[path.item];
            [self.navigationController pushViewController:[[VideoInfoVC alloc] initWithVideo:video] animated:YES];
        }];
    }
    return _collectionView;
}

@end
