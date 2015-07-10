//
//  UITabBar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabBar+GCDelegateBlock.h"

#import "UITabbarDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UITabBar (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UITabbarDelegateImplementationProxy class]];
}


@dynamic blockForWillBeginCustomizingItems;
@dynamic blockForDidBeginCustomzingItems;
@dynamic blockForWillEndCustomizingItems;
@dynamic blockForDidEndCustomzingItems;
@dynamic blockForDidSelectItem;

+ (void)load {
    [self extensionAccessorGenerator];
}


@end
