//
//  CommentCell.h
//  Weilefood
//
//  Created by kelei on 15/8/9.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 评论内容列表Cell
@interface CommentCell : UITableViewCell

/// 头像URL
@property (nonatomic, copy) NSString *avatarUrl;
/// 昵称
@property (nonatomic, copy) NSString *name;
/// 回复用户昵称
@property (nonatomic, copy) NSString *toName;
/// 内容
@property (nonatomic, copy) NSString *content;
/// 时间
@property (nonatomic, copy) NSDate   *time;

/**
 *  Cell展示所需要的高度
 *
 *  @param toName  回复用户昵称
 *  @param content Cell内容字符串
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithToName:(NSString *)toName content:(NSString *)content;

@end
