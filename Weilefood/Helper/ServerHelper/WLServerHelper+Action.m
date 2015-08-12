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

- (void)action_addWithActType:(WLActionActType)actType objectType:(WLActionType)objectType objectId:(NSUInteger)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"action", @"add", @(objectType), @(actType), @(objectId)]];
    [self httpGET:apiUrl parameters:nil callback:callback];
}

- (void)action_deleteFavoriteWithObjectType:(WLActionType)objectType objectId:(NSUInteger)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"action", @"deletefav"]];
    NSDictionary *parameters = @{@"type"  : @(objectType),
                                 @"refid" : @(objectId),
                                 };
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

@end
