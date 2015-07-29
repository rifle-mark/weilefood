//
//  MarketProductCell.h
//  Weilefood
//
//  Created by kelei on 15/7/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Cell上要显示的标签
typedef NS_ENUM(NSInteger, MarketProductCellTag) {
    /// 无
    MarketProductCellTagNone = 0,
    /// 精选茶品
    MarketProductCellTagJXCP = 1,
    /// 粮油调料
    MarketProductCellTagLYTL = 2,
    /// 养生煲汤
    MarketProductCellTagYSBT = 3,
    /// 特色美食
    MarketProductCellTagTSMS = 4,
};

/// 集市列表商品Cell
@interface MarketProductCell : UITableViewCell

/// 图片URL
@property (nonatomic, copy  ) NSString             *imageUrl;
/// 标签
@property (nonatomic, assign) MarketProductCellTag tagType;
/// 名称
@property (nonatomic, copy  ) NSString             *name;
/// 剩余数量
@property (nonatomic, assign) NSInteger            number;
/// 单价
@property (nonatomic, assign) CGFloat              price;
/// 赞数
@property (nonatomic, assign) NSUInteger           actionCount;
/// 评论数
@property (nonatomic, assign) NSUInteger           commentCount;

@end
