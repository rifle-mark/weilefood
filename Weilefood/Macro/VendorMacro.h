//
//  VendorMacro.h
//  LawyerCenter
//
//  Created by kelei on 15/6/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#ifndef Weilefood_VendorMacro_h
#define Weilefood_VendorMacro_h

/**
 *  友盟
 */
#define UMengAppKey                     @"55a08c6367e58ef24a007a9f"
#define UMengAnalyticsChannelId         @"App Store"

/**
 *  百度
 */
#define BPushApiKey                     @"FGvbKHztvfw1MfxU2fcGWzQ6"

/**
 *  微博
 */
#define WBRedirectURL                   @"http://sns.whalecloud.com/sina2/callback"

/**
 *  微信
 */
#define WXAppId                         @"wx8ae2e5317dc91790"
#define WXAppSecret                     @"482feae08ae29065d395bd062fd5e49d"
#define WXAppUrl                        @"http://www.umeng.com/social"

/**
 *  支付宝
 */
// partner:合作身份者ID,以 2088 开头由 16 位纯数字组成的字符串。
#define kAlipayPartnerID                @"2088021162256137"
// seller:支付宝收款账号,手机号码或邮箱格式。
#define kAlipaySellerAccount            @"3262791991@qq.com"
// 支付宝服务器主动通知商户 网站里指定的页面 http 路径。
#define kAlipayNotifyURL                @"http://web.ifeicai.com/api/alipay/notify.aspx"
// appSckeme:应用注册scheme,在Info.plist定义URLtypes，处理支付宝回调
#define kAlipayAppScheme                @"alipay2088021162256137"
// private_key:商户方的私钥,pkcs8 格式。
#define kAlipayPrivateKey               @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJflmQXVpCs0J1u09t6kb17hA2XuZN+d9Okc3VPejjwVqnDvok6bj2KfAMOTN+VW27Lkbc5LMuLBark0NakJ2Z6keRj4xqK3Q+KJVF0572Jte974ZBP4Pzu+uiU7mXfdvrrW25k+AO3OiN7HeDQ/+TdvHpgmriGvKpdgR6bv8XHfAgMBAAECgYA9+6Po3JgkRSD2bC79BU6pAdr4IkKpeXRyF6Q9UCjsXc7yTOcHerUVAls2c4GwpTP7mPkx4D/Ahjq9no9zDiDt2a1+2Fpmg86a3GM0fwaKZpFCd0P4sN5RF7mujUcp5Nluek9Rc58QaqEkVvyr1wiO0rgB9E5b4b2svQrvBPbzwQJBAMgmPwff7gPGwOy3ATeYPrMJN2yNa4+7YI6HUyD0p/La5dC1k2YB1t9xJ48C+zhAm5rXed74vdqQNmAZaPHfsL8CQQDCSGmFmX6auSx+8tWRwbd/3efSOzCPlKz2OC3ApRt24GR2WdT+zvLZIye+xVtNijO+YwtwMCWstW0uBHKV1WbhAkACoe4mTl21EwIqmuWbM5dvh2mBNgL6Kv7EISeIwW8MFLD9I8ZCizemTLi2etWPEdp6GOdzdVYZ79enP+5PcB/FAkEAhDWuyWG5DCVzKDisKXJAI12pAiGRXEP6p9t3Fx/EXtM4ymk7TuMZ07XeuC2pgkzIBYl1ITVCjhMwZx5Ts67zQQJBAKtiNyCXQNLDsB7RQ11impUrk3MPc8G3ZEyjN0jR96qJJ0p+RnAEMjadQnLOGh+zlk6h7tzZp4x5DxxmFjsn58s="


#endif
