//
//  PointRulerCell.h
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLPointRulerModel;

@interface PointRulerCell : UITableViewCell

@property(nonatomic,strong)WLPointRulerModel    *ruler;

+ (NSString *)reuseIdentify;
@end
