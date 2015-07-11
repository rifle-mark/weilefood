//
//  UIPopoverController+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPopoverController+GCDelegateBlock.h"
#import "UIPopoverControllerImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UIPopoverController (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIPopoverControllerImplementationProxy class]];
}

@dynamic blockForWillRepositionToRectInView;
@dynamic blockForShouldDismiss;
@dynamic blockForDidDismiss;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
