//
//  GCAlertView.h
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCAlertView : UIView

@property(nonatomic,readonly,getter=isVisible) BOOL visible;

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message;

- (void)setCancelButtonWithTitle:(NSString *)cancelTitle actionBlock:(void(^)())cancelBlock;
- (void)addOtherButtonWithTitle:(NSString *)otherTitle actionBlock:(void(^)())otherBlock;

- (void)show;

@end
