//
//  UIImagePickerController+GCDelegate.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (GCDelegate)

/**
 *  equal to -> |imagePickerController:didFinishPickingMediaWithInfo:|
 */
- (instancetype)withBlockForDidFinishPickingMedia:(void (^)(UIImagePickerController* picker, NSDictionary* info))block;
/**
 *  equal to -> |imagePickerControllerDidCancel:|
 */
- (instancetype)withBlockForDidCancel:(void (^)(UIImagePickerController* picker))block;

@end
