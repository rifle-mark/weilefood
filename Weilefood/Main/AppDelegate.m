//
//  AppDelegate.m
//  Weilefood
//
//  Created by kelei on 15/7/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "AppDelegate.h"
#import <UMengSocial/UMSocialWechatHandler.h>
#import "BPushHelper.h"
#import "WLServerHelperHeader.h"
#import "WLDatabaseHelperHeader.h"
#import "WLModelHeader.h"

#import "MainPageVC.h"

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
    [UINavigationController aspect_hookSelector:NSSelectorFromString(@"initWithRootViewController:") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"%@ 被创建", aspectInfo.instance);
    } error:NULL];
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"%@ 已释放", aspectInfo.instance);
    } error:NULL];
#endif
    // 友盟统计
    [MobClick startWithAppkey:UMengAppKey reportPolicy:BATCH channelId:UMengAnalyticsChannelId];
    // 友盟分享
    [UMSocialData setAppKey:UMengAppKey];
    // 微信登录
    [UMSocialWechatHandler setWXAppId:WXAppId appSecret:WXAppSecret url:WXAppUrl];
    // 百度推送
    [BPushHelper registerAppDelegate:self launchOptions:launchOptions apiKey:BPushApiKey pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES isClearBadgeNumber:YES];
    
    // 加载CoreData数据库
    [MagicalRecord setupCoreDataStackWithStoreNamed:kCoreDataStoreName];
    
    // 加载本地登录用户token
    WLUserModel *user = [WLDatabaseHelper user_find];
    if (user) {
        [WLServerHelper sharedInstance].userToken = user.token;
    }
    
    // 监听网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Network New Status:%@", [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString]);
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 监听用户登录登出消息
    [self addObserverForNotificationName:kNotificationUserLoginSucc usingBlock:^(NSNotification *notification) {
        if (!notification.object || [notification.object isKindOfClass:[WLUserModel class]]) {
            return;
        }
        WLUserModel *user = notification.object;
        [WLServerHelper sharedInstance].userToken = user.token;
        [WLDatabaseHelper user_save:user];
    }];
    [self addObserverForNotificationName:kNotificationUserLogout usingBlock:^(NSNotification *notification) {
        [WLServerHelper sharedInstance].userToken = nil;
        [WLDatabaseHelper user_delete];
    }];
    
    // 自定义BackButton样式，移除按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    // 自定义NavigationBar样式
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].barTintColor = k_COLOR_THEME_NAVIGATIONBAR;
    [UINavigationBar appearance].tintColor = k_COLOR_THEME_NAVIGATIONBAR_TEXT;
    [UINavigationController aspect_hookSelector:NSSelectorFromString(@"initWithRootViewController:") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        ((UINavigationController *)aspectInfo.instance).navigationBar.translucent = NO;
    } error:NULL];
    
    // UI入口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    MainPageVC *vc = [[MainPageVC alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 保存CoreData
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 保存CoreData
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [MagicalRecord cleanUp];
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
