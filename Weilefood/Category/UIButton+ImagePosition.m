//
//  UIButton+ImagePosition.m
//  LawyerCenter
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIButton+ImagePosition.h"

@implementation UIButton (ImagePosition)

/**
 *  恢复默认图片位置
 */
- (void)setImageToLeft {
    self.titleEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
}

/**
 *  设置图片在文字的右侧
 */
- (void)setImageToRight {
    [self sizeToFit];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width);
}

@end
