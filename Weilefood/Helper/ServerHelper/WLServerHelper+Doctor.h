//
//  WLServerHelper+Doctor.h
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@class WLDoctorModel;

/// 营养师相关接口
@interface WLServerHelper (Doctor)

/**
 *  获取营养师详细信息
 *
 *  @param doctorId 营养师ID
 *  @param callback
 */
- (void)doctor_getInfoWithDoctorId:(long long)doctorId callback:(void (^)(WLApiInfoModel *apiInfo, WLDoctorModel *apiResult, NSError *error))callback;

/**
 *  营养师列表。(NSArray<WLDoctorModel>)apiResult
 *
 *  @param maxDate   加载最新数据传0，加载更多数据传MIN(Date)
 *  @param pageSize  返回的最大记录数
 *  @param callback
 */
- (void)doctor_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;

@end
