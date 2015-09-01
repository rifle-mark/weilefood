//
//  OrderConfirmVC.m
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderConfirmVC.h"
#import "InputAddressView.h"
#import "ShoppingCartProductCell.h"

#import "OrderInfoVC.h"

#import "WLDatabaseHelperHeader.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface OrderConfirmVC ()

@property (nonatomic, strong) InputAddressView *addressView;
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) UIView           *footerView;
@property (nonatomic, strong) UIView           *lineView;
@property (nonatomic, strong) UILabel          *moneyLabel;
@property (nonatomic, strong) UIButton         *submitButton;

@property (nonatomic, strong) NSArray *productList;
@property (nonatomic, assign) BOOL isDidAppear;

@end

static NSString *const kOrderAddressKeyName    = @"OrderAddressKeyName";
static NSString *const kOrderAddressKeyPhone   = @"OrderAddressKeyPhone";
static NSString *const kOrderAddressKeyCity    = @"OrderAddressKeyCity";
static NSString *const kOrderAddressKeyAddress = @"OrderAddressKeyAddress";
static NSString *const kOrderAddressKeyZipCode = @"OrderAddressKeyZipCode";

@implementation OrderConfirmVC

- (id)init {
    NSAssert(NO, @"请输入initWithProductList:方法初始化本界面");
    return nil;
}

- (instancetype)initWithProductList:(NSArray *)productList {
    NSParameterAssert(productList);
    if (self = [super init]) {
        _productList = productList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = k_COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.lineView];
    [self.footerView addSubview:self.moneyLabel];
    [self.footerView addSubview:self.submitButton];
    
    [self _resetMoneyText];
    [self.tableView handleKeyboard];
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
        make.right.equalTo(self.submitButton.mas_left);
        make.centerY.equalTo(@0);
    }];
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.submitButton.superview);
        make.top.equalTo(self.lineView.mas_bottom);
        make.width.equalTo(@122);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methods

- (void)_resetMoneyText {
    CGFloat money = 0;
    for (WLOrderProductModel *item in self.productList) {
        money += item.price * item.count;
    }
    
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f", money];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"总计:" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:moneyStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    self.moneyLabel.attributedText = attributedText;
}

- (void)_saveAddress {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.addressView.name forKey:kOrderAddressKeyName];
    [userDefault setObject:self.addressView.phone forKey:kOrderAddressKeyPhone];
    [userDefault setObject:self.addressView.city forKey:kOrderAddressKeyCity];
    [userDefault setObject:self.addressView.address forKey:kOrderAddressKeyAddress];
    [userDefault setObject:self.addressView.zipCode forKey:kOrderAddressKeyZipCode];
    [userDefault synchronize];
}

#pragma mark - private property methods

- (InputAddressView *)addressView {
    if (!_addressView) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [InputAddressView viewHeight]);
        _addressView = [[InputAddressView alloc] initWithFrame:frame];
        _addressView.name    = [userDefault objectForKey:kOrderAddressKeyName];
        _addressView.phone   = [userDefault objectForKey:kOrderAddressKeyPhone];
        _addressView.city    = [userDefault objectForKey:kOrderAddressKeyCity];
        _addressView.address = [userDefault objectForKey:kOrderAddressKeyAddress];
        _addressView.zipCode = [userDefault objectForKey:kOrderAddressKeyZipCode];
    }
    return _addressView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        // 使用头addressView.frame
        // 是因为_tableView.tableHeaderView=self.addressView时会设置self.addressView.widht=tableView.width
        // 这会导航addressView中的约束错误
        _tableView = [[UITableView alloc] initWithFrame:self.addressView.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.addressView;
        _tableView.rowHeight = [ShoppingCartProductCell cellHeight];
        [_tableView registerClass:[ShoppingCartProductCell class] forCellReuseIdentifier:[ShoppingCartProductCell reuseIdentifier]];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return (self.productList ? self.productList.count : 0);
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            ShoppingCartProductCell *cell = [view dequeueReusableCellWithIdentifier:[ShoppingCartProductCell reuseIdentifier] forIndexPath:path];
            WLOrderProductModel *item = self.productList[path.row];
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

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = k_COLOR_ORANGE;
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitButton setTitleColor:k_COLOR_WHITE forState:UIControlStateNormal];
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        _weak(self);
        [_submitButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            if (![self.addressView checkInput]) {
                return;
            }
            [self _saveAddress];
            
            if (self.productList.count <= 0) {
                [MBProgressHUD showErrorWithMessage:@"缺少商品"];
                return;
            }
            
            WLOrderAddressModel *address = [[WLOrderAddressModel alloc] init];
            address.userName = self.addressView.name;
            address.tel = self.addressView.phone;
            address.address = [self.addressView.city stringByAppendingString:self.addressView.address];
            address.postCode = self.addressView.zipCode;
            
            [MBProgressHUD showLoadingWithMessage:nil];
            [[WLServerHelper sharedInstance] order_createWithAddress:address productList:self.productList callback:^(WLApiInfoModel *apiInfo, WLOrderModel *apiResult, NSError *error) {
                [MBProgressHUD hideLoading];
                _strong_check(self);
                ServerHelperErrorHandle;
                // 订单中的商品从购物车中删除
                for (WLOrderProductModel *item in self.productList) {
                    [WLDatabaseHelper shoppingCart_deleteWithType:item.type refId:item.refId];
                }
                [self.navigationController pushViewController:[[OrderInfoVC alloc] initWithOrder:apiResult] animated:NO];
            }];
        }];
    }
    return _submitButton;
}

@end
