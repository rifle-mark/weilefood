//
//  ActivityInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ActivityInfoVC.h"
#import "ActivityInfoHeaderView.h"
#import "ProductInfoSectionHeaderView.h"

#import "CommentListVC.h"
#import "LoginVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface ActivityInfoVC ()

@property (nonatomic, strong) UIView   *navView;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) ActivityInfoHeaderView       *tableHeaderView;
@property (nonatomic, strong) ProductInfoSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UIWebView                    *webView;
@property (nonatomic, strong) UITableView                  *tableView;
@property (nonatomic, strong) UIView                       *footerView;
@property (nonatomic, strong) UIButton                     *favoriteButton;
@property (nonatomic, strong) UIButton                     *buyButton;

@property (nonatomic, strong) WLActivityModel *activity;
@property (nonatomic, assign) CGFloat         headerHeight;

@end

static NSString *const kCellIdentifier = @"MYCELL";

@implementation ActivityInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithProduct:来实例化");
    self = [super init];
    return self;
}

- (instancetype)initWithActivity:(WLActivityModel *)activity {
    NSParameterAssert(activity);
    if (self = [super init]) {
        _headerHeight = [ActivityInfoHeaderView viewHeight];
        self.activity = activity;
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
    [[WLServerHelper sharedInstance] activity_getInfoWithActivityId:self.activity.activityId callback:^(WLApiInfoModel *apiInfo, WLActivityModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.activity = apiResult;
        [self _showData];
    }];
}

- (void)_showData {
    self.title = self.activity.title;
    
    self.tableHeaderView.imageUrl  = self.activity.banner;
    self.tableHeaderView.title     = self.activity.title;
    self.tableHeaderView.beginDate = self.activity.startDate;
    self.tableHeaderView.endDate   = self.activity.endDate;
    
    self.sectionHeaderView.actionCount = self.activity.actionCount;
    self.sectionHeaderView.commentCount = self.activity.commentCount;
    
    if (self.webView.superview) {
        [self.webView loadHTMLString:self.activity.content baseURL:nil];
    }
    
    self.buyButton.enabled = NO;
    if (self.activity.isJoin) {
        [self.buyButton setTitle:@"已参加" forState:UIControlStateNormal];
    }
    else {
        NSDate *now = [NSDate date];
        if ([now isEarlierThan:self.activity.startDate]) {
            [self.buyButton setTitle:@"未开始" forState:UIControlStateNormal];
        }
        else if ([now isLaterThan:self.activity.endDate]) {
            [self.buyButton setTitle:@"已结束" forState:UIControlStateNormal];
        }
        else {
            self.buyButton.enabled = YES;
            NSString *title = [NSString stringWithFormat:@"￥%.2f  我要参加", self.activity.price];
            [self.buyButton setTitle:title forState:UIControlStateNormal];
        }
    }
    self.buyButton.backgroundColor = self.buyButton.enabled ? k_COLOR_ORANGE : k_COLOR_DARKGRAY;
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

- (ActivityInfoHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [ActivityInfoHeaderView viewHeight] - 64);
        _tableHeaderView = [[ActivityInfoHeaderView alloc] initWithFrame:frame];
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
                [[WLServerHelper sharedInstance] action_addWithType:WLActionTypeActivity actType:WLActionActTypeApproval objectId:self.activity.activityId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    self.sectionHeaderView.actionCount = ++self.activity.actionCount;
                }];
            }];
        }];
        [_sectionHeaderView commentBlock:^{
            _strong_check(self);
            [CommentListVC showWithType:WLCommentTypeActivity refId:self.activity.activityId];
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
            if (!self.webView.request && self.activity.content && self.activity.content.length > 0) {
                [self.webView loadHTMLString:self.activity.content baseURL:nil];
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
                [[WLServerHelper sharedInstance] action_addWithType:WLActionTypeActivity actType:WLActionActTypeFavorite objectId:self.activity.activityId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    [self.favoriteButton setHighlighted:YES];
                }];
            }];
        }];
    }
    return _favoriteButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_buyButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        _weak(self);
        [_buyButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            DLog(@"");
        }];
    }
    return _buyButton;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
    [super setNavigationBarAlpha:navigationBarAlpha];
    self.navView.alpha = 1 - navigationBarAlpha;
}

@end
