//
//  BPushHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPush.h"

@interface BPushHelper : NSObject

/**
 *  对“注册百度云推送”的封装。
 *  AppDelegate需要实现以下方个方法(空方法及可)
 *  | application:didRegisterUserNotificationSettings:
 *  | application:didRegisterForRemoteNotificationsWithDeviceToken:
 *  | application:didReceiveRemoteNotification:
 *
 *  @param appDelegate          AppDelegate对象
 *  @param launchOptions        App 启动时系统提供的参数，表明了 App 是通过什么方式启动的
 *  @param apikey               通过apikey注册百度推送
 *  @param mode                 当前推送的环境
 *  @param leftAction           第二个按钮名字默认会关闭应用
 *  @param rightAction          快捷回复通知的第一个按钮名字默认为打开应用
 *  @param category             自定义参数 一组动作的唯一标示 需要与服务端aps的category字段匹配才能展现通知样式
 *  @param isdebug              是否是debug模式
 *  @param isClearBadgeNumber   是否清除应用图标上的角标
 */
+ (void)registerAppDelegate:(UIResponder<UIApplicationDelegate> *)appDelegate launchOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apikey pushMode:(BPushMode)mode withFirstAction:(NSString *)leftAction withSecondAction:(NSString *)rightAction withCategory:(NSString *)category isDebug:(BOOL)isdebug isClearBadgeNumber:(BOOL)isClearBadgeNumber;

@end
