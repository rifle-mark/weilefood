//
//  UINavigationBar+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UINavigationBar+GCDelegate.h"
#import "UINavigationBar+GCDelegateBlock.h"

@implementation UINavigationBar (GCDelegate)

- (instancetype)withBlockForShouldPushItem:(BOOL (^)(UINavigationBar* bar, UINavigationItem* item))block {
    self.blockForShouldPushItem = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidPushItem:(void (^)(UINavigationBar* bar, UINavigationItem* item))block {
    self.blockForDidPushItem = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldPopItem:(BOOL (^)(UINavigationBar* bar, UINavigationItem* item))block {
    self.blockForShouldPopItem = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidPopItem:(void (^)(UINavigationBar* bar, UINavigationItem* item))block {
    self.blockForDidPopItem = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForPosition:(UIBarPosition (^)(UINavigationBar* bar))block {
    self.blockForPosition = block;
    [self usingBlocks];
    return self;
}

@end
