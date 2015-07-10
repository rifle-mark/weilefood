//
//  UISearchBar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UISearchBar+GCDelegateBlock.h"
#import "UISearchBarDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UISearchBar (GCDelegateBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UISearchBarDelegateImplementationProxy class]];
}

@dynamic blockForTextDidChange;
@dynamic blockForShouldChangeText;
@dynamic blockForShouldBeginEditing;
@dynamic blockForTextDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForTextDidEndEditing;
@dynamic blockForBookmarkButtonClicked;
@dynamic blockForCancelButtonClicked;
@dynamic blockForSearchButtonClicked;
@dynamic blockForResultsListButtonClicked;
@dynamic blockForSelectedScopeButtonIndexDidChange;
@dynamic blockForPosition;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
