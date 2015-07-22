//
//  AppDelegate.m
//  Weilefood
//
//  Created by kelei on 15/7/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "AppDelegate.h"
#import "BPushHelper.h"

#import "LoginVC.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    // 开启AFNetworking日志
    AFNetworkActivityLogger *networkActivityLogger = [AFNetworkActivityLogger sharedLogger];
    networkActivityLogger.level = AFLoggerLevelDebug;
    [networkActivityLogger startLogging];
    // UIViewController生命期日志，方便排查未释放的界面
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"init") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"%@ 被创建", aspectInfo.instance);
    } error:NULL];
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"%@ 被释放", aspectInfo.instance);
    } error:NULL];
#endif
    // 友盟统计
    [MobClick startWithAppkey:UMengAppKey reportPolicy:BATCH channelId:UMengAnalyticsChannelId];
    // 友盟分享
    [UMSocialData setAppKey:UMengAppKey];
    // 百度推送
    [BPushHelper registerAppDelegate:self launchOptions:launchOptions apiKey:BPushApiKey pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES isClearBadgeNumber:YES];
    
    // UI入口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - RemoteNotification

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // BPushHelper要求实现此方法(空内容及可)
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // BPushHelper要求实现此方法(空内容及可)
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // BPushHelper要求实现此方法(空内容及可)
    NSLog(@"App Received Remote Notification:\n%@", userInfo);
}

@end
