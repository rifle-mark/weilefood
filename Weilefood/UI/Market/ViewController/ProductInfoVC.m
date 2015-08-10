//
//  ProductInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ProductInfoVC.h"
#import "ProductTableHeaderView.h"
#import "ProductSectionHeaderView.h"

#import "CommentListVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface ProductInfoVC ()

@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, strong) ProductTableHeaderView   *tableHeaderView;
@property (nonatomic, strong) ProductSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UIWebView                *webView;
@property (nonatomic, strong) UITableView              *tableView;
@property (nonatomic, strong) UIView                   *footerView;
@property (nonatomic, strong) UIButton                 *favoriteButton;
@property (nonatomic, strong) UIButton                 *addCartButton;
@property (nonatomic, strong) UIButton                 *buyButton;

@property (nonatomic, strong) WLProductModel *product;
@property (nonatomic, assign) CGFloat        navBarColorAlpha;
@property (nonatomic, assign) CGFloat        headerHeight;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation ProductInfoVC

- (id)init {
    NSAssert(_product, @"请使用initWithProduct:来实例化");
    self = [super init];
    return self;
}

- (instancetype)initWithProduct:(WLProductModel *)product {
    NSParameterAssert(product);
    if (self = [super init]) {
        _navBarColorAlpha = -1;
        _headerHeight = [ProductTableHeaderView viewHeight];
        self.product = product;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_WHITE;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.favoriteButton];
    [self.footerView addSubview:self.addCartButton];
    [self.footerView addSubview:self.buyButton];
    
    [self _showData];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.footerView.mas_top).offset(1);
    }];
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    [self.favoriteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.footerView);
        make.top.equalTo(@1);
        make.width.equalTo(@64);
    }];
    [self.addCartButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favoriteButton.mas_right);
        make.top.bottom.equalTo(self.favoriteButton);
        make.width.equalTo(self.buyButton);
    }];
    [self.buyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addCartButton.mas_right);
        make.right.equalTo(self.footerView);
        make.top.bottom.equalTo(self.favoriteButton);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar addSubview:self.statusBarView];
    
    if (self.navBarColorAlpha == -1) {
        self.navBarColorAlpha = 0;
    }
    else {
        /*
         这段解决：
         iOS8中进入此界面后，从屏幕左边缘往右滑一点，再松开，navigationBar显示了背景色的问题
         */
        self.navBarColorAlpha += 0.01;
        self.navBarColorAlpha -= 0.01;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.headerHeight = V_H_(self.tableHeaderView);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.statusBarView removeFromSuperview];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.backgroundColor = nil;
    self.navigationController.navigationBar.titleTextAttributes = nil;
}

#pragma mark - private methods

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] product_getInfoWithProductId:self.product.productId callback:^(WLApiInfoModel *apiInfo, WLProductModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.product = apiResult;
        [self _showData];
    }];
}

- (void)_showData {
    NSMutableArray *images = [NSMutableArray array];
    for (WLProductPictureModel *pic in self.product.pictures) {
        [images addObject:pic.picPath];
    }
    self.tableHeaderView.images = images;
    self.tableHeaderView.title  = self.product.productName;
    self.tableHeaderView.number = self.product.count;
    self.tableHeaderView.price  = self.product.price;
    
    self.sectionHeaderView.actionCount = self.product.actionCount;
    self.sectionHeaderView.commentCount = self.product.commentCount;
    
    if (self.webView.superview) {
        [self.webView loadHTMLString:self.product.desc baseURL:nil];
    }
}

- (void)_resetWebViewHeight {
    if (self.webView.superview) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - private property methods

- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    }
    return _statusBarView;
}

- (ProductTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [ProductTableHeaderView viewHeight] - 64);
        _tableHeaderView = [[ProductTableHeaderView alloc] initWithFrame:frame];
        _tableHeaderView.backgroundColor = k_COLOR_WHITE;
    }
    return _tableHeaderView;
}

- (ProductSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[ProductSectionHeaderView alloc] init];
        _sectionHeaderView.backgroundColor = k_COLOR_WHITE;
        _weak(self);
        [_sectionHeaderView actionBlock:^{
            _strong_check(self);
            [[WLServerHelper sharedInstance] action_addWithType:WLActionTypeProduct actType:WLActionActTypeApproval objectId:self.product.productId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                self.product.actionCount++;
                self.sectionHeaderView.actionCount = self.product.actionCount;
            }];
        }];
        [_sectionHeaderView commentBlock:^{
            _strong_check(self);
            CommentListVC *vc = [[CommentListVC alloc] initWithType:WLCommentTypeProduct refId:self.product.productId];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:nc animated:YES completion:nil];
        }];
        [_sectionHeaderView shareBlock:^{
            _strong_check(self);
            DLog(@"");
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = [ProductSectionHeaderView viewHeight];
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
            if (!self.webView.request && self.product.desc && self.product.desc.length > 0) {
                [self.webView loadHTMLString:self.product.desc baseURL:nil];
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
            self.navBarColorAlpha = alpha;
        }];
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = [k_COLOR_MAROOM colorWithAlphaComponent:0.4];
    }
    return _footerView;
}

- (UIButton *)favoriteButton {
    if (!_favoriteButton) {
        _favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _favoriteButton.backgroundColor = k_COLOR_WHITESMOKE;
        _favoriteButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_favoriteButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_favoriteButton setTitleColor:k_COLOR_MAROOM forState:UIControlStateNormal];
        [_favoriteButton setTitleColor:k_COLOR_ORANGE forState:UIControlStateHighlighted];
        [_favoriteButton setImage:[UIImage imageNamed:@"productinfo_icon_favorite_n"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"productinfo_icon_favorite_h"] forState:UIControlStateHighlighted];
        [_favoriteButton setImageToTop];
        _weak(self);
        [_favoriteButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [[WLServerHelper sharedInstance] action_addWithType:WLActionTypeProduct actType:WLActionActTypeFavorite objectId:self.product.productId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                _strong_check(self);
                ServerHelperErrorHandle;
                [self.favoriteButton setHighlighted:YES];
            }];
        }];
    }
    return _favoriteButton;
}

- (UIButton *)addCartButton {
    if (!_addCartButton) {
        _addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCartButton.backgroundColor = k_COLOR_TURQUOISE;
        _addCartButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_addCartButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    return _addCartButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = k_COLOR_ORANGE;
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_buyButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    return _buyButton;
}

- (void)setNavBarColorAlpha:(CGFloat)navBarColorAlpha {
    if (_navBarColorAlpha == navBarColorAlpha) {
        return;
    }
    _navBarColorAlpha = navBarColorAlpha;
    self.statusBarView.backgroundColor = [k_COLOR_THEME_NAVIGATIONBAR colorWithAlphaComponent:_navBarColorAlpha];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [k_COLOR_WHITE colorWithAlphaComponent:_navBarColorAlpha]};
    self.navigationController.navigationBar.backgroundColor = self.statusBarView.backgroundColor;
}

@end
