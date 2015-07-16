//
//  WLUserModel.h
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 用户性别
typedef NS_ENUM(NSUInteger, WLUserSex){
    /// 无,其它
    WLUserSexOther,
    /// 男
    WLUserSexMale,
    /// 女
    WLUserSexFemale,
};

/// 用户信息
@interface WLUserModel : NSObject
/// Email
@property (nonatomic, copy) NSString *email;
/// 登录的时间 （有效30天）
@property (nonatomic, copy) NSDate *loginDate;
/// 头像地址
@property (nonatomic, copy) NSString *avatar;
/// 创建时间
@property (nonatomic, copy) NSDate *createDate;
/// 密码
@property (nonatomic, copy) NSString *password;
/// 用户编号
@property (nonatomic, assign) NSUInteger userId;
/// 昵称
@property (nonatomic, copy) NSString *nickName;
/// 设备ID
@property (nonatomic, copy) NSString *udid;
/// 用户名
@property (nonatomic, copy) NSString *userName;
/// 性别
@property (nonatomic, assign) WLUserSex sex;
/// 是否为VIP
@property (nonatomic, assign) BOOL isVip;
/// Vip过期时间
@property (nonatomic, copy) NSDate *vipEndDate;
/// VIP有效天数
@property (nonatomic, assign) NSUInteger validDays;
/// 登录成功后服务器返回的
@property (nonatomic, copy) NSString *token;

@end
