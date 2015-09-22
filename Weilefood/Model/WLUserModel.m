//
//  WLUserModel.m
//  Weilefood
//
//  Created by kelei on 15/7/15.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLUserModel.h"

@implementation WLUserModel

+ (void)initialize {
    [self setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        if ([propertyName isEqualToString:@"udid"]) {
            return @"UDID";
        }
        return [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    }];
}

@end


@implementation WLMOUser

@dynamic email;
@dynamic isVip;
@dynamic loginDate;
@dynamic userId;
@dynamic avatar;
@dynamic password;
@dynamic nickName;
@dynamic trueName;
@dynamic udid;
@dynamic userName;
@dynamic token;
@dynamic infoExtent;
@dynamic room;
@dynamic unit;
@dynamic building;
@dynamic communityName;
@dynamic createDate;
@dynamic vipEndDate;
@dynamic auditDate;
@dynamic sex;
@dynamic validDays;
@dynamic points;
@dynamic isAudit;
@dynamic type;
@dynamic communityId;
@dynamic couponCount;
@dynamic lastSignInDate;

@end