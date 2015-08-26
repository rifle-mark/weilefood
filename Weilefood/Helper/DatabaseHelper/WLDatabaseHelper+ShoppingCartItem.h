//
//  WLDatabaseHelper+ShoppingCartItem.h
//  Weilefood
//
//  Created by kelei on 15/8/17.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDatabaseHelper.h"

@class WLShoppingCartItemModel;

typedef NS_ENUM(NSInteger, WLOrderProductType);

/// 购物车相关
@interface WLDatabaseHelper (ShoppingCartItem)

/// 查询购物车中的商品列表<WLShoppingCartItemModel>
+ (NSArray *)shoppingCart_findItems;

/// 查询指定商品在购物中的信息
+ (WLShoppingCartItemModel *)shoppingCart_findItemWithType:(WLOrderProductType)type refId:(NSUInteger)refId;

/// 增加或修改购物车中的商品
+ (void)shoppingCart_saveItem:(WLShoppingCartItemModel *)model;

/// 删除购物车中某个商品
+ (void)shoppingCart_delete:(WLShoppingCartItemModel *)model;
+ (void)shoppingCart_deleteWithType:(WLOrderProductType)type refId:(NSUInteger)refId;

/// 删除购物车中所有商品
+ (void)shoppingCart_deleteAll;

@end
