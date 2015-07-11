//
//  UINavigationBar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UINavigationBar+GCDelegateBlock.h"
#import "UINavigationBarDelegateImpletationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UINavigationBar (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UINavigationBarDelegateImpletationProxy class]];
}


@dynamic blockForShouldPushItem;
@dynamic blockForDidPushItem;
@dynamic blockForShouldPopItem;
@dynamic blockForDidPopItem;
@dynamic blockForPosition;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
