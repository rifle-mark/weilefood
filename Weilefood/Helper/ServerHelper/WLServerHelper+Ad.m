//
//  WLServerHelper+Ad.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Ad.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Ad)

- (void)ad_getListWithCallback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"ad", @"list"]];
    [self httpGET:apiUrl parameters:nil resultArrayClass:[WLAdModel class] callback:callback];
}

@end
