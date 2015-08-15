//
//  ShareOnPlatformVC.h
//  Weilefood
//
//  Created by kelei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 分享内容到第三方平台
@interface ShareOnPlatformVC : UIViewController

/**
 *  分享内容
 *
 *  @param imageUrl 图片链接
 *  @param title    标题和描述
 *  @param shareUrl 分享链接
 */
+ (void)shareWithImageUrl:(NSString *)imageUrl title:(NSString *)title shareUrl:(NSString *)shareUrl;

@end
