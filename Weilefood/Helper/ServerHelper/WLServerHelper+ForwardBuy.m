//
//  WLServerHelper+ForwardBuy.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+ForwardBuy.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (ForwardBuy)

- (void)forwardBuy_getInfoWithForwardBuylId:(NSUInteger)forwardBuylId callback:(void (^)(WLApiInfoModel *apiInfo, WLForwardBuyModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"forwardbuy", @"detail", @(forwardBuylId)]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLForwardBuyModel class] callback:callback];
}

- (void)forwardBuy_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"forwardbuy", @"reclist", @(pageIndex), @(pageSize)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLForwardBuyModel class] callback:callback];
}

- (void)forwardBuy_getListWithChannelId:(NSUInteger)channelId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"forwardbuy", @"list", @(1), @(pageSize), @(channelId), @(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLForwardBuyModel class] callback:callback];
}

@end
