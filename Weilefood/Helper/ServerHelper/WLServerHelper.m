//
//  WLServerHelper.m
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@implementation WLServerHelper

+ (instancetype)sharedInstance {
    static WLServerHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - public methods

- (NSString *)getApiUrlWithPaths:(NSArray *)urlPaths {
    NSMutableString *ret = [NSMutableString stringWithString:kServerApiUrl];
    for (id item in urlPaths) {
        [ret appendFormat:@"/%@", item];
    }
    return ret;
}

- (AFHTTPRequestOperationManager *)httpManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:self.token forHTTPHeaderField:@"token"];
    return manager;
}

@end
