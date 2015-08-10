//
//  CommentListVC.h
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WLCommentType);

/// 对象的评论列表
@interface CommentListVC : UIViewController

/**
 *  实例化评论列表界面对象
 *
 *  @param type  评论类型
 *  @param refId 评论对象ID
 *
 *  @return 界面实例
 */
- (id)initWithType:(WLCommentType)type refId:(NSUInteger)refId;

@end
