//
//  GCPageViewController.h
//  GCPagerExtension
//
//  Created by zhoujinqiang on 15/1/28.
//  Copyright (c) 2015年 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPageView.h"

@interface GCPageViewController : UIViewController

- (instancetype)initWithMode:(GCPageMode)mode;

- (instancetype)withBlockForPageControllerCount:(NSUInteger (^)(GCPageViewController* controller))block;
- (instancetype)withBlockForPageController:(UIViewController* (^)(GCPageViewController* controller, NSUInteger index))block;
- (instancetype)withBlockForPageControllerDidEndDisplay:(void (^)(GCPageViewController* controller, NSUInteger index))block;
- (instancetype)withLeftBorderAction:(void (^)())leftBorderAction;
- (instancetype)withRightBorderAction:(void (^)())rightBorderAction;

- (void)reloadData;

- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation;

@end
