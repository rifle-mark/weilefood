//
//  UserOrderListVC.m
//  Weilefood
//
//  Created by kelei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UserOrderListVC.h"
#import "OrderItemHeaderCell.h"
#import "OrderItemFooterCell.h"
#import "OrderItemDoctorCell.h"
#import "ShoppingCartProductCell.h"

#import "SelectPayPlatformVC.h"
#import "OrderInfoVC.h"
#import "SubmitUserHealthInfoVC.h"
#import "DoctorRecommendInfoVC.h"

#import "WLPayHelper.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface UserOrderListVC ()

@property (nonatomic, strong) UIView   *typeView;
@property (nonatomic, strong) UIButton *prouctButton;
@property (nonatomic, strong) UIButton *forwardBuyButton;
@property (nonatomic, strong) UIButton *activityButton;
@property (nonatomic, strong) UIButton *doctorButton;

@property (nonatomic, strong) UITableView *prouctTableView;
@property (nonatomic, strong) UITableView *forwardBuyTableView;
@property (nonatomic, strong) UITableView *activityTableView;
@property (nonatomic, strong) UITableView *doctorTableView;

@property (nonatomic, strong) NSArray *prouctList;
@property (nonatomic, strong) NSArray *forwardBuyList;
@property (nonatomic, strong) NSArray *activityList;
@property (nonatomic, strong) NSArray *doctorList;

@end

static NSInteger const kPageSize = 10;

static NSString *const kTextCancel         = @"已取消";
static NSString *const kTextPay            = @"付款";
static NSString *const kTextPaid           = @"已付款";
static NSString *const kTextShip           = @"待发货";
static NSString *const kTextConfirmReceipt = @"确认收货";
static NSString *const kTextCompleted      = @"已完成";

@implementation UserOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.view.backgroundColor = k_COLOR_WHITE;
    
    [self.view addSubview:self.typeView];
    [self.typeView addSubview:self.prouctButton];
    [self.typeView addSubview:self.forwardBuyButton];
    [self.typeView addSubview:self.activityButton];
    [self.typeView addSubview:self.doctorButton];
    [self.view addSubview:self.prouctTableView];
    [self.view addSubview:self.forwardBuyTableView];
    [self.view addSubview:self.activityTableView];
    [self.view addSubview:self.doctorTableView];
    
    [self _activateTypeWithButton:self.prouctButton];
    
    [self _addObserver];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.typeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0));
        make.height.equalTo(@37);
    }];
    [self.prouctButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.typeView).insets(UIEdgeInsetsMake(1, 0, 0, 0));
    }];
    [self.forwardBuyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.prouctButton);
        make.left.equalTo(self.prouctButton.mas_right);
    }];
    [self.activityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.forwardBuyButton);
        make.left.equalTo(self.forwardBuyButton.mas_right);
    }];
    [self.doctorButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.activityButton);
        make.left.equalTo(self.activityButton.mas_right);
        make.right.equalTo(self.typeView);
    }];
    
    [self.prouctTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.forwardBuyTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.prouctTableView);
    }];
    [self.activityTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.prouctTableView);
    }];
    [self.doctorTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.prouctTableView);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private mtehods

- (void)_addObserver {
    _weak(self);
    [self addObserverForNotificationName:kNotificationOrderInfoChanged usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if ([notification.object isKindOfClass:[NSNumber class]]) {
            long long orderId = [notification.object longLongValue];
            BOOL (^refreshTableView)(UITableView *, NSArray *) = ^(UITableView *tableView, NSArray *orderList){
                for (WLOrderModel *order in orderList) {
                    if (order.orderId == orderId) {
                        [tableView.header beginRefreshing];
                        return YES;
                    }
                }
                return NO;
            };
            refreshTableView(self.prouctTableView, self.prouctList)
            || refreshTableView(self.forwardBuyTableView, self.forwardBuyList)
            || refreshTableView(self.activityTableView, self.activityList)
            || refreshTableView(self.doctorTableView, self.doctorList);
        }
    }];
}

