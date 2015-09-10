//
//  MyCommentCell.h
//  Weilefood
//
//  Created by makewei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCommentModel;

typedef NS_ENUM(NSInteger, MyCommentCellMode) {
    /// 我回复的
    MyCommentCellModeMyReply,
    /// 回复我的
    MyCommentCellModeReplyMe,
};

@interface MyCommentCell : UITableViewCell

@property(nonatomic,assign)BOOL             needSeperator;

@property(nonatomic,copy)void(^subjectClickBlock)(WLCommentModel* comment);
@property(nonatomic,copy)void(^userClickBlock)(WLCommentModel* comment);

- (void)setComment:(WLCommentModel *)comment mode:(MyCommentCellMode)mode;

+ (NSString *)reuseIdentify;
+ (CGFloat)heightOfCellWithComment:(WLCommentModel*)comment mode:(MyCommentCellMode)mode;
@end
