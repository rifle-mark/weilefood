//
//  MyCommentCell.h
//  Weilefood
//
//  Created by makewei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCommentModel;

@interface MyCommentCell : UITableViewCell

@property(nonatomic,strong)WLCommentModel   *comment;
@property(nonatomic,assign)BOOL             needSeperator;

@property(nonatomic,copy)void(^subjectClickBlock)(WLCommentModel* comment);
@property(nonatomic,copy)void(^userClickBlock)(WLCommentModel* comment);


+ (NSString *)reuseIdentify;
+ (CGFloat)heightOfCellWithComment:(WLCommentModel*)comment;
@end
