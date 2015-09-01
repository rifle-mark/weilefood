//
//  WLServerHelper+Action.m
//  Weilefood
//
//  Created by kelei on 15/7/21.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Action.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Action)

- (void)action_addWithActType:(WLActionActType)actType objectType:(WLActionType)objectType objectId:(long long)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"action", @"add", @(objectType), @(actType), @(objectId)]];
    [self httpGET:apiUrl parameters:nil callback:callback];
}

- (void)action_deleteFavoriteWithObjectType:(WLActionType)objectType objectId:(long long)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"action", @"deletefav"]];
    NSDictionary *parameters = @{@"type"  : @(objectType),
                                 @"refid" : @(objectId),
                                 };
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

- (void)action_myFavoriteListWithType:(WLActionType)type maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"action", @"myfav"]];
    NSDictionary *parameters = @{@"type"       : @(type),
                                 @"pagesize"   : @(pageSize),
                                 @"createdate" : @([maxDate millisecondIntervalSince1970]),
                                 };
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLActionModel class] callback:callback];
}

@end
