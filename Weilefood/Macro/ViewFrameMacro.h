//
//  ViewFrameMacro.h
//  LawyerCenter
//
//  Created by makewei on 15/7/17.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#ifndef LawyerCenter_ViewFrameMacro_h
#define LawyerCenter_ViewFrameMacro_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define k1pxWidth   0.5

#define V_X0(v) CGRectGetMinX(v.frame)
#define V_Y0(v) CGRectGetMinY(v.frame)
#define V_X1(v) CGRectGetMaxX(v.frame)
#define V_Y1(v) CGRectGetMaxY(v.frame)
#define V_XM(v) CGRectGetMidX(v.frame)
#define V_YM(v) CGRectGetMidY(v.frame)
#define V_W_(v) CGRectGetWidth(v.bounds)
#define V_WM_(v) CGRectGetMidX(v.bounds)
#define V_HM_(v) CGRectGetMidY(v.bounds)
#define V_H_(v) CGRectGetHeight(v.bounds)

#define ccs(w, h) CGSizeMake(w, h)
#define ccp(x, y) CGPointMake(x, y)

#endif
