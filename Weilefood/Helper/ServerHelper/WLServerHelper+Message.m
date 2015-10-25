//
//  WLServerHelper+Message.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Message.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Message)

- (void)message_addWithToUserId:(NSUInteger)toUserId content:(NSString *)content callback:(void (^)(WLApiInfoModel *apiInfo, WLMessageModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"message", @"add"]];
    NSDictionary *parameters = @{@"message": @{@"ToUserId": @(toUserId),
                                               @"Content": content,
                                               }};
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLMessageModel class] callback:callback];
}

- (void)message_getDialogListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"message", @"list", @(pageSize), @(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLDialogModel class] callback:callback];
}

- (void)message_getMessageListWithUserId:(NSUInteger)userId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"message", @"dialog"]];
    NSDictionary *parameters = @{@"pagesize":@(pageSize),
                                 @"maxdate":@(maxDate ? [maxDate millisecondIntervalSince1970_Beijing] : 0),
                                 @"touserid":@(userId)};
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLMessageModel class] callback:callback];
}

@end
