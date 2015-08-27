//
//  WeiSubCommentCell.h
//  Sunflower
//
//  Created by makewei on 15/6/4.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCommentModel;
@interface WLShareSubCommentCell : UITableViewCell

@property(nonatomic,strong)WLCommentModel     *comment;
@property(nonatomic,copy)void(^longTapBlock)(WLCommentModel *comment);
@property(nonatomic,copy)void(^shortTapBlock)(WLCommentModel *comment);
+ (NSString *)reuseIdentify;

+ (CGFloat)heightWithComment:(WLCommentModel *)comment screenWidth:(CGFloat)width;
@end
