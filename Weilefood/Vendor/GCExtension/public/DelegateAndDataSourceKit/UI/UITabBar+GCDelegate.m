//
//  UITabBar+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabBar+GCDelegate.h"
#import "UITabBar+GCDelegateBlock.h"

@implementation UITabBar (GCDelegate)

- (instancetype)withBlockForWillBeginCustomizingItems:(void (^)(UITabBar* tabbar, NSArray* items))block {
    self.blockForWillBeginCustomizingItems = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidBeginCustomzingItems:(void (^)(UITabBar* tabbar, NSArray* items))block {
    self.blockForDidBeginCustomzingItems = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWillEndCustomizingItems:(void (^)(UITabBar* tabbar, NSArray* items, BOOL changed))block {
    self.blockForWillEndCustomizingItems = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidEndCustomzingItems:(void (^)(UITabBar* tabbar, NSArray* items, BOOL changed))block {
    self.blockForDidEndCustomzingItems = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidSelectItem:(void (^)(UITabBar* tabbar, UITabBarItem* item))block {
    self.blockForDidSelectItem = block;
    [self usingBlocks];
    return self;
}

@end
