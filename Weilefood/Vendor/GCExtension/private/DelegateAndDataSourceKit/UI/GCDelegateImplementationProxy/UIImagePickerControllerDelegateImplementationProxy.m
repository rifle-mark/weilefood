//
//  UIImagePickerControllerDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UIImagePickerControllerDelegateImplementationProxy.h"
#import "UIImagePickerController+GCDelegateBlock.h"


@interface UIImagePickerControllerDelegateImplementation : UINavigationControllerDelegateImplementation <UIImagePickerControllerDelegate>

@end

@implementation UIImagePickerControllerDelegateImplementation

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    picker.blockForDidFinishPickingMedia(picker, info);
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    picker.blockForDidCancel(picker);
}

@end







@implementation UIImagePickerControllerDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UIImagePickerControllerDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"imagePickerController:didFinishPickingMediaWithInfo:" : @"blockForDidFinishPickingMedia",
                            @"imagePickerControllerDidCancel:" : @"blockForDidCancel",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
