//
//  UIToolbar+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIToolbar+GCDelegate.h"
#import "UIToolbar+GCDelegateBlock.h"

@implementation UIToolbar (GCDelegate)

- (instancetype)withBlockForPosition:(UIBarPosition (^)(UIToolbar* bar))block {
    self.blockForPosition = block;
    [self usingBlocks];
    return self;
}

@end
