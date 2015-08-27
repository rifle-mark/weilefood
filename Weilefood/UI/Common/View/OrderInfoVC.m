//
//  OrderInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderInfoVC.h"
#import "OrderNumberAndDateView.h"
#import "OrderInfoHeaderCell.h"
#import "ShoppingCartProductCell.h"

#import "OrderConfirmVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface OrderInfoVC ()

@property (nonatomic, strong) OrderNumberAndDateView *numberAndDateView;
@property (nonatomic, strong) UITableView            *tableView;
@property (nonatomic, strong) UIView                 *footerView;
@property (nonatomic, strong) UIView                 *lineView;
@property (nonatomic, strong) UILabel                *moneyLabel;
@property (nonatomic, strong) UIButton               *payButton;

// 有两个订单信息属性是因为
// 列表上的订单信息和详情接口返回的订单信息互不冗余
// 只有列表上的订单信息加上订单详情信息才是完整的订单信息。
@property (nonatomic, strong) WLOrderModel *orderBaseInfo;
@property (nonatomic, strong) WLOrderModel *orderMoreInfo;

@end

@implementation OrderInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithOrder:方法初始化本界面");
    return nil;
}

- (instancetype)initWithOrder:(WLOrderModel *)order {
    if (self = [super init]) {
        _orderBaseInfo = order;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = k_COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.lineView];
    [self.footerView addSubview:self.moneyLabel];
    [self.footerView addSubview:self.payButton];
    
    [self _showData];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.tableView.superview);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
    
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.footerView.superview);
        make.height.equalTo(@49);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.lineView.superview);
        make.height.equalTo(@k1pxWidth);
    }];
    [self.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLabel.superview).offset(11);
        make.right.equalTo(self.payButton.mas_left);
        make.centerY.equalTo(@0);
    }];
    [self.payButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.payButton.superview);
        make.top.equalTo(self.lineView.mas_bottom);
        make.width.equalTo(@122);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (![parent isEqual:self.parentViewController]) {
        // 用户执行的后退操作
        // 如果上个界面是“确认订单”，那就回到再上一个界面，不能回到“确认订单”
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        if ([viewControllers.lastObject isKindOfClass:[OrderConfirmVC class]]
            && viewControllers.count >= 2) {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

#pragma mark - private methods

- (void)_showData {
    self.numberAndDateView.orderNum = self.orderBaseInfo.orderNum;
    self.numberAndDateView.date = self.orderBaseInfo.orderDate;
    [self.tableView reloadData];
    
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f", self.orderBaseInfo.totalMoney];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"总计:" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:moneyStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    self.moneyLabel.attributedText = attributedText;
    
    self.payButton.hidden = self.orderBaseInfo.state != WLOrderStateUnpaid;
}

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] order_getDetailWithOrderId:self.orderBaseInfo.orderId callback:^(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.orderMoreInfo = apiResult;
        [self _showData];
    }];
}

#pragma mark - private property methods

- (OrderNumberAndDateView *)numberAndDateView {
    if (!_numberAndDateView) {
        _numberAndDateView = [[OrderNumberAndDateView alloc] init];
        _numberAndDateView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [OrderNumberAndDateView viewHeight]);
    }
    return _numberAndDateView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = self.numberAndDateView.frame;
        // 使用头addressView.frame
        // 是因为_tableView.tableHeaderView=self.addressView时会设置self.addressView.widht=tableView.width
        // 这会导航addressView中的约束错误
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.numberAndDateView;
        [_tableView registerClass:[OrderInfoHeaderCell class] forCellReuseIdentifier:[OrderInfoHeaderCell reuseIdentifier]];
        [_tableView registerClass:[ShoppingCartProductCell class] forCellReuseIdentifier:[ShoppingCartProductCell reuseIdentifier]];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return (self.orderMoreInfo && self.orderMoreInfo.orderDetail ? self.orderMoreInfo.orderDetail.count : 0) + 1;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self, 0);
            if (path.row == 0) {
                NSString *address = self.orderMoreInfo.orderAddress.address;
                return [OrderInfoHeaderCell cellHeightWithAddress:address isShowExpressInfo:self.orderBaseInfo.state == WLOrderStateShipped];
            }
            return [ShoppingCartProductCell cellHeight];
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            if (path.row == 0) {
                OrderInfoHeaderCell *cell = [view dequeueReusableCellWithIdentifier:[OrderInfoHeaderCell reuseIdentifier] forIndexPath:path];
                cell.name = self.orderMoreInfo.orderAddress.userName;
                cell.phone = self.orderMoreInfo.orderAddress.tel;
                cell.address = self.orderMoreInfo.orderAddress.address;
                cell.zipCode = self.orderMoreInfo.orderAddress.postCode;
                cell.isShowExpressInfo = self.orderBaseInfo.state == WLOrderStateShipped;
                cell.expressName = self.orderMoreInfo.deliver.expressName;
                cell.expressNum = self.orderMoreInfo.deliver.expressNum;
                return cell;
            }
            ShoppingCartProductCell *cell = [view dequeueReusableCellWithIdentifier:[ShoppingCartProductCell reuseIdentifier] forIndexPath:path];
            WLOrderProductModel *item = self.orderMoreInfo.orderDetail[path.row - 1];
            cell.imageUrl               = item.image;
            cell.name                   = item.title;
            cell.price                  = item.price;
            cell.quantity               = item.count;
            cell.displaySelectControl   = NO;
            cell.displayQuantityControl = NO;
            return cell;
        }];
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _footerView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = k_COLOR_LUST;
    }
    return _moneyLabel;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.backgroundColor = k_COLOR_ORANGE;
        _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_payButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_payButton setTitle:@"付款" forState:UIControlStateNormal];
        _weak(self);
        [_payButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            DLog(@"");
        }];
    }
    return _payButton;
}

@end