//
//  WLServerHelper+Channel.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Channel.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Channel)

- (void)channel_getListWithType:(WLChannelType)type callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"channel", @"list", @(type)]];
    [self httpGET:apiUrl parameters:nil resultArrayClass:[WLChannelModel class] callback:callback];
}

@end
