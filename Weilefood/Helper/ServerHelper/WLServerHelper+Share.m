//
//  WLServerHelper+Share.m
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Share.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Share)

- (void)share_addWithContent:(NSString *)content images:(NSString *)images callback:(void (^)(WLApiInfoModel *apiInfo, WLShareModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"share", @"add"]];
    NSDictionary *parameters = @{@"share": @{@"Content": content,
                                             @"Images": images
                                             }};
    [self httpPOST:apiUrl parameters:parameters resultClass:[WLShareModel class] callback:callback];
}

- (void)share_deleteWithShareId:(NSUInteger)shareId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"share", @"delete"]];
    NSDictionary *parameters = @{@"share": @(shareId)};
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

- (void)share_policeWithShareId:(NSUInteger)shareId callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"share", @"police"]];
    NSDictionary *parameters = @{@"share": @(shareId)};
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}

- (void)share_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"share", @"list"]];
    NSDictionary *parameters = @{@"pageindex": @(1),
                                 @"pagesize": @(pageSize),
                                 @"maxdate": @([maxDate timeIntervalSince1970]),
                                 };
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLShareModel class] callback:callback];
}

- (void)share_getMyListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *, NSArray *, NSError *))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"share", @"mylist"]];
    NSDictionary *parameters = @{@"pageindex": @(1),
                                 @"pagesize": @(pageSize),
                                 @"maxdate": @([maxDate timeIntervalSince1970]),
                                 };
    [self httpPOST:apiUrl parameters:parameters resultItemsClass:[WLShareModel class] callback:callback];
}

@end
