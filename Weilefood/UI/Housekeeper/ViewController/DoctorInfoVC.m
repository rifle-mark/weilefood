//
//  DoctorInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorInfoVC.h"
#import "DoctorInfoHeaderView.h"
#import "ProductInfoSectionHeaderView.h"
#import "DoctorDescriptionCell.h"
#import "DoctorServiceCell.h"

#import "CommentListVC.h"
#import "LoginVC.h"
#import "ShareOnPlatformVC.h"
#import "OrderConfirmVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface DoctorInfoVC ()

@property (nonatomic, strong) UIBarButtonItem *favoriteItem;

@property (nonatomic, strong) UIView   *navView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *favoriteButton;

@property (nonatomic, strong) DoctorInfoHeaderView         *tableHeaderView;
@property (nonatomic, strong) ProductInfoSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UITableView                  *tableView;

@property (nonatomic, strong) WLDoctorModel *doctor;
@property (nonatomic, assign) CGFloat       headerHeight;

@end

@implementation DoctorInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithDoctor:方法初始化本界面");
    return nil;
}

- (id)initWithDoctor:(WLDoctorModel *)doctor {
    NSParameterAssert(doctor);
    if (self = [super init]) {
        _headerHeight = [DoctorInfoHeaderView viewHeight];
        self.doctor = doctor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_WHITE;
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], self.favoriteItem];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.backButton];
    [self.navView addSubview:self.favoriteButton];
    
    [self _showData];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.navView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).offset(6);
        make.left.equalTo(self.navView).offset(10);
    }];
    [self.favoriteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).offset(6);
        make.right.equalTo(self.navView).offset(-10);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.headerHeight = V_H_(self.tableHeaderView);
}

#pragma mark - private methods

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] doctor_getInfoWithDoctorId:self.doctor.doctorId callback:^(WLApiInfoModel *apiInfo, WLDoctorModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.doctor = apiResult;
        [self _showData];
    }];
}

- (void)_showData {
    self.title = self.doctor.trueName;
    
    [self _resetFavoriteItemColor];
    self.favoriteButton.highlighted = self.doctor.isFav;
    
    self.tableHeaderView.imageUrl = self.doctor.images;
    self.tableHeaderView.name  = self.doctor.trueName;
    self.tableHeaderView.score = self.doctor.star;
    
    self.sectionHeaderView.hasAction = self.doctor.isLike;
    self.sectionHeaderView.actionCount = self.doctor.actionCount;
    self.sectionHeaderView.commentCount = self.doctor.commentCount;
    
    [self.tableView reloadData];
}

- (void)_favoriteClick {
    _weak(self);
    [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
        _strong_check(self);
        if (self.doctor.isFav) {
            [[WLServerHelper sharedInstance] action_deleteFavoriteWithObjectType:WLActionTypeDoctor objectId:self.doctor.doctorId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                self.doctor.isFav = NO;
                [self _showData];
            }];
        }
        else {
            [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeFavorite objectType:WLActionTypeDoctor objectId:self.doctor.doctorId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                self.doctor.isFav = YES;
                [self _showData];
            }];
        }
    }];
}

- (void)_resetFavoriteItemColor {
    self.favoriteItem.tintColor = [(self.doctor.isFav ? k_COLOR_ORANGE : k_COLOR_WHITE) colorWithAlphaComponent:self.navigationBarAlpha];
}

#pragma mark - private property methods

- (UIBarButtonItem *)favoriteItem {
    if (!_favoriteItem) {
        _favoriteItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"doctorinfo_icon_favorite_n"]
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(_favoriteClick)];
    }
    return _favoriteItem;
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] init];
    }
    return _navView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"btn_back_n"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"btn_back_h"] forState:UIControlStateHighlighted];
    }
    return _backButton;
}

- (UIButton *)favoriteButton {
    if (!_favoriteButton) {
        _favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoriteButton setImage:[UIImage imageNamed:@"doctorinfo_btn_favorite_n"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"doctorinfo_btn_favorite_h"] forState:UIControlStateHighlighted];
    }
    return _favoriteButton;
}

- (DoctorInfoHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [DoctorInfoHeaderView viewHeight] - 64);
        _tableHeaderView = [[DoctorInfoHeaderView alloc] initWithFrame:frame];
        _tableHeaderView.backgroundColor = k_COLOR_WHITE;
    }
    return _tableHeaderView;
}

