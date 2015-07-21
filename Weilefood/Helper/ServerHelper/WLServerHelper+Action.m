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

- (void)action_addWithType:(WLActionType)type actType:(WLActionActType)actType objectId:(NSUInteger)objectId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"action", @"add", @(type), @(actType), @(objectId)]];
    [self httpGET:apiUrl parameters:nil callback:callback];
}

@end
