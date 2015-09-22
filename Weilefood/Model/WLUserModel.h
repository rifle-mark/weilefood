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
    WLUserSexOther = 0,
    /// 男
    WLUserSexMale = 1,
    /// 女
    WLUserSexFemale = 2,
};

/// 用户认证状态
typedef NS_ENUM(NSUInteger, WLUserAudit){
    /// 未认证
    WLUserAuditNone = 0,
    /// 已认证
    WLUserAuditCertified = 1,
    /// 认证中
    Certification = 2,
};

/// 用户
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
/// 真实姓名
@property (nonatomic, copy) NSString *trueName;
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

/// 积分数
@property (nonatomic, assign) NSInteger points;
/// 认证状态
@property (nonatomic, assign) WLUserAudit isAudit;
/// 认证通过时间
@property (nonatomic, copy) NSDate *auditDate;
///
@property (nonatomic, copy) NSString *infoExtent;
///
@property (nonatomic, assign) NSInteger type;
///
@property (nonatomic, copy) NSString *room;
///
@property (nonatomic, copy) NSString *unit;
///
@property (nonatomic, copy) NSString *building;
///
@property (nonatomic, copy) NSString *communityName;
///
@property (nonatomic, assign) NSInteger communityId;
///
@property (nonatomic, assign) NSInteger couponCount;
/// 最近签到日期
@property (nonatomic, copy) NSString *lastSignInDate;

@end


/// CoreData使用
@interface WLMOUser : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * isVip;
@property (nonatomic, retain) NSDate * loginDate;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * nickName;
@property (nonatomic, retain) NSString * trueName;
@property (nonatomic, retain) NSString * udid;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * infoExtent;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSString * communityName;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * vipEndDate;
@property (nonatomic, retain) NSDate * auditDate;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * validDays;
@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) NSNumber * isAudit;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * communityId;
@property (nonatomic, retain) NSNumber * couponCount;
@property (nonatomic, retain) NSString * lastSignInDate;

@end
