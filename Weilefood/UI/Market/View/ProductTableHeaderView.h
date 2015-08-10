//
//  ProductTableHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/8/6.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 商品详情界面 - 头部分
@interface ProductTableHeaderView : UIView

/// 商品图集URL<NSString>
@property (nonatomic, strong) NSArray   *images;
/// 商品名称
@property (nonatomic, copy  ) NSString  *title;
/// 剩余数量
@property (nonatomic, assign) NSInteger number;
/// 价格
@property (nonatomic, assign) CGFloat   price;

/**
 *  展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
