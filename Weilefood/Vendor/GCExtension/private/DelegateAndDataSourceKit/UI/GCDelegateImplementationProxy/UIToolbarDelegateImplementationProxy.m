//
//  UIToolbarDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIToolbarDelegateImplementationProxy.h"
#import "UIToolbar+GCDelegateBlock.h"

@interface UIToolbarDelegateImplementation : NSObject <UIToolbarDelegate>

@end

@implementation UIToolbarDelegateImplementation

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return ((UIToolbar *)bar).blockForPosition((UIToolbar *)bar);
}

@end








@implementation UIToolbarDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UIToolbarDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"positionForBar:" : @"blockForPosition",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
