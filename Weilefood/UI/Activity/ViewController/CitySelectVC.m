//
//  CitySelectVC.m
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "CitySelectVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface CitySelectVC ()

@property (nonatomic, strong) UIView           *gpsCityView;
@property (nonatomic, strong) UILabel          *gpsCityLabel;
@property (nonatomic, strong) UIButton         *gpsCityButton;
@property (nonatomic, strong) UILabel          *otherCityLabel;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) SelectedCity selectedCity;
@property (nonatomic, strong) NSArray *cityList;

@end

@implementation CitySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市";
    self.view.backgroundColor = k_COLOR_LAVENDER;
    
    [self.gpsCityView addSubview:self.gpsCityLabel];
    [self.gpsCityView addSubview:self.gpsCityButton];
    [self.view addSubview:self.gpsCityView];
    [self.view addSubview:self.otherCityLabel];
    [self.view addSubview:self.collectionView];
    
    [self _addObserve];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.gpsCityView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(@44);
    }];
    [self.gpsCityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.gpsCityLabel.superview).insets(UIEdgeInsetsMake(0, 22, 0, 0));
    }];
    [self.gpsCityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.gpsCityButton.superview);
    }];
    [self.otherCityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(22);
        make.top.equalTo(self.gpsCityView.mas_bottom).offset(25);
    }];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 22, 0, 22));
        make.top.equalTo(self.otherCityLabel.mas_bottom).offset(20);
        make.bottom.equalTo(self.view);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - public methods

- (void)selectedCity:(SelectedCity)block {
    self.selectedCity = block;
}

#pragma mark - private methods

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"cityList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.collectionView reloadData];
    }];
}

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] activity_getCityListWithCallback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.cityList = apiResult;
    }];
}

#pragma mark - private property methods

- (UIView *)gpsCityView {
    if (!_gpsCityView) {
        _gpsCityView = [[UIView alloc] init];
        _gpsCityView.backgroundColor = k_COLOR_WHITE;
    }
    return _gpsCityView;
}

- (UILabel *)gpsCityLabel {
    if (!_gpsCityLabel) {
        _gpsCityLabel = [[UILabel alloc] init];
        _gpsCityLabel.font = [UIFont systemFontOfSize:15];
    }
    return _gpsCityLabel;
}

- (UIButton *)gpsCityButton {
    if (!_gpsCityButton) {
        _gpsCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _gpsCityButton;
}

- (UILabel *)otherCityLabel {
    if (!_otherCityLabel) {
        _otherCityLabel = [[UILabel alloc] init];
        _otherCityLabel.font = [UIFont systemFontOfSize:15];
        _otherCityLabel.textColor = k_COLOR_STAR_DUST;
        _otherCityLabel.text = @"访问其它城市";
    }
    return _otherCityLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        static NSInteger const kCellMargin = 6;
        static NSString *const kCellIdentifier = @"MYCELL";
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat cellWidth = (V_W_([UIApplication sharedApplication].keyWindow) - 44 - kCellMargin * 2) / 3.0;
        layout.itemSize = CGSizeMake(cellWidth, 40);
        layout.minimumInteritemSpacing = kCellMargin;
        layout.minimumLineSpacing = kCellMargin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = self.view.backgroundColor;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _weak(self);
        [_collectionView withBlockForItemNumber:^NSInteger(UICollectionView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.cityList ? self.cityList.count : 0;
        }];
        [_collectionView withBlockForItemCell:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            UICollectionViewCell *cell = [view dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:path];
            cell.backgroundColor = k_COLOR_WHITE;
            cell.layer.cornerRadius = 4;
            
            static NSInteger const kLableTag = 101;
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:kLableTag];
            if (!label) {
                label = [[UILabel alloc] init];
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = k_COLOR_MAROOM;
                label.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(label.superview);
                }];
            }
            WLActivityCityModel *city = self.cityList[path.item];
            label.text = city.city;
            return cell;
        }];
        [_collectionView withBlockForItemDidSelect:^(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self);
            WLActivityCityModel *city = self.cityList[path.item];
            GCBlockInvoke(self.selectedCity, city);
        }];
    }
    return _collectionView;
}

@end
