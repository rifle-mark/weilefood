//
//  UIMenuController+UserInfo.m
//  Sunflower
//
//  Created by makewei on 15/6/25.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "UIMenuController+UserInfo.h"
#import <objc/runtime.h>

static char* const ASSOCIATED_USERINFO_KEY = "Associated_UIMenuController_UserInfo_key";

@implementation UIMenuController (UserInfo)

-(NSDictionary *)userInfo {
    return objc_getAssociatedObject(self, ASSOCIATED_USERINFO_KEY);
}

-(void)setUserInfo:(NSDictionary *)userInfo {
    objc_setAssociatedObject(self, ASSOCIATED_USERINFO_KEY, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
