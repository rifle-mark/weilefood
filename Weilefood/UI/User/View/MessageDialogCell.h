//
//  MessageDialogCell.h
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLDialogModel;

@interface MessageDialogCell : UITableViewCell

@property(nonatomic,strong)WLDialogModel    *dialog;

+ (NSString *)reuseIdentify;

@end
