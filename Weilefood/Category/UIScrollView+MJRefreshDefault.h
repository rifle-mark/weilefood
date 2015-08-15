//
//  UIScrollView+MJRefreshDefault.h
//  Weilefood
//
//  Created by kelei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 封装MJRefresh的使用。1、统一应用中的刷新风格；2、方便使用，不用记MJRefresh对应的类别。
@interface UIScrollView (MJRefreshDefault)

/**
 *  增加下拉刷新功能
 *
 *  @param block 回调：刷新操作
 */
- (void)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)block;

/**
 *  增加上拉刷新功能
 *
 *  @param block 回调：刷新操作
 */
- (void)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)block;

@end
