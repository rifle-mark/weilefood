//
//  UIScrollView+Keyboard.m
//  Sunflower
//
//  Created by kelei on 15/7/5.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "UIScrollView+Keyboard.h"

@implementation UIView (_Ext)
- (instancetype)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id view = [subView findFirstResponder];
        if (view) {
            return view;
        }
    }
    return nil;
}
- (BOOL)containsTheView:(UIView *)view {
    if (self == view) {
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView containsTheView:view]) {
            return YES;
        }
    }
    return NO;
}
- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    if ([responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    }
    return nil;
}
@end

@implementation UIScrollView (Keyboard)

- (void)handleKeyboard {
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    _weak(self);
    __block BOOL handled = NO;
    [self addObserverForNotificationName:UIKeyboardWillShowNotification usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        UIView *activeField = [self findFirstResponder];
        if (activeField) {
            handled = YES;
            
            CGFloat tabBarHeight = 0;
            UIViewController *vc = [self parentViewController];
            if (vc && vc.tabBarController)
                tabBarHeight = vc.tabBarController.tabBar.frame.size.height;
            
            NSDictionary* info = [notification userInfo];
            CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
            kbSize.height -= tabBarHeight;
            
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
            self.contentInset = contentInsets;
            self.scrollIndicatorInsets = contentInsets;
            
            CGRect rect = self.bounds;
            rect.size.height -= kbSize.height;
            CGRect activeFieldFrame = [self convertRect:activeField.bounds fromView:activeField];
            if (!CGRectContainsPoint(rect, activeFieldFrame.origin)) {
                CGPoint point = CGPointMake(0, activeFieldFrame.origin.y);
                [self setContentOffset:point animated:YES];
            }
        }
    }];
    [self addObserverForNotificationName:UIKeyboardWillHideNotification usingBlock:^(NSNotification *notification) {
        _strong_check(self);
        if (handled) {
            UIEdgeInsets contentInsets = UIEdgeInsetsZero;
            self.contentInset = contentInsets;
            self.scrollIndicatorInsets = contentInsets;
            handled = NO;
        }
    }];
}

@end
