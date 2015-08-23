//
//  ScoreView.h
//  Weilefood
//
//  Created by kelei on 15/8/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养师 - 星级视图
@interface ScoreView : UIView

/// 星级
@property (nonatomic, assign) NSInteger score;

/**
 *  展示View所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

@end
