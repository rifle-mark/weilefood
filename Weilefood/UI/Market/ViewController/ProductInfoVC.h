//
//  ProductInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLProductModel;

/// 市集商品详情页
@interface ProductInfoVC : UIViewController

/**
 *  通过WLProductModel实例化商品详情界面
 *
 *  @param product
 *
 *  @return
 */
- (instancetype)initWithProduct:(WLProductModel *)product;

@end
