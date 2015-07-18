//
//  WLServerHelper+Product.m
//  Weilefood
//
//  Created by kelei on 15/7/18.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+Product.h"
#import "WLModelHeader.h"

@implementation WLServerHelper (Product)

- (void)product_getInfoWithProductId:(NSUInteger)productId callback:(void (^)(WLApiInfoModel *apiInfo, WLProductModel *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"product", @"detail", @(productId)]];
    [self httpGET:apiUrl parameters:nil resultClass:[WLProductModel class] callback:callback];
}

- (void)product_getListWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"product", @"list", @(pageIndex), @(pageSize)]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLProductModel class] callback:callback];
}

- (void)product_getListWithChannelId:(NSUInteger)channelId maxDate:(NSDate *)maxDate pageSize:(NSUInteger)pageSize callback:(void (^)(WLApiInfoModel *, NSArray *, NSError *))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"product", @"list", @(1), @(pageSize), @(channelId), @([maxDate timeIntervalSince1970])]];
    [self httpGET:apiUrl parameters:nil resultItemsClass:[WLProductModel class] callback:callback];
}

@end