- (void)_loadProuctListWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLOrderModel *)[self.prouctList lastObject]).orderDate;
    [[WLServerHelper sharedInstance] order_getProductListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.prouctTableView.header.isRefreshing) {
            [self.prouctTableView.header endRefreshing];
        }
        if (self.prouctTableView.footer.isRefreshing) {
            [self.prouctTableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.prouctList = isLatest ? apiResult : [self.prouctList arrayByAddingObjectsFromArray:apiResult];
        [self.prouctTableView reloadData];
        self.prouctTableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

- (void)_loadForwardBuyListWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLOrderModel *)[self.forwardBuyList lastObject]).orderDate;
    [[WLServerHelper sharedInstance] order_getForwardbuyListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.forwardBuyTableView.header.isRefreshing) {
            [self.forwardBuyTableView.header endRefreshing];
        }
        if (self.forwardBuyTableView.footer.isRefreshing) {
            [self.forwardBuyTableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.forwardBuyList = isLatest ? apiResult : [self.forwardBuyList arrayByAddingObjectsFromArray:apiResult];
        [self.forwardBuyTableView reloadData];
        self.forwardBuyTableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

- (void)_loadActivityListWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLOrderModel *)[self.activityList lastObject]).orderDate;
    [[WLServerHelper sharedInstance] order_getActivityListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.activityTableView.header.isRefreshing) {
            [self.activityTableView.header endRefreshing];
        }
        if (self.activityTableView.footer.isRefreshing) {
            [self.activityTableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.activityList = isLatest ? apiResult : [self.activityList arrayByAddingObjectsFromArray:apiResult];
        [self.activityTableView reloadData];
        self.activityTableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

- (void)_loadDoctorListWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLOrderModel *)[self.doctorList lastObject]).orderDate;
    [[WLServerHelper sharedInstance] order_getDoctorListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.doctorTableView.header.isRefreshing) {
            [self.doctorTableView.header endRefreshing];
        }
        if (self.doctorTableView.footer.isRefreshing) {
            [self.doctorTableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.doctorList = isLatest ? apiResult : [self.doctorList arrayByAddingObjectsFromArray:apiResult];
        [self.doctorTableView reloadData];
        self.doctorTableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

- (void)_setTextColorWithChannelButton:(UIButton *)button isSelected:(BOOL)isSelected {
    [button setTitleColor:isSelected ? k_COLOR_THEME_NAVIGATIONBAR_TEXT : k_COLOR_TEAL forState:UIControlStateNormal];
}

- (void)_activateTypeWithButton:(UIButton *)button {
    [self _setTextColorWithChannelButton:self.prouctButton isSelected:self.prouctButton == button];
    [self _setTextColorWithChannelButton:self.forwardBuyButton isSelected:self.forwardBuyButton == button];
    [self _setTextColorWithChannelButton:self.activityButton isSelected:self.activityButton == button];
    [self _setTextColorWithChannelButton:self.doctorButton isSelected:self.doctorButton == button];
    
    self.prouctTableView.hidden     = self.prouctButton != button;
    self.forwardBuyTableView.hidden = self.forwardBuyButton != button;
    self.activityTableView.hidden   = self.activityButton != button;
    self.doctorTableView.hidden     = self.doctorButton != button;
    
    if (!self.prouctTableView.hidden && !self.prouctList) {
        [self.prouctTableView.header beginRefreshing];
    }
    if (!self.forwardBuyTableView.hidden && !self.forwardBuyList) {
        [self.forwardBuyTableView.header beginRefreshing];
    }
    if (!self.activityTableView.hidden && !self.activityList) {
        [self.activityTableView.header beginRefreshing];
    }
    if (!self.doctorTableView.hidden && !self.doctorList) {
        [self.doctorTableView.header beginRefreshing];
    }
}

- (void)_payWithOrder:(WLOrderModel *)order successBlock:(void (^)())successBlock {
    [SelectPayPlatformVC selectPayPlatformWithMoney:order.totalMoney selectBlock:^(SelectPayPlatformVC *vc, SelectPayPlatform selectPayPlatform) {
        [WLPayHelper payWithPlatform:(WLPayPlatform)selectPayPlatform orderNum:order.orderNum money:order.totalMoney callback:^(BOOL isSuccess, NSString *errorMessage) {
            if (isSuccess) {
                [vc dismissSelf];
                order.state = WLOrderStatePaid;
                GCBlockInvoke(successBlock);
            }
            else if (errorMessage && errorMessage.length > 0) {
                [MBProgressHUD showErrorWithMessage:errorMessage];
            }
        }];
    }];
}

- (void)_confirmWithOrder:(WLOrderModel *)order successBlock:(void (^)())successBlock {
    [MBProgressHUD showLoadingWithMessage:nil];
    [[WLServerHelper sharedInstance] order_confirmWithOrderId:order.orderId callback:^(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error) {
        [MBProgressHUD hideLoading];
        ServerHelperErrorHandle;
        order.state = WLOrderStateConfirmed;
        GCBlockInvoke(successBlock);
    }];
}

- (UIButton *)_createTypeButtonWithTitle:(NSString *)title {
    return ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
        v.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [v setTitle:title forState:UIControlStateNormal];
        [v addTarget:self action:@selector(_activateTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
        v;
    });
}

#pragma mark - private property methods

- (UIView *)typeView {
    if (!_typeView) {
        _typeView = [[UIView alloc] init];
        _typeView.backgroundColor = k_COLOR_MEDIUMTURQUOISE;
    }
    return _typeView;
}

- (UIButton *)prouctButton {
    if (!_prouctButton) {
        _prouctButton = [self _createTypeButtonWithTitle:@"集市"];
    }
    return _prouctButton;
}

- (UIButton *)forwardBuyButton {
    if (!_forwardBuyButton) {
        _forwardBuyButton = [self _createTypeButtonWithTitle:@"预购"];
    }
    return _forwardBuyButton;
}

- (UIButton *)activityButton {
    if (!_activityButton) {
        _activityButton = [self _createTypeButtonWithTitle:@"活动"];
    }
    return _activityButton;
}

- (UIButton *)doctorButton {
    if (!_doctorButton) {
        _doctorButton = [self _createTypeButtonWithTitle:@"营养师"];
    }
    return _doctorButton;
}

- (UITableView *)prouctTableView {
    if (!_prouctTableView) {
        _prouctTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _prouctTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_prouctTableView registerClass:[OrderItemHeaderCell class] forCellReuseIdentifier:[OrderItemHeaderCell reuseIdentifier]];
        [_prouctTableView registerClass:[ShoppingCartProductCell class] forCellReuseIdentifier:[ShoppingCartProductCell reuseIdentifier]];
        [_prouctTableView registerClass:[OrderItemFooterCell class] forCellReuseIdentifier:[OrderItemFooterCell reuseIdentifier]];
        _weak(self);
        [_prouctTableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadProuctListWithIsLatest:YES];
        }];
        [_prouctTableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadProuctListWithIsLatest:NO];
        }];
        [_prouctTableView withBlockForSectionNumber:^NSInteger(UITableView *view) {
            _strong_check(self, 0);
            return self.prouctList ? self.prouctList.count : 0;
        }];
        [_prouctTableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            WLOrderModel *order = self.prouctList[section];
            return order.orderDetail.count + 2;
        }];
        [_prouctTableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            if (path.row == 0) {
                return [OrderItemHeaderCell cellHeight];
            }
            WLOrderModel *order = self.prouctList[path.section];
            if (path.row > order.orderDetail.count) {
                return [OrderItemFooterCell cellHeight];
            }
            return [ShoppingCartProductCell cellHeight];
        }];
        [_prouctTableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            WLOrderModel *order = self.prouctList[path.section];
            if (path.row == 0) {
                OrderItemHeaderCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemHeaderCell reuseIdentifier] forIndexPath:path];
                cell.orderNum = order.orderNum;
                cell.date = order.orderDate;
                [cell clearRightControl];
                switch (order.state) {
                    case WLOrderStateCancel: {
                        [cell setRightLabelWithText:kTextCancel];
                        break;
                    }
                    case WLOrderStateUnpaid: {
                        [cell setRightButtonWithTitle:kTextPay actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.prouctTableView indexPathForCell:cell];
                            WLOrderModel *order = self.prouctList[path.section];
                            [self _payWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.prouctTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStatePaid: {
                        [cell setRightLabelWithText:kTextShip];
                        break;
                    }
                    case WLOrderStateShipped: {
                        [cell setRightButtonWithTitle:kTextConfirmReceipt actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.prouctTableView indexPathForCell:cell];
                            WLOrderModel *order = self.prouctList[path.section];
                            [self _confirmWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.prouctTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStateConfirmed: {
                        [cell setRightLabelWithText:kTextCompleted];
                        break;
                    }
                }
                return cell;
            }
            if (path.row > order.orderDetail.count) {
                OrderItemFooterCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemFooterCell reuseIdentifier] forIndexPath:path];
                cell.money = order.totalMoney;
                return cell;
            }
            ShoppingCartProductCell *cell = [view dequeueReusableCellWithIdentifier:[ShoppingCartProductCell reuseIdentifier] forIndexPath:path];
            WLOrderProductModel *item = order.orderDetail[path.row - 1];
            cell.imageUrl               = item.image;
            cell.name                   = item.title;
            cell.price                  = item.price;
            cell.quantity               = item.count;
            cell.displaySelectControl   = NO;
            cell.displayQuantityControl = NO;
            return cell;
        }];
        [_prouctTableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLOrderModel *order = self.prouctList[path.section];
            [self.navigationController pushViewController:[[OrderInfoVC alloc] initWithOrder:order] animated:YES];
        }];
    }
    return _prouctTableView;
}

