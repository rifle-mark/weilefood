//
//  WLAPIAddressGenerator.h
//  Weilefood
//
//  Created by makewei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLAPIAddressGenerator : NSObject


+ (NSURL*)urlOfPictureWith:(CGFloat)width height:(CGFloat)height urlString:(NSString*)urlStr;
@end
