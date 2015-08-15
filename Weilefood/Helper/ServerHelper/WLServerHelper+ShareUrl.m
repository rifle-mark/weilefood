//
//  WLServerHelper+ShareUrl.m
//  Weilefood
//
//  Created by kelei on 15/8/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+ShareUrl.h"

@implementation WLServerHelper (ShareUrl)

- (NSString *)getShareUrlWithType:(WLServerHelperShareType)type objectId:(long long)objectId {
    NSString *pageName;
    switch (type) {
        case WLServerHelperShareTypeActivity:
            pageName = @"activity";
            break;
        case WLServerHelperShareTypeForwardBuy:
            pageName = @"forwardbuy";
            break;
        case WLServerHelperShareTypeNutrition:
            pageName = @"classroom";
            break;
        case WLServerHelperShareTypeVideo:
            pageName = @"video";
            break;
        case WLServerHelperShareTypeDoctor:
            pageName = @"doctor";
            break;
        default:
            pageName = @"product";
            break;
    }
    NSString *path = [NSString stringWithFormat:@"%@.html?id=%lld", pageName, objectId];
    return [self getApiUrlWithPaths:@[path]];
}

@end
