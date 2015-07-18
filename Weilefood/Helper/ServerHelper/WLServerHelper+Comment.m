//
//  WLServerHelper+Comment.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Comment.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Comment)

- (void)comment_addWithType:(WLCommentType)type refId:(NSUInteger)refId content:(NSString *)content parentId:(NSUInteger)parentId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"comment", @"add"]];
    NSDictionary *parameters = @{@"comment": @{@"Type": @(type),
                                               @"RefId": @(refId),
                                               @"Content": content,
                                               @"ParentId": @(parentId),
                                               }};
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

- (void)comment_deleteWithCommentId:(NSUInteger)commentId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"comment", @"delete"]];
    NSDictionary *parameters = @{@"commentid": @(commentId)};
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

- (void)comment_getListWithType:(WLCommentType)type refId:(NSUInteger)refId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"comment", @"list", @(type), @(refId), @(1), @(pageSize), @([maxDate timeIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLCommentModel class] callback:callback];
}

- (void)comment_getMyListWithType:(WLCommentType)type refId:(NSUInteger)refId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"comment", @"mylist", @(type), @(refId), @(1), @(pageSize), @([maxDate timeIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLCommentModel class] callback:callback];
}

@end
