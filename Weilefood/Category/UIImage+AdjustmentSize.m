//
//  UIImage+AdjustmentSize.m
//  LawyerCenter
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIImage+AdjustmentSize.h"

@implementation UIImage (AdjustmentSize)

- (UIImage *)adjustmentWithNewSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)adjustedToStandardSize {
    static NSUInteger const MAX_SIZE = 1024;
    if (self.size.width >= self.size.height && self.size.width > MAX_SIZE) {
        CGSize newSize;
        newSize.width = MAX_SIZE;
        newSize.height = self.size.height * (MAX_SIZE / self.size.width);
        return [self adjustmentWithNewSize:newSize];
    }
    else if (self.size.height > MAX_SIZE) {
        CGSize newSize;
        newSize.height = MAX_SIZE;
        newSize.width = self.size.width * (MAX_SIZE / self.size.height);
        return [self adjustmentWithNewSize:newSize];
    }
    else {
        return self;
    }
}

@end
