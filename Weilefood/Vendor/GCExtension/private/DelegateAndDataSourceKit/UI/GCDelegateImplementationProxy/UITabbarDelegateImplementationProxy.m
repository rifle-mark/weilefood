//
//  UITabbarDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabbarDelegateImplementationProxy.h"
#import "UITabBar+GCDelegateBlock.h"


@interface UITabbarDelegateImplementation : NSObject <UITabBarDelegate>

@end

@implementation UITabbarDelegateImplementation

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    tabBar.blockForDidSelectItem(tabBar, item);
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray *)items {
    tabBar.blockForWillBeginCustomizingItems(tabBar, items);
}
- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items {
    tabBar.blockForDidBeginCustomzingItems(tabBar, items);
}
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed {
    tabBar.blockForWillEndCustomizingItems(tabBar, items, changed);
}
- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed {
    tabBar.blockForDidEndCustomzingItems(tabBar, items, changed);
}

@end








@implementation UITabbarDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UITabbarDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"tabBar:willBeginCustomizingItems:" : @"blockForWillBeginCustomizingItems",
                            @"tabBar:didBeginCustomizingItems:" : @"blockForDidBeginCustomzingItems",
                            @"tabBar:willEndCustomizingItems:changed:" : @"blockForWillEndCustomizingItems",
                            @"tabBar:didEndCustomizingItems:changed:" : @"blockForDidEndCustomzingItems",
                            @"tabBar:didSelectItem:" : @"blockForDidSelectItem",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
