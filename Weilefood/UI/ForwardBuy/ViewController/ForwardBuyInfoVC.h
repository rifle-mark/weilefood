//
//  ForwardBuyInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "TransparentNavigationBarVC.h"

@class WLForwardBuyModel;

/// 预购详情页
@interface ForwardBuyInfoVC : TransparentNavigationBarVC

/**
 *  通过WLForwardBuyModel实例化预购详情界面
 *
 *  @param forwardBuy
 *
 *  @return
 */
- (instancetype)initWithForwardBuy:(WLForwardBuyModel *)forwardBuy;

@end
