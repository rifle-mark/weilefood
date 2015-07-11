//
//  UIWebView+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIWebView (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |webView:shouldStartLoadWithRequest:navigationType:|
 */
GCBlockProperty BOOL (^blockForShouldStartLoadRequest)(UIWebView* webView, NSURLRequest* request, UIWebViewNavigationType type);

/**
 *  equal to -> |webViewDidStartLoad:|
 */
GCBlockProperty void (^blockForDidStartLoad)(UIWebView* webView);

/**
 *  equal to -> |webViewDidFinishLoad:|
 */
GCBlockProperty void (^blockForDidFinishLoad)(UIWebView* webView);

/**
 *  equal to -> |webView:didFailLoadWithError:|
 */
GCBlockProperty void (^blockForDidFailLoad)(UIWebView* webView, NSError* error);

@end
