//
//  UINavigationBarDelegateImpletationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UINavigationBarDelegateImpletationProxy.h"
#import "UINavigationBar+GCDelegateBlock.h"

@interface UINavigationBarDelegateImpletation : NSObject <UINavigationBarDelegate>

@end

@implementation UINavigationBarDelegateImpletation

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    return navigationBar.blockForShouldPushItem(navigationBar, item);
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    navigationBar.blockForDidPushItem(navigationBar, item);
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    return navigationBar.blockForShouldPopItem(navigationBar, item);
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    navigationBar.blockForDidPopItem(navigationBar, item);
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return ((UINavigationBar *)bar).blockForPosition((UINavigationBar *)bar);
}


@end






@implementation UINavigationBarDelegateImpletationProxy

+ (Class)realObjectClass {
    return [UINavigationBarDelegateImpletation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"navigationBar:shouldPushItem:" : @"blockForShouldPushItem",
                            @"navigationBar:didPushItem:" : @"blockForDidPushItem",
                            @"navigationBar:shouldPopItem:" : @"blockForShouldPopItem",
                            @"navigationBar:didPopItem:" : @"blockForDidPopItem",
                            @"positionForBar:" : @"blockForPosition",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
