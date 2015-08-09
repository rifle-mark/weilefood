//
//  UIButton+ImagePosition.h
//  LawyerCenter
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImagePosition)

/**
 *  恢复默认图片位置
 */
- (void)setImageToLeft;

/**
 *  设置图片在文字的右侧
 */
- (void)setImageToRight;

/**
 *  设置图片在文字的上方
 */
- (void)setImageToTop;

@end
