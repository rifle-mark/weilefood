//
//  InputAddressView.h
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 输入收货地址视图
@interface InputAddressView : UIView

/// 姓名
@property (nonatomic, copy) NSString *name;
/// 电话
@property (nonatomic, copy) NSString *phone;
/// 省市区
@property (nonatomic, copy) NSString *city;
/// 详细地址
@property (nonatomic, copy) NSString *address;
/// 邮编
@property (nonatomic, copy) NSString *zipCode;

/**
 *  视图展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)viewHeight;

/**
 *  检查用户输入的地址是否符合要求
 *
 *  @return YES符合要求，NO不符合
 */
- (BOOL)checkInput;

@end
