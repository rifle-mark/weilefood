//
//  UIWebViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 11/7/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UIWebViewDelegateImplementationProxy.h"

#import "UIWebView+GCDelegateBlock.h"

@interface UIWebViewDelegateImplementation : NSObject <UIWebViewDelegate>

@end


@implementation UIWebViewDelegateImplementation

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return webView.blockForShouldStartLoadRequest(webView, request, navigationType);
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    webView.blockForDidStartLoad(webView);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    webView.blockForDidFinishLoad(webView);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    webView.blockForDidFailLoad(webView, error);
}

@end







@implementation UIWebViewDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UIWebViewDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"webView:shouldStartLoadWithRequest:navigationType:" : @"blockForShouldStartLoadRequest",
                            @"webViewDidStartLoad:" : @"blockForDidStartLoad",
                            @"webViewDidFinishLoad:" : @"blockForDidFinishLoad",
                            @"webView:didFailLoadWithError" : @"blockForDidFailLoad",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
