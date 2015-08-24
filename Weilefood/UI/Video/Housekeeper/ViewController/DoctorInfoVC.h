//
//  DoctorInfoVC.h
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "TransparentNavigationBarVC.h"

@class WLDoctorModel;

/// 营养师详情
@interface DoctorInfoVC : TransparentNavigationBarVC

/**
 *  初始化此界面，并指定doctor
 *
 *  @param doctor 营养师
 *
 *  @return
 */
- (id)initWithDoctor:(WLDoctorModel *)doctor;

@end
