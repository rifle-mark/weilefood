//
//  UITextField+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITextField+GCDelegate.h"

#import "UITextField+GCDelegateBlock.h"

@implementation UITextField (GCDelegate)

- (instancetype)withBlockForShouldBeginEditing:(BOOL (^)(UITextField* view))block {
    self.blockForShouldBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidBeginEditing:(void (^)(UITextField* view))block {
    self.blockForDidBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldEndEditing:(BOOL (^)(UITextField* view))block {
    self.blockForShouldEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndEditing:(void (^)(UITextField* view))block {
    self.blockForDidEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldReplecementString:(BOOL (^)(UITextField* view, NSRange range, NSString* replecementString))block {
    self.blockForShouldReplacementString = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldClear:(BOOL (^)(UITextField* view))block {
    self.blockForShouldClear = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldReturn:(BOOL (^)(UITextField* view))block {
    self.blockForShouldReturn = block;
    [self usingBlocks];
    return self;
}

@end
