//
//  MainPageCollectionHeaderView.h
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 首页CollectionCell的组头
@interface MainPageCollectionHeaderView : UICollectionReusableView

/// 标题
@property (nonatomic, copy) NSString *title;
/// "全部"按钮回调
@property (nonatomic, copy) void (^allButtonActionBlock)();

@end
