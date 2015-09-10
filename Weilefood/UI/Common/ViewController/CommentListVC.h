//
//  CommentListVC.h
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WLCommentType);

typedef void(^CommentListVCDismissBlock)(NSInteger addCount);

/// 对象的评论列表
@interface CommentListVC : UIViewController

/**
 *  弹出评论列表界面
 *
 *  @param type         评论类型
 *  @param refId        评论对象ID
 *  @param dismissBlock 界面关闭前回调
 *
 *  @return 界面实例
 */
+ (void)showWithType:(WLCommentType)type refId:(long long)refId dismissBlock:(CommentListVCDismissBlock)dismissBlock;

/**
 *  弹出评论列表界面
 *
 *  @param type         评论类型
 *  @param refId        评论对象ID
 *  @param nowEnter     立即弹出评论键盘
 *  @param dismissBlock 界面关闭前回调
 */
+ (void)showWithType:(WLCommentType)type refId:(long long)refId nowEnter:(BOOL)nowEnter dismissBlock:(CommentListVCDismissBlock)dismissBlock;

@end
