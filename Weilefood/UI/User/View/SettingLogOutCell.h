//
//  SettingLogOutCell.h
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingLogOutCell : UITableViewCell

@property(nonatomic,copy)void(^logOutBlock)();

+ (NSString *)reuseIdentify;
@end
