//
//  WLServerHelper+Video.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Video.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Video)

- (void)video_getAdImageWithCallback:(void (^)(WLApiInfoModel *apiInfo, WLVideoAdImageModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"pconfig", @"detail"]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLVideoAdImageModel class] callback:callback];
}

- (void)video_getInfoWithVideoId:(NSUInteger)videoId callback:(void (^)(WLApiInfoModel *apiInfo, WLVideoModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"video", @"detail", @(videoId)]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLVideoModel class] callback:callback];
}

- (void)video_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"video", @"reclist", @(pageIndex), @(pageSize)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLVideoModel class] callback:callback];
}

- (void)video_getListWithMaxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"video", @"list", @(1), @(pageSize), @([maxDate timeIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLVideoModel class] callback:callback];
}

@end
