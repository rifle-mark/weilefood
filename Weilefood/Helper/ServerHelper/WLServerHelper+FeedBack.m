//
//  WLServerHelper+FeedBack.m
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper+FeedBack.h"

@implementation WLServerHelper (FeedBack)

- (void)feedBack_addWithContent:(NSString*)content userInfo:(NSString*)userInfo callback:(void(^)(WLApiInfoModel* apiInfo, NSError *error))callback {
    NSString *apiUrl = [self getApiUrlWithPaths:@[@"feedback", @"add"]];
    NSDictionary *parameters = @{@"feedback": @{@"Email": userInfo,
                                               @"Content": content,
                                               }};
    
    [self httpPOST:apiUrl parameters:parameters callback:callback];
}
@end
