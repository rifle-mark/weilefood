//
//  WLAPIAddressGenerator.m
//  Weilefood
//
//  Created by makewei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLAPIAddressGenerator.h"

@implementation WLAPIAddressGenerator


+ (NSURL*)urlOfPictureWith:(CGFloat)width height:(CGFloat)height urlString:(NSString*)urlStr {
    if (!urlStr) {
        return nil;
    }
    
    if (width == 0 || height == 0) {
        return [NSURL URLWithString:urlStr];
    }
    if ([UIScreen mainScreen].scale >= 3) {
        width = width * 3;
        height = height * 3;
    }
    if ([UIScreen mainScreen].scale >=2 && [UIScreen mainScreen].scale < 3) {
        width = width * 2;
        height = height * 2;
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%d-%d-1", urlStr, (int)width, (int)height]];
}
@end
