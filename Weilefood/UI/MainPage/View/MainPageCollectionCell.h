//
//  MainPageCollectionCell.h
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Cell中图片高度=图片宽度*此数据
static CGFloat const kMainPageCollectionCellImageHeightScale = 0.788;

/// 首页CollectionCell
@interface MainPageCollectionCell : UICollectionViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString *imageUrl;
/// 标题
@property (nonatomic, copy  ) NSString *title;
/// 金额
@property (nonatomic, assign) CGFloat  money;

@end