- (UITableView *)forwardBuyTableView {
    if (!_forwardBuyTableView) {
        static NSInteger const kRowHeader  = 0;
        static NSInteger const kRowFooter  = 2;
        _forwardBuyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _forwardBuyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_forwardBuyTableView registerClass:[OrderItemHeaderCell class] forCellReuseIdentifier:[OrderItemHeaderCell reuseIdentifier]];
        [_forwardBuyTableView registerClass:[ShoppingCartProductCell class] forCellReuseIdentifier:[ShoppingCartProductCell reuseIdentifier]];
        [_forwardBuyTableView registerClass:[OrderItemFooterCell class] forCellReuseIdentifier:[OrderItemFooterCell reuseIdentifier]];
        _weak(self);
        [_forwardBuyTableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadForwardBuyListWithIsLatest:YES];
        }];
        [_forwardBuyTableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadForwardBuyListWithIsLatest:NO];
        }];
        [_forwardBuyTableView withBlockForSectionNumber:^NSInteger(UITableView *view) {
            _strong_check(self, 0);
            return self.forwardBuyList ? self.forwardBuyList.count : 0;
        }];
        [_forwardBuyTableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 3;
        }];
        [_forwardBuyTableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            if (path.row == kRowHeader) {
                return [OrderItemHeaderCell cellHeight];
            }
            if (path.row == kRowFooter) {
                return [OrderItemFooterCell cellHeight];
            }
            return [ShoppingCartProductCell cellHeight];
        }];
        [_forwardBuyTableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            WLOrderModel *order = self.forwardBuyList[path.section];
            if (path.row == kRowHeader) {
                OrderItemHeaderCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemHeaderCell reuseIdentifier] forIndexPath:path];
                cell.orderNum = order.orderNum;
                cell.date = order.orderDate;
                [cell clearRightControl];
                switch (order.state) {
                    case WLOrderStateCancel: {
                        [cell setRightLabelWithText:kTextCancel];
                        break;
                    }
                    case WLOrderStateUnpaid: {
                        [cell setRightButtonWithTitle:kTextPay actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.forwardBuyTableView indexPathForCell:cell];
                            WLOrderModel *order = self.forwardBuyList[path.section];
                            [self _payWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.forwardBuyTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStatePaid: {
                        [cell setRightLabelWithText:kTextShip];
                        break;
                    }
                    case WLOrderStateShipped: {
                        [cell setRightButtonWithTitle:kTextConfirmReceipt actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.forwardBuyTableView indexPathForCell:cell];
                            WLOrderModel *order = self.forwardBuyList[path.section];
                            [self _confirmWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.forwardBuyTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStateConfirmed: {
                        [cell setRightLabelWithText:kTextCompleted];
                        break;
                    }
                }
                return cell;
            }
            if (path.row == kRowFooter) {
                OrderItemFooterCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemFooterCell reuseIdentifier] forIndexPath:path];
                cell.money = order.totalMoney;
                return cell;
            }
            ShoppingCartProductCell *cell = [view dequeueReusableCellWithIdentifier:[ShoppingCartProductCell reuseIdentifier] forIndexPath:path];
            cell.imageUrl               = order.image;
            cell.name                   = order.title;
            cell.price                  = order.price;
            cell.quantity               = order.count;
            cell.displaySelectControl   = NO;
            cell.displayQuantityControl = NO;
            return cell;
        }];
        [_forwardBuyTableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLOrderModel *order = self.forwardBuyList[path.section];
            [self.navigationController pushViewController:[[OrderInfoVC alloc] initWithOrder:order] animated:YES];
        }];
    }
    return _forwardBuyTableView;
}

