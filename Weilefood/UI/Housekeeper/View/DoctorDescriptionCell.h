//
//  DoctorDescriptionCell.h
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoctorDescriptionCellResetHeightBlock)(CGFloat newHeight);

/// 营养师详情界面 - 介绍部分
@interface DoctorDescriptionCell : UITableViewCell

/// 介绍html
@property (nonatomic, copy) NSString *desc;

+ (NSString *)reuseIdentifier;

/// 回调：加载介绍html，根据内容返回Cell最终高度
- (void)resetHeightBlock:(DoctorDescriptionCellResetHeightBlock)resetHeightBlock;

@end
