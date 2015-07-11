//
//  UIWebView+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (GCDelegate)

/**
 *  equal to -> |webView:shouldStartLoadWithRequest:navigationType:|
 */
- (instancetype)withBlockForShouldStartLoadRequest:(BOOL (^)(UIWebView* view, NSURLRequest* request, UIWebViewNavigationType type))block;

/**
 *  equal to -> |webViewDidStartLoad:|
 */
- (instancetype)withBlockForDidStartLoad:(void (^)(UIWebView* view))block;

/**
 *  equal to -> |webViewDidFinishLoad:|
 */
- (instancetype)withBlockForDidFinishLoad:(void (^)(UIWebView* view))block;

/**
 *  equal to -> |webView:didFailLoadWithError:|
 */
- (instancetype)withBlockForDidFailLoad:(void (^)(UIWebView* view, NSError* error))block;

@end