- (UITableView *)activityTableView {
    if (!_activityTableView) {
        static NSInteger const kRowHeader  = 0;
        static NSInteger const kRowFooter  = 2;
        static NSString *const kFooterCellReuseIdentifier = @"FOOTERCELL";
        _activityTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _activityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_activityTableView registerClass:[OrderItemHeaderCell class] forCellReuseIdentifier:[OrderItemHeaderCell reuseIdentifier]];
        [_activityTableView registerClass:[ShoppingCartProductCell class] forCellReuseIdentifier:[ShoppingCartProductCell reuseIdentifier]];
        [_activityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFooterCellReuseIdentifier];
        _weak(self);
        [_activityTableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadActivityListWithIsLatest:YES];
        }];
        [_activityTableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadActivityListWithIsLatest:NO];
        }];
        [_activityTableView withBlockForSectionNumber:^NSInteger(UITableView *view) {
            _strong_check(self, 0);
            return self.activityList ? self.activityList.count : 0;
        }];
        [_activityTableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 3;
        }];
        [_activityTableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            if (path.row == kRowHeader) {
                return [OrderItemHeaderCell cellHeight];
            }
            if (path.row == kRowFooter) {
                return 7;
            }
            return [ShoppingCartProductCell cellHeight];
        }];
        [_activityTableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            WLOrderModel *order = self.activityList[path.section];
            if (path.row == kRowHeader) {
                OrderItemHeaderCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemHeaderCell reuseIdentifier] forIndexPath:path];
                cell.orderNum = order.orderNum;
                cell.date = order.orderDate;
                [cell clearRightControl];
                switch (order.state) {
                    case WLOrderStateCancel: {
                        [cell setRightLabelWithText:kTextCancel];
                        break;
                    }
                    case WLOrderStateUnpaid: {
                        [cell setRightButtonWithTitle:kTextPay actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.activityTableView indexPathForCell:cell];
                            WLOrderModel *order = self.activityList[path.section];
                            [self _payWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.activityTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStatePaid: {
                        [cell setRightLabelWithText:@"待参加"];
                        break;
                    }
                    case WLOrderStateShipped: {
                        [cell setRightButtonWithTitle:@"确认参加" actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.activityTableView indexPathForCell:cell];
                            WLOrderModel *order = self.activityList[path.section];
                            [self _confirmWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.activityTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStateConfirmed: {
                        [cell setRightLabelWithText:kTextCompleted];
                        break;
                    }
                }
                return cell;
            }
            if (path.row == kRowFooter) {
                UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:kFooterCellReuseIdentifier forIndexPath:path];
                cell.backgroundColor = k_COLOR_LAVENDER;
                return cell;
            }
            ShoppingCartProductCell *cell = [view dequeueReusableCellWithIdentifier:[ShoppingCartProductCell reuseIdentifier] forIndexPath:path];
            cell.imageUrl               = order.image;
            cell.name                   = order.title;
            cell.price                  = order.totalMoney;
            cell.displaySelectControl   = NO;
            cell.displayQuantityControl = NO;
            return cell;
        }];
    }
    return _activityTableView;
}

