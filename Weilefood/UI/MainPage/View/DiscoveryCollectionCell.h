//
//  DiscoveryCollectionCell.h
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 发现界面CollectionCell
@interface DiscoveryCollectionCell : UICollectionViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString *imageUrl;
/// 标题
@property (nonatomic, copy  ) NSString *title;
/// 金额
@property (nonatomic, assign) CGFloat  money;

/**
 *  Cell展示所需要的高度
 *
 *  @param cellWidth Cell宽度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithCellWidth:(CGFloat)cellWidth;

@end
