//
//  AppMacro.h
//  Weilefood
//
//  Created by kelei on 15/7/16.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#ifndef Weilefood_AppMacro_h
#define Weilefood_AppMacro_h

/// 服务端地址
#define kServerUrl              @"http://web.ifeicai.com"
/// 图片服务端地址
#define kServerImageUrl         @"http://img.ifeicai.com"
/// 服务端上传图片接口地址
#define kServerUploadImageUrl   @"http://img.ifeicai.com/uploadimage.ashx"
/// 服务端上传头像并保存接口地址
#define kServerUploadAvatarUrl  @"http://img.ifeicai.com/uploadavatar.ashx"

/// CoreData数据库文件名
#define kCoreDataStoreName      @"Weilefood.sqlite"

/*
 栏目本是接口返回的，第一版先在本地固定，之后再考虑动态获取。
 */
/// 栏目ID
typedef NS_ENUM(NSInteger, kChannelID) {
    /// 无，未选中
    kChannelID_None = 0,
    
    /*
     * 市集栏目
     */
    /// 一级栏目 - 优选
    kChannelID_YX = 1,
    /// 优选子栏目 - 粮油调料
    kChannelID_YX_LYTL = 2,
    /// 优选子栏目 - 养生煲汤
    kChannelID_YX_YSBT = 3,
    /// 优选子栏目 - 特色美食
    kChannelID_YX_TSMS = 4,
    /// 优选子栏目 - 精选茶品
    kChannelID_YX_JXCP = 5,
    /// 一级栏目 - 洋货
    kChannelID_YH = 6,
    /// 一级栏目 - 餐具
    kChannelID_CJ = 7,
    
    /*
     * 预购栏目
     */
    /// 一级栏目 - 私房菜
    kChannelID_SFC = 8,
    /// 一级栏目 - 季节性商品
    kChannelID_JJXSP = 9,
};

#endif