- (ProductInfoSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[ProductInfoSectionHeaderView alloc] init];
        _sectionHeaderView.backgroundColor = k_COLOR_WHITE;
        _weak(self);
        [_sectionHeaderView actionBlock:^{
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeApproval objectType:WLActionTypeDoctor objectId:self.doctor.doctorId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    self.doctor.actionCount++;
                    self.doctor.isLike = YES;
                    [self _showData];
                }];
            }];
        }];
        [_sectionHeaderView commentBlock:^{
            _strong_check(self);
            [CommentListVC showWithType:WLCommentTypeDoctor refId:self.doctor.doctorId dismissBlock:^(NSInteger addCount) {
                _strong_check(self);
                self.doctor.commentCount += addCount;
                [self _showData];
            }];
        }];
        [_sectionHeaderView shareBlock:^{
            _strong_check(self);
            NSString *url = [[WLServerHelper sharedInstance] getShareUrlWithType:WLServerHelperShareTypeDoctor objectId:self.doctor.doctorId];
            [ShareOnPlatformVC shareWithImageUrl:self.doctor.images title:self.doctor.trueName shareUrl:url];
        }];
    }
    return _sectionHeaderView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.tableHeaderView.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = [ProductInfoSectionHeaderView viewHeight];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 12)];
        [_tableView registerClass:[DoctorDescriptionCell class] forCellReuseIdentifier:[DoctorDescriptionCell reuseIdentifier]];
        [_tableView registerClass:[DoctorServiceCell class] forCellReuseIdentifier:[DoctorServiceCell reuseIdentifier]];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 1 + (self.doctor.service ? self.doctor.service.count : 0);
        }];
        [_tableView withBlockForHeaderView:^UIView *(UITableView *view, NSInteger section) {
            _strong_check(self, nil);
            return self.sectionHeaderView;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            if (path.row == 0) {
                return [DoctorDescriptionCell cellHeightWithDesc:self.doctor.desc];
            }
            WLDoctorServiceModel *service = self.doctor.service[path.row - 1];
            return [DoctorServiceCell cellHeightWithDesc:service.remark];
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            if (path.row == 0) {
                DoctorDescriptionCell *cell = [view dequeueReusableCellWithIdentifier:[DoctorDescriptionCell reuseIdentifier] forIndexPath:path];
                cell.desc = self.doctor.desc;
                return cell;
            }
            DoctorServiceCell *cell = [view dequeueReusableCellWithIdentifier:[DoctorServiceCell reuseIdentifier] forIndexPath:path];
            WLDoctorServiceModel *service = self.doctor.service[path.row - 1];
            cell.name  = service.title;
            cell.desc  = service.remark;
            cell.price = service.price;
            [cell buyClickBlock:^(DoctorServiceCell *cell) {
                [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                    _strong_check(self);
                    NSIndexPath *path = [self.tableView indexPathForCell:cell];
                    WLDoctorServiceModel *service = self.doctor.service[path.row - 1];
                    DLog(@"%@", service);
                    
                    WLOrderProductModel *product = [[WLOrderProductModel alloc] init];
                    product.type  = WLOrderProductTypeDoctor;
                    product.refId = service.doctorServiceId;
                    product.count = 1;
                    product.price = service.price;
                    product.title = [NSString stringWithFormat:@"%@ %@", self.doctor.trueName, service.title];
                    product.image = self.doctor.images;
                    [self.navigationController pushViewController:[[OrderConfirmVC alloc] initWithProductList:@[product] needAddress:NO] animated:YES];
                }];
            }];
            return cell;
        }];
        [_tableView withBlockForDidScroll:^(UIScrollView *view) {
            _strong_check(self);
            CGPoint offset = view.contentOffset;
            static CGFloat const navBarHeight = 64;
            CGFloat alpha = 1;
            if (offset.y < (self.headerHeight - navBarHeight * 2)) {
                alpha = 0;
            }
            else if (offset.y >= self.headerHeight - navBarHeight) {
                alpha = 1;
            }
            else  {
                alpha = (offset.y - (self.headerHeight - navBarHeight * 2)) / navBarHeight;
            }
            self.navigationBarAlpha = alpha;
        }];
    }
    return _tableView;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
    [super setNavigationBarAlpha:navigationBarAlpha];
    self.navView.alpha = 1 - navigationBarAlpha;
    [self _resetFavoriteItemColor];
}

@end
