//
//  WeiCommentCell.h
//  Sunflower
//
//  Created by makewei on 15/6/4.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLShareModel.h"

@interface WLSharePicCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView      *imgV;

+ (NSString *)reuseIdentify;

@end

@interface WLShareCell : UITableViewCell

@property(nonatomic,strong)WLShareModel     *share;
@property(nonatomic,assign)BOOL             isUped;

@property(nonatomic,copy)void(^likeActionBlock)(WLShareModel *comment);
@property(nonatomic,copy)void(^commentActionBlock)(WLShareModel *comment);
@property(nonatomic,copy)void(^actionBlock)(WLShareCell *cell);
@property(nonatomic,copy)void(^picShowBlock)(NSArray *picUrlArray, NSInteger index);

+ (NSString *)reuseIdentify;
+ (CGFloat)heightWithComment:(WLShareModel *)comment screenWidth:(CGFloat)width;

- (void)addUpCount;
- (void)addCommentCount;
@end
