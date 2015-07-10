//
//  UIWebView+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIWebView+GCDelegate.h"

#import "UIWebView+GCDelegateBlock.h"

@implementation UIWebView (GCDelegate)

- (instancetype)withBlockForShouldStartLoadRequest:(BOOL (^)(UIWebView* view, NSURLRequest* request, UIWebViewNavigationType type))block {
    self.blockForShouldStartLoadRequest = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidStartLoad:(void (^)(UIWebView* view))block {
    self.blockForDidStartLoad = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidFinishLoad:(void (^)(UIWebView* view))block {
    self.blockForDidFinishLoad = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidFailLoad:(void (^)(UIWebView* view, NSError* error))block {
    self.blockForDidFailLoad = block;
    [self usingBlocks];
    return self;
}

@end
