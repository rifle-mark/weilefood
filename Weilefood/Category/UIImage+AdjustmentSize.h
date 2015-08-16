//
//  UIImage+AdjustmentSize.h
//  LawyerCenter
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AdjustmentSize)

/**
 *  调整当前尺寸
 *
 *  @param newSize 新尺寸
 *
 *  @return 调整后的图片
 */
- (UIImage *)adjustmentWithNewSize:(CGSize)newSize;

/**
 *  调整图片尺寸到当前工程标准大小
 *
 *  @return 调整后的图片
 */
- (UIImage *)adjustedToStandardSize;

@end
