//
//  Color.h
//  LawyerCenter
//
//  Created by makewei on 15/7/17.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#ifndef LawyerCenter_ColorMacro_h
#define LawyerCenter_ColorMacro_h

#define RGB(r, g, b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

// colors definations
#define k_COLOR_TURQUOISE       RGB(49, 195, 186)
#define k_COLOR_ORANGE          RGB(249, 152, 46)
#define k_COLOR_GOLDENROD       RGB(233, 145, 20)
#define k_COLOR_WHITESMOKE      RGB(242, 242, 242)
#define k_COLOR_LAVENDER        RGB(236, 239, 239)
#define k_COLOR_DARKGRAY        RGB(208, 208, 208)
#define k_COLOR_MAROOM          RGB(64, 64, 64)
#define k_COLOR_DIMGRAY         RGB(91, 91, 91)
#define k_COLOR_CLEAR           [UIColor clearColor]
#define k_COLOR_WHITE           [UIColor whiteColor]
#define k_COLOR_BLACK           [UIColor blackColor]

/// 导航栏背景色
#define k_COLOR_THEME_NAVIGATIONBAR         k_COLOR_TURQUOISE
/// 导航栏文字色
#define k_COLOR_THEME_NAVIGATIONBAR_TEXT    [UIColor whiteColor]

#endif
