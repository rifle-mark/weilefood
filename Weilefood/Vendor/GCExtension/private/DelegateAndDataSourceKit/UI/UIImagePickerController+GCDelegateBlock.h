//
//  UIImagePickerController+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIImagePickerController (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |imagePickerController:didFinishPickingMediaWithInfo:|
 */
GCBlockProperty void (^blockForDidFinishPickingMedia)(UIImagePickerController* picker, NSDictionary* info);

/**
 *  equal to -> |imagePickerControllerDidCancel:|
 */
GCBlockProperty void (^blockForDidCancel)(UIImagePickerController* picker);

@end
