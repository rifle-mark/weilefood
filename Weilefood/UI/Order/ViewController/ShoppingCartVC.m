//
//  ShoppingCartVC.m
//  Weilefood
//
//  Created by kelei on 15/8/25.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "ShoppingCartProductCell.h"

#import "OrderConfirmVC.h"

#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

@interface ShoppingCartVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView      *footerView;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UIButton    *selectButton;
@property (nonatomic, strong) UILabel     *moneyLabel;
@property (nonatomic, strong) UIButton    *buyButton;

@property (nonatomic, strong) NSArray *productList;

@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = k_COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [self _createDeleteItem]];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.lineView];
    [self.footerView addSubview:self.selectButton];
    [self.footerView addSubview:self.moneyLabel];
    [self.footerView addSubview:self.buyButton];
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
    [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectButton.superview).offset(12);
        make.centerY.equalTo(@0);
        make.width.height.equalTo(@30);
    }];
    [self.moneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectButton.mas_right);
        make.right.equalTo(self.buyButton.mas_left);
        make.centerY.equalTo(@0);
    }];
    [self.buyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.buyButton.superview);
        make.top.equalTo(self.lineView.mas_bottom);
        make.width.equalTo(@122);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.productList = [WLDatabaseHelper shoppingCart_findItems];
    [self.tableView reloadData];
    [self _resetSelectStatusAndMoney];
}

#pragma mark - private methods

- (UIBarButtonItem *)_createDeleteItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoppingcart_btn_delete"] style:UIBarButtonItemStyleBordered target:self action:@selector(_deleteClick)];
}

- (void)_deleteClick {
    NSInteger count = 0;
    for (WLShoppingCartItemModel *item in self.productList) {
        if (item.selected) {
            count++;
        }
    }
    
    if (count > 0) {
        NSString *title = [NSString stringWithFormat:@"确定要删除这%ld个商品吗？", (long)count];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    }
    else {
        [MBProgressHUD showErrorWithMessage:@"请选中要删除的商品"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        for (WLShoppingCartItemModel *item in self.productList) {
            if (item.selected) {
                [WLDatabaseHelper shoppingCart_delete:item];
            }
        }
        self.productList = [WLDatabaseHelper shoppingCart_findItems];
        [self.tableView reloadData];
        [self _resetSelectStatusAndMoney];
    }
}

- (void)_resetSelectStatusAndMoney {
    CGFloat money = 0;
    BOOL isSelectAll = YES;
    for (WLShoppingCartItemModel *item in self.productList) {
        if (item.selected) {
            money += item.count * item.price;
        }
        else {
            isSelectAll = NO;
        }
    }
    self.selectButton.selected = isSelectAll;
    
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f", money];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"总计:" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:moneyStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}]];
    self.moneyLabel.attributedText = attributedText;
}

#pragma mark - private property methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = [ShoppingCartProductCell cellHeight];
        [_tableView registerClass:[ShoppingCartProductCell class] forCellReuseIdentifier:[ShoppingCartProductCell reuseIdentifier]];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.productList ? self.productList.count : 0;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            ShoppingCartProductCell *cell = [view dequeueReusableCellWithIdentifier:[ShoppingCartProductCell reuseIdentifier] forIndexPath:path];
            WLShoppingCartItemModel *item = self.productList[path.row];
            cell.imageUrl   = item.image;
            cell.isSelected = item.selected;
            cell.name       = item.title;
            cell.price      = item.price;
            cell.quantity   = item.count;
            [cell quantityChangedBlock:^(ShoppingCartProductCell *cell) {
                _strong_check(self);
                NSIndexPath *path = [self.tableView indexPathForCell:cell];
                WLShoppingCartItemModel *item = self.productList[path.row];
                item.count = cell.quantity;
                [WLDatabaseHelper shoppingCart_saveItem:item];
                [self _resetSelectStatusAndMoney];
            }];
            [cell isSelectedChangedBlock:^(ShoppingCartProductCell *cell) {
                _strong_check(self);
                NSIndexPath *path = [self.tableView indexPathForCell:cell];
                WLShoppingCartItemModel *item = self.productList[path.row];
                item.selected = cell.isSelected;
                [WLDatabaseHelper shoppingCart_saveItem:item];
                [self _resetSelectStatusAndMoney];
            }];
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

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"shoppingcart_btn_select_n"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"shoppingcart_btn_select_h"] forState:UIControlStateSelected];
        _weak(self);
        [_selectButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectButton.selected = !self.selectButton.selected;
            for (WLShoppingCartItemModel *item in self.productList) {
                item.selected = self.selectButton.selected;
                [WLDatabaseHelper shoppingCart_saveItem:item];
            }
            [self.tableView reloadData];
            [self _resetSelectStatusAndMoney];
        }];
    }
    return _selectButton;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = k_COLOR_LUST;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
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
            _strong_check(self);
            NSMutableArray *productList = [NSMutableArray array];
            for (WLShoppingCartItemModel *item in self.productList) {
                if (item.selected) {
                    [productList addObject:item];
                }
            }
            if (productList.count <= 0) {
                [MBProgressHUD showErrorWithMessage:@"请选择要购买的商品"];
                return;
            }
            [self.navigationController pushViewController:[[OrderConfirmVC alloc] initWithProductList:productList needAddress:YES] animated:YES];
        }];
    }
    return _buyButton;
}

@end
