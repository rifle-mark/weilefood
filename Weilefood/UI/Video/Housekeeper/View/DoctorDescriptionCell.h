//
//  DoctorDescriptionCell.h
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 营养师详情界面 - 介绍部分
@interface DoctorDescriptionCell : UITableViewCell

/// 介绍
@property (nonatomic, copy) NSString *desc;

/**
 *  Cell展示所需要的高度
 *
 *  @param desc 介绍文字
 *
 *  @return 高度
 */
+ (CGFloat)cellHeightWithDesc:(NSString *)desc;
+ (NSString *)reuseIdentifier;

@end
