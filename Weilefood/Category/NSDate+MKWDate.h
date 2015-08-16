//
//  NSNumber+MKWDate.h
//  Sunflower
//
//  Created by mark on 15/5/4.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MKWDate)

- (NSString*)dateSplitByChinese;
- (NSString*)dateSplitBySplash;
- (NSString*)dateSplitByMinus;

- (NSString*)dateTimeSplitByChinese;
- (NSString*)dateTimeSplitBySplash;
- (NSString*)dateTimeSplitByMinus;

- (NSString*)dateTimeYear;
- (NSString*)dateTimeYearMonth;
- (NSNumber*)dateTimeMonthNumber;

- (NSString*)dateTimeByNow;
@end