- (UITableView *)doctorTableView {
    if (!_doctorTableView) {
        static NSInteger const kRowHeader  = 0;
        _doctorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _doctorTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_doctorTableView registerClass:[OrderItemHeaderCell class] forCellReuseIdentifier:[OrderItemHeaderCell reuseIdentifier]];
        [_doctorTableView registerClass:[OrderItemDoctorCell class] forCellReuseIdentifier:[OrderItemDoctorCell reuseIdentifier]];
        _weak(self);
        [_doctorTableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDoctorListWithIsLatest:YES];
        }];
        [_doctorTableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDoctorListWithIsLatest:NO];
        }];
        [_doctorTableView withBlockForSectionNumber:^NSInteger(UITableView *view) {
            _strong_check(self, 0);
            return self.doctorList ? self.doctorList.count : 0;
        }];
        [_doctorTableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 2;
        }];
        [_doctorTableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            if (path.row == kRowHeader) {
                return [OrderItemHeaderCell cellHeight];
            }
            return [OrderItemDoctorCell cellHeight];
        }];
        [_doctorTableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            WLOrderModel *order = self.doctorList[path.section];
            if (path.row == kRowHeader) {
                OrderItemHeaderCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemHeaderCell reuseIdentifier] forIndexPath:path];
                cell.orderNum = order.orderNum;
                cell.date = order.orderDate;
                [cell clearRightControl];
                switch (order.state) {
                    case WLOrderStateCancel: {
                        [cell setRightLabelWithText:kTextCancel];
                        break;
                    }
                    case WLOrderStateUnpaid: {
                        [cell setRightButtonWithTitle:kTextPay actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.doctorTableView indexPathForCell:cell];
                            WLOrderModel *order = self.doctorList[path.section];
                            [self _payWithOrder:order successBlock:^{
                                _strong_check(self);
                                [self.doctorTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }];
                        break;
                    }
                    case WLOrderStatePaid: {
                        [cell setRightButtonWithTitle:@"提交咨询" actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.doctorTableView indexPathForCell:cell];
                            WLOrderModel *order = self.doctorList[path.section];
                            [self.navigationController pushViewController:[[SubmitUserHealthInfoVC alloc] initWithOrderId:order.orderId] animated:YES];
                        }];
                        break;
                    }
                    case WLOrderStateShipped: {
                        [cell setRightLabelWithText:@"等待回复"];
                        break;
                    }
                    case WLOrderStateConfirmed: {
                        [cell setRightButtonWithTitle:@"查看回复" actionBlock:^(OrderItemHeaderCell *cell) {
                            _strong_check(self);
                            NSIndexPath *path = [self.doctorTableView indexPathForCell:cell];
                            WLOrderModel *order = self.doctorList[path.section];
                            [self.navigationController pushViewController:[[DoctorRecommendInfoVC alloc] initWithOrderId:order.orderId] animated:YES];
                        }];
                        break;
                    }
                }
                return cell;
            }
            OrderItemDoctorCell *cell = [view dequeueReusableCellWithIdentifier:[OrderItemDoctorCell reuseIdentifier] forIndexPath:path];
            cell.imageUrl    = order.images;
            cell.name        = order.trueName;
            cell.serviceName = order.title;
            cell.money       = order.totalMoney;
            return cell;
        }];
    }
    return _doctorTableView;
}

@end
