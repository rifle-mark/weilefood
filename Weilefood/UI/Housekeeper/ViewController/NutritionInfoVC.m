//
//  NutritionInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "NutritionInfoVC.h"
#import "NutritionInfoHeaderView.h"
#import "ProductInfoSectionHeaderView.h"

#import "CommentListVC.h"
#import "LoginVC.h"
#import "ShareOnPlatformVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"


@interface NutritionInfoVC ()

@property (nonatomic, strong) UIBarButtonItem *favoriteItem;

@property (nonatomic, strong) UIView   *navView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *favoriteButton;

@property (nonatomic, strong) NutritionInfoHeaderView      *tableHeaderView;
@property (nonatomic, strong) ProductInfoSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UIWebView                    *webView;
@property (nonatomic, strong) UITableView                  *tableView;

@property (nonatomic, strong) WLNutritionModel *nutrition;
@property (nonatomic, assign) CGFloat          headerHeight;

@end

@implementation NutritionInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithNutrition:方法初始化本界面");
    return nil;
}

- (id)initWithNutrition:(WLNutritionModel *)nutrition {
    NSParameterAssert(nutrition);
    if (self = [super init]) {
        _headerHeight = [NutritionInfoHeaderView viewHeight];
        self.nutrition = nutrition;
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
    [[WLServerHelper sharedInstance] nutrition_getInfoWithNutritionId:self.nutrition.classId callback:^(WLApiInfoModel *apiInfo, WLNutritionModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.nutrition = apiResult;
        [self _showData];
    }];
}

- (void)_showData {
    self.title = self.nutrition.title;
    
    [self _resetFavoriteItemColor];
    self.favoriteButton.highlighted = self.nutrition.isFav;
    
    self.tableHeaderView.imageUrl = self.nutrition.images;
    self.tableHeaderView.title  = self.nutrition.title;
    
    self.sectionHeaderView.hasAction = self.nutrition.isLike;
    self.sectionHeaderView.actionCount = self.nutrition.actionCount;
    self.sectionHeaderView.commentCount = self.nutrition.commentCount;
    
    if (self.webView.superview) {
        [self.webView loadHTMLString:self.nutrition.desc baseURL:nil];
    }
    
    [self.tableView reloadData];
}

- (void)_favoriteClick {
    _weak(self);
    [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
        _strong_check(self);
        if (self.nutrition.isFav) {
            [[WLServerHelper sharedInstance] action_deleteFavoriteWithObjectType:WLActionTypeNutrition objectId:self.nutrition.classId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                self.nutrition.isFav = NO;
                [self _showData];
            }];
        }
        else {
            [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeFavorite objectType:WLActionTypeNutrition objectId:self.nutrition.classId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                self.nutrition.isFav = YES;
                [self _showData];
            }];
        }
    }];
}

- (void)_resetFavoriteItemColor {
    self.favoriteItem.tintColor = [(self.nutrition.isFav ? k_COLOR_ORANGE : k_COLOR_WHITE) colorWithAlphaComponent:self.navigationBarAlpha];
}

- (void)_resetWebViewHeight {
    if (self.webView.superview) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
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

- (NutritionInfoHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [NutritionInfoHeaderView viewHeight] - 64);
        _tableHeaderView = [[NutritionInfoHeaderView alloc] initWithFrame:frame];
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
                [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeApproval objectType:WLActionTypeNutrition objectId:self.nutrition.classId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    self.nutrition.actionCount++;
                    self.nutrition.isLike = YES;
                    [self _showData];
                }];
            }];
        }];
        [_sectionHeaderView commentBlock:^{
            _strong_check(self);
            [CommentListVC showWithType:WLCommentTypeDoctor refId:self.nutrition.classId];
        }];
        [_sectionHeaderView shareBlock:^{
            _strong_check(self);
            NSString *url = [[WLServerHelper sharedInstance] getShareUrlWithType:WLServerHelperShareTypeNutrition objectId:self.nutrition.classId];
            [ShareOnPlatformVC shareWithImageUrl:self.nutrition.images title:self.nutrition.title shareUrl:url];
        }];
    }
    return _sectionHeaderView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.scrollEnabled = NO;
        _webView.scalesPageToFit = YES;
        _weak(self);
        [_webView withBlockForDidFinishLoad:^(UIWebView *view) {
            _strong_check(self);
            [self performSelector:@selector(_resetWebViewHeight) withObject:nil afterDelay:0.1];
        }];
    }
    return _webView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        static NSString *const kCellIdentifier = @"MYCELL";
        _tableView = [[UITableView alloc] initWithFrame:self.tableHeaderView.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = [ProductInfoSectionHeaderView viewHeight];
        _tableView.tableHeaderView = self.tableHeaderView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 1;
        }];
        [_tableView withBlockForHeaderView:^UIView *(UITableView *view, NSInteger section) {
            _strong_check(self, nil);
            return self.sectionHeaderView;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            return self.webView.scrollView.contentSize.height ?: 300;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:self.webView];
            [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.webView.superview);
            }];
            if (!self.webView.request && self.nutrition.desc && self.nutrition.desc.length > 0) {
                [self.webView loadHTMLString:self.nutrition.desc baseURL:nil];
            }
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
