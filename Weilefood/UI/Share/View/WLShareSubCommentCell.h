//
//  WeiSubCommentCell.h
//  Sunflower
//
//  Created by makewei on 15/6/4.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLShareModel;
@interface WLShareSubCommentCell : UITableViewCell

@property(nonatomic,strong)WLShareModel     *share;
@property(nonatomic,copy)void(^longTapBlock)(WLShareModel *share);
+ (NSString *)reuseIdentify;

+ (CGFloat)heightWithComment:(WLShareModel *)share screenWidth:(CGFloat)width;
@end
