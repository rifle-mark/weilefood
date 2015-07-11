//
//  UIImagePickerController+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UIImagePickerController+GCDelegateBlock.h"

#import "UIImagePickerControllerDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UIImagePickerController (GCDelegateBlock)


- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIImagePickerControllerDelegateImplementationProxy class]];
}


@dynamic blockForDidFinishPickingMedia;
@dynamic blockForDidCancel;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
