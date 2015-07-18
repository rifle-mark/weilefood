//
//  WLServerHelper.m
//  Weilefood
//
//  Created by kelei on 15/7/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"
#import "WLModelHeader.h"
#import "WLDictionaryHelper.h"


NSString * const API_RESULT_KEYNAME = @"result";
NSString * const API_RESULT_ITEMS_KEYNAME = @"items";


@interface WLServerHelper ()
- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback ;
- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback;
- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters resultArrayClass:(Class)resultArrayClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;
- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback;
@end

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
    [manager.requestSerializer setValue:self.userToken forHTTPHeaderField:@"token"];
    return manager;
}

- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    [self _httpIsGet:YES url:url parameters:parameters callback:callback];
}

- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    [self _httpIsGet:NO url:url parameters:parameters callback:callback];
}

- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback {
    [self _httpIsGet:YES url:url parameters:parameters resultClass:resultClass callback:callback];
}

- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback {
    [self _httpIsGet:NO url:url parameters:parameters resultClass:resultClass callback:callback];
}

- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters resultArrayClass:(Class)resultArrayClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    [self _httpIsGet:YES url:url parameters:parameters resultArrayClass:resultArrayClass callback:callback];
}

- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters resultArrayClass:(Class)resultArrayClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    [self _httpIsGet:NO url:url parameters:parameters resultArrayClass:resultArrayClass callback:callback];
}

- (void)httpGET:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    [self _httpIsGet:YES url:url parameters:parameters resultItemsClass:resultItemsClass callback:callback];
}

- (void)httpPOST:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    [self _httpIsGet:NO url:url parameters:parameters resultItemsClass:resultItemsClass callback:callback];
}

#pragma mark - private methods

- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters callback:(void (^)(WLApiInfoModel *apiInfo, NSError *error))callback {
    void (^success)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        GCBlockInvoke(callback, apiInfo, nil);
    };
    void (^failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, error);
    };
    
    AFHTTPRequestOperationManager *manager = [self httpManager];
    if (isGet) {
        [manager GET:url parameters:parameters success:success failure:failure];
    }
    else {
        [manager POST:url parameters:parameters success:success failure:failure];
    }
}

- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters resultClass:(Class)resultClass callback:(void (^)(WLApiInfoModel *apiInfo, id apiResult, NSError *error))callback {
    void (^success)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        id apiResult = nil;
        if (apiInfo.isSuc) {
            NSDictionary *dic = responseDic[API_RESULT_KEYNAME];
            apiResult = [resultClass objectWithKeyValues:dic];
        }
        GCBlockInvoke(callback, apiInfo, apiResult, nil);
    };
    void (^failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, nil, error);
    };
    
    AFHTTPRequestOperationManager *manager = [self httpManager];
    if (isGet) {
        [manager GET:url parameters:parameters success:success failure:failure];
    }
    else {
        [manager POST:url parameters:parameters success:success failure:failure];
    }
}

- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters resultArrayClass:(Class)resultArrayClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    void (^success)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        NSArray *apiResult = nil;
        if (apiInfo.isSuc) {
            NSArray *arr = responseDic[API_RESULT_KEYNAME];
            apiResult = [resultArrayClass objectArrayWithKeyValuesArray:arr];
        }
        GCBlockInvoke(callback, apiInfo, apiResult, nil);
    };
    void (^failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, nil, error);
    };
    
    AFHTTPRequestOperationManager *manager = [self httpManager];
    if (isGet) {
        [manager GET:url parameters:parameters success:success failure:failure];
    }
    else {
        [manager POST:url parameters:parameters success:success failure:failure];
    }
}

- (void)_httpIsGet:(BOOL)isGet url:(NSString *)url parameters:(NSDictionary *)parameters resultItemsClass:(Class)resultItemsClass callback:(void (^)(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error))callback {
    void (^success)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = [WLDictionaryHelper validModelDictionary:responseObject];
        WLApiInfoModel *apiInfo = [WLApiInfoModel objectWithKeyValues:responseDic];
        NSArray *apiResult = nil;
        if (apiInfo.isSuc) {
            NSArray *arr = responseDic[API_RESULT_KEYNAME][API_RESULT_ITEMS_KEYNAME];
            apiResult = [resultItemsClass objectArrayWithKeyValuesArray:arr];
        }
        GCBlockInvoke(callback, apiInfo, apiResult, nil);
    };
    void (^failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        GCBlockInvoke(callback, nil, nil, error);
    };
    
    AFHTTPRequestOperationManager *manager = [self httpManager];
    if (isGet) {
        [manager GET:url parameters:parameters success:success failure:failure];
    }
    else {
        [manager POST:url parameters:parameters success:success failure:failure];
    }
}

@end
