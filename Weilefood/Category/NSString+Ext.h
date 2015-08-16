//
//  NSString+Ext.h
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

/**
 *  对当前字符串做base64编码
 *
 *  @return base64编码后字符串
 */
- (NSString *)base64EncodedString;

/**
 *  对当前字符串做base64解码
 *
 *  @return base64解码后字符串
 */
- (NSString *)base64DecodedString;

/**
 *  获取当前字符串内容的小写32位md5码
 *
 *  @return 小写32位md5码
 */
- (NSString *)md5string;

+ (BOOL)isNilEmptyOrBlankString:(NSString *)str;

@end
