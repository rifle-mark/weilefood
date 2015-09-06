//
//  InputQuantityVC.h
//  Weilefood
//
//  Created by kelei on 15/8/14.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputQuantityVC;

typedef void (^EnterQuantityBlock)(InputQuantityVC *inputQuantityVC, NSInteger quantity);

/// 购买商品时的输入数量界面
@interface InputQuantityVC : UIViewController

/**
 *  显示界面
 *
 *  @param enterBlock 回调：用户点击了确定
 */
+ (void)inputQuantityWithEnterBlock:(EnterQuantityBlock)enterBlock;

/**
 *  关闭自己
 */
- (void)dismissSelf;
- (void)dismissSelfWithCompletedBlock:(void(^)())completedBlock;

@end
