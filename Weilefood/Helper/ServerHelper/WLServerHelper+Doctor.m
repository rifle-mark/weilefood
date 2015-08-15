//
//  WLServerHelper+Doctor.m
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Doctor.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Doctor)

- (void)doctor_getInfoWithDoctorId:(long long)doctorId callback:(void (^)(WLApiInfoModel *apiInfo, WLDoctorModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"doctor", @"detail", @(doctorId)]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLDoctorModel class] callback:callback];
}

- (void)doctor_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"doctor", @"list", @1, @(pageSize), @([maxDate millisecondIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLDoctorModel class] callback:callback];
}

@end
