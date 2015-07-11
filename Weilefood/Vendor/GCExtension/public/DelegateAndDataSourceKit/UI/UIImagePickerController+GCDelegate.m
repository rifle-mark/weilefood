//
//  UIImagePickerController+GCDelegate.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UIImagePickerController+GCDelegate.h"

#import "UIImagePickerController+GCDelegateBlock.h"

@implementation UIImagePickerController (GCDelegate)

- (instancetype)withBlockForDidFinishPickingMedia:(void (^)(UIImagePickerController *, NSDictionary *))block {
    self.blockForDidFinishPickingMedia = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidCancel:(void (^)(UIImagePickerController *))block {
    self.blockForDidCancel = block;
    [self usingBlocks];
    return self;
}

@end
