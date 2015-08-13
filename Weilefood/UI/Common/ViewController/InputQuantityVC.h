//
//  InputQuantityVC.h
//  Weilefood
//
//  Created by kelei on 15/8/14.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^InputQuantitySuccessBlock)(NSInteger quantity);

/// 购买商品时的输入数量界面
@interface InputQuantityVC : UIViewController

/**
 *  显示界面并指定确定输入后的回调
 *
 *  @param successBlock 回调
 */
+ (void)inputQuantityWithSuccessBlock:(InputQuantitySuccessBlock)successBlock;

@end
