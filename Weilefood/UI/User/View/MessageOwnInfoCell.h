//
//  MessageInfoCell.h
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLMessageModel;
@interface MessageOwnInfoCell : UITableViewCell

@property(nonatomic,strong)WLMessageModel   *message;

+ (NSString *)reuseIdentify;

+ (CGFloat)cellHeightWithMessage:(WLMessageModel *)message;

@end
