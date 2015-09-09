//
//  WLAppCheckUpdateHelper.m
//  Weilefood
//
//  Created by kelei on 15/9/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLAppCheckUpdateHelper.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@implementation WLAppCheckUpdateHelper

+ (void)check {
    [[WLServerHelper sharedInstance] appVersion_getWithCallback:^(WLApiInfoModel *apiInfo, WLAppVersionModel *apiResult, NSError *error) {
        if (error || !apiInfo.isSuc) {
            return;
        }
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if ([currentVersion compare:apiResult.version options:NSNumericSearch] == NSOrderedAscending) {
            NSString *title = [NSString stringWithFormat:@"新版本%@", apiResult.version];
            NSString *message = apiResult.message;
            GCAlertView *alertView = [[GCAlertView alloc] initWithTitle:title andMessage:message];
            [alertView setCancelButtonWithTitle:@"去升级" actionBlock:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:apiResult.url]];
                exit(0);
            }];
            if (!apiResult.force) {
                [alertView addOtherButtonWithTitle:@"取消" actionBlock:nil];
            }
            [alertView show];
        }
    }];
}

@end
