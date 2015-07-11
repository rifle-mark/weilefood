//
//  BPushHelper.m
//  Weilefood
//
//  Created by kelei on 15/7/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "BPushHelper.h"
#import <Aspects/Aspects.h>

@implementation BPushHelper

+ (void)registerAppDelegate:(UIResponder<UIApplicationDelegate> *)appDelegate launchOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apikey pushMode:(BPushMode)mode withFirstAction:(NSString *)leftAction withSecondAction:(NSString *)rightAction withCategory:(NSString *)category isDebug:(BOOL)isdebug isClearBadgeNumber:(BOOL)isClearBadgeNumber {
    
    NSString *selfClassName = NSStringFromClass([self class]);
    UIApplication *app = [UIApplication sharedApplication];
    // 应用注册运程通知
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [app registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [app registerForRemoteNotificationTypes:myTypes];
    }
    // 注册百度推送
    [BPush registerChannel:launchOptions apiKey:apikey pushMode:mode withFirstAction:leftAction withSecondAction:rightAction withCategory:category isDebug:isdebug];
    // 通过点击消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"%@ | 从消息启动 | %@", selfClassName, userInfo);
        [BPush handleNotification:userInfo];
    }
    //角标清0
    if (isClearBadgeNumber)
        [app setApplicationIconBadgeNumber:0];
    
    // 拦截AppDelegate回调
    NSError *err = nil;
    [appDelegate aspect_hookSelector:@selector(application:didRegisterUserNotificationSettings:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, UIApplication *application, UIUserNotificationSettings *notificationSettings) {
        [application registerForRemoteNotifications];
    } error:&err];
    NSAssert(!err, @"%@", err);
    
    err = nil;
    [appDelegate aspect_hookSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, UIApplication *application, NSData *deviceToken) {
        NSLog(@"%@ | DeviceToken | %@", selfClassName, deviceToken);
        [BPush registerDeviceToken:deviceToken];
        [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
            NSLog(@"%@ | %@ | %@", selfClassName, BPushRequestMethodBind, result);
        }];
    } error:&err];
    NSAssert(!err, @"%@", err);
    
    err = nil;
    [appDelegate aspect_hookSelector:@selector(application:didReceiveRemoteNotification:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIApplication *application, NSDictionary *userInfo) {
        NSLog(@"%@ | 收到运程通知 | %@", selfClassName, userInfo);
        [BPush handleNotification:userInfo];
    } error:&err];
    NSAssert(!err, @"%@", err);
}

@end
