//
//  SettingClearCacheCell.h
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingClearCacheCell : UITableViewCell

+ (NSString *)reuseIdentify;

- (void)calculateAndRefreshCacheSize;
@end
