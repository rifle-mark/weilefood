//
//  VideoInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLVideoModel;

/// 视频详情界面
@interface VideoInfoVC : UIViewController

/**
 *  通过WLVideoModel实例化视频详情界面
 *
 *  @param video
 *
 *  @return
 */
- (instancetype)initWithVideo:(WLVideoModel *)video;

@end
