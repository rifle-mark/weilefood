//
//  ShoppingCartProductCell.h
//  Weilefood
//
//  Created by kelei on 15/8/25.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartProductCell;

typedef void (^ShoppingCartProductCellStdBlock)(ShoppingCartProductCell *cell);

/// 购物车 - 商品Cell
@interface ShoppingCartProductCell : UITableViewCell

/// 图片链接地址
@property (nonatomic, copy) NSString *imageUrl;
/// 名称
@property (nonatomic, copy) NSString *name;
/// 价格
@property (nonatomic, assign) CGFloat price;
/// 数量
@property (nonatomic, assign) NSInteger quantity;
/// 是否选中
@property (nonatomic, assign) BOOL isSelected;
/// 是否显示 选中 组件。默认YES
@property (nonatomic, assign) BOOL displaySelectControl;
/// 是否显示 改变数量 组件。默认YES
@property (nonatomic, assign) BOOL displayQuantityControl;

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight;
+ (NSString *)reuseIdentifier;

/// 回调：用户改变了数量
- (void)quantityChangedBlock:(ShoppingCartProductCellStdBlock)block;

/// 回调：用户改变了选中状态
- (void)isSelectedChangedBlock:(ShoppingCartProductCellStdBlock)block;

@end
