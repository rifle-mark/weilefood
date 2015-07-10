//
//  UIScrollView+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIScrollView+GCDelegateBlock.h"
#import "UIScrollViewDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import "NSObject+GCProxyRegister.h"

@implementation UIScrollView (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIScrollViewDelegateImplementationProxy class]];
}

@dynamic blockForDidScroll;
@dynamic blockForWillBeginDragging;
@dynamic blockForWillEndDragging;
@dynamic blockForDidEndDragging;
@dynamic blockForShouldScrollToTop;
@dynamic blockForDidScrollToTop;
@dynamic blockForWillBeginDecelerating;
@dynamic blockForDidEndDecelerating;
@dynamic blockForViewForZooming;
@dynamic blockForWillBeginZooming;
@dynamic blockForDidEndZooming;
@dynamic blockForDidZoom;
@dynamic blockForDidEndScrollingAnimation;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
