//
//  WLShoppingCartItemModel.h
//  Weilefood
//
//  Created by kelei on 15/8/17.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLOrderProductModel.h"

/// 购物车中的商品
@interface WLShoppingCartItemModel : WLOrderProductModel

/// 在购物车中已选中
@property (nonatomic, assign) BOOL selected;

@end



/// CoreData使用
@interface WLMOShoppingCartItem : WLMOOrderProduct
@property (nonatomic, strong) NSNumber *selected;
@end