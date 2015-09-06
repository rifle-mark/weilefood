//
//  ForwardBuyInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ForwardBuyInfoVC.h"
#import "ForwardBuyInfoHeaderView.h"
#import "ProductInfoSectionHeaderView.h"

#import "CommentListVC.h"
#import "LoginVC.h"
#import "ShareOnPlatformVC.h"
#import "InputQuantityVC.h"
#import "OrderConfirmVC.h"

#import "WLDatabaseHelperHeader.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface ForwardBuyInfoVC ()

@property (nonatomic, strong) UIView   *navView;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) ForwardBuyInfoHeaderView     *tableHeaderView;
@property (nonatomic, strong) ProductInfoSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UIWebView                    *webView;
@property (nonatomic, strong) UITableView                  *tableView;
@property (nonatomic, strong) UIView                       *footerView;
@property (nonatomic, strong) UIButton                     *favoriteButton;
@property (nonatomic, strong) UIButton                     *buyButton;

@property (nonatomic, strong) WLForwardBuyModel *forwardBuy;
@property (nonatomic, assign) CGFloat           headerHeight;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation ForwardBuyInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithForwardBuy:来实例化");
    self = [super init];
    return self;
}

- (instancetype)initWithForwardBuy:(WLForwardBuyModel *)forwardBuy {
    NSParameterAssert(forwardBuy);
    if (self = [super init]) {
        _headerHeight = [ForwardBuyInfoHeaderView viewHeight];
        self.forwardBuy = forwardBuy;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_WHITE;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.backButton];
    
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.favoriteButton];
    [self.footerView addSubview:self.buyButton];
    
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
    [self.buyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favoriteButton.mas_right);
        make.right.equalTo(self.footerView);
        make.top.bottom.equalTo(self.favoriteButton);
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
    [[WLServerHelper sharedInstance] forwardBuy_getInfoWithForwardBuylId:self.forwardBuy.forwardBuyId callback:^(WLApiInfoModel *apiInfo, WLForwardBuyModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.forwardBuy = apiResult;
        [self _showData];
    }];
}

- (void)_showData {
    self.title = self.forwardBuy.title;
    
    NSMutableArray *images = [NSMutableArray array];
    for (WLPictureModel *pic in self.forwardBuy.pictures) {
        [images addObject:pic.picPath];
    }
    self.tableHeaderView.images    = images;
    self.tableHeaderView.title     = self.forwardBuy.title;
    self.tableHeaderView.number    = self.forwardBuy.count;
    self.tableHeaderView.price     = self.forwardBuy.price;
    self.tableHeaderView.beginDate = self.forwardBuy.startDate;
    self.tableHeaderView.endDate   = self.forwardBuy.endDate;
    self.tableHeaderView.state     = self.forwardBuy.state;
    
    self.sectionHeaderView.hasAction = self.forwardBuy.isLike;
    self.sectionHeaderView.actionCount = self.forwardBuy.actionCount;
    self.sectionHeaderView.commentCount = self.forwardBuy.commentCount;
    
    if (self.webView.superview) {
        [self.webView loadHTMLString:self.forwardBuy.desc baseURL:nil];
    }
    
    self.favoriteButton.highlighted = self.forwardBuy.isFav;
}

- (void)_resetWebViewHeight {
    if (self.webView.superview) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - private property methods

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

- (ForwardBuyInfoHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [ForwardBuyInfoHeaderView viewHeight] - 64);
        _tableHeaderView = [[ForwardBuyInfoHeaderView alloc] initWithFrame:frame];
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
                [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeApproval objectType:WLActionTypeForwardBuy objectId:self.forwardBuy.forwardBuyId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    self.forwardBuy.actionCount++;
                    self.forwardBuy.isLike = YES;
                    [self _showData];
                }];
            }];
        }];
        [_sectionHeaderView commentBlock:^{
            _strong_check(self);
            [CommentListVC showWithType:WLCommentTypeForwardBuy refId:self.forwardBuy.forwardBuyId dismissBlock:^(NSInteger addCount) {
                _strong_check(self);
                self.forwardBuy.commentCount += addCount;
                [self _showData];
            }];
        }];
        [_sectionHeaderView shareBlock:^{
            _strong_check(self);
            NSString *url = [[WLServerHelper sharedInstance] getShareUrlWithType:WLServerHelperShareTypeForwardBuy objectId:self.forwardBuy.forwardBuyId];
            [ShareOnPlatformVC shareWithImageUrl:self.forwardBuy.banner title:self.forwardBuy.title shareUrl:url];
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
        _tableView = [[UITableView alloc] initWithFrame:self.tableHeaderView.frame style:UITableViewStylePlain];
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
            if (!self.webView.request && self.forwardBuy.desc && self.forwardBuy.desc.length > 0) {
                [self.webView loadHTMLString:self.forwardBuy.desc baseURL:nil];
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
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                if (self.forwardBuy.isFav) {
                    [[WLServerHelper sharedInstance] action_deleteFavoriteWithObjectType:WLActionTypeForwardBuy objectId:self.forwardBuy.forwardBuyId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                        _strong_check(self);
                        ServerHelperErrorHandle;
                        self.forwardBuy.isFav = NO;
                        [self _showData];
                    }];
                }
                else {
                    [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeFavorite objectType:WLActionTypeForwardBuy objectId:self.forwardBuy.forwardBuyId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                        _strong_check(self);
                        ServerHelperErrorHandle;
                        self.forwardBuy.isFav = YES;
                        [self _showData];
                    }];
                }
            }];
        }];
    }
    return _favoriteButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = k_COLOR_ORANGE;
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_buyButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        _weak(self);
        [_buyButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                [InputQuantityVC inputQuantityWithEnterBlock:^(InputQuantityVC *inputQuantityVC, NSInteger quantity) {
                    [inputQuantityVC dismissSelfWithCompletedBlock:^{
                        _strong_check(self);
                        WLOrderProductModel *product = [[WLOrderProductModel alloc] init];
                        product.type  = WLOrderProductTypeForwardBuy;
                        product.refId = self.forwardBuy.forwardBuyId;
                        product.count = quantity;
                        product.price = self.forwardBuy.price;
                        product.title = self.forwardBuy.title;
                        product.image = self.forwardBuy.banner;
                        [self.navigationController pushViewController:[[OrderConfirmVC alloc] initWithProductList:@[product] needAddress:YES] animated:YES];
                    }];
                }];
            }];
        }];
    }
    return _buyButton;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
    [super setNavigationBarAlpha:navigationBarAlpha];
    self.navView.alpha = 1 - navigationBarAlpha;
}

@end
