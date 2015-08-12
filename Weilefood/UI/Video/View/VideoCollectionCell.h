//
//  VideoCollectionCell.h
//  Weilefood
//
//  Created by kelei on 15/8/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 视频列表界面Cell
@interface VideoCollectionCell : UICollectionViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString  *imageUrl;
/// 标题
@property (nonatomic, copy  ) NSString  *title;
/// 积分
@property (nonatomic, assign) NSInteger points;
/// YES:视频 NO:文章
@property (nonatomic, assign) BOOL      isVideo;
/// 已收藏
@property (nonatomic, assign) BOOL      isFavorite;

/**
 *  Cell展示所需要的高度
 *
 *  @param cellWidth Cell宽度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithCellWidth:(CGFloat)cellWidth;

/**
 *  回调：用户点击了收藏按钮
 *
 *  @param block
 */
- (void)favoriteBlock:(void (^)(VideoCollectionCell *cell))block;

@end
