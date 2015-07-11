//
//  UISearchBar+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UISearchBar+GCDelegate.h"
#import "UISearchBar+GCDelegateBlock.h"

@implementation UISearchBar (GCDelegate)

- (instancetype)withBlockForTextDidChange:(void (^)(UISearchBar* bar, NSString* searchText))block {
    self.blockForTextDidChange = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldChangeText:(BOOL (^)(UISearchBar* bar, NSRange range, NSString* text))block {
    self.blockForShouldChangeText = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldBeginEditing:(BOOL (^)(UISearchBar* bar))block {
    self.blockForShouldBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForTextDidBeginEditing:(void (^)(UISearchBar* bar))block {
    self.blockForTextDidBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForShouldEndEditing:(BOOL (^)(UISearchBar* bar))block {
    self.blockForShouldEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForTextDidEndEditing:(void (^)(UISearchBar* bar))block {
    self.blockForTextDidEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForBookmarkButtonClicked:(void (^)(UISearchBar* bar))block {
    self.blockForBookmarkButtonClicked = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForCancelButtonClicked:(void (^)(UISearchBar* bar))block {
    self.blockForCancelButtonClicked = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSearchButtonClicked:(void (^)(UISearchBar* bar))block {
    self.blockForSearchButtonClicked = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForResultsListButtonClicked:(void (^)(UISearchBar* bar))block {
    self.blockForResultsListButtonClicked = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSelectedScopeButtonIndexDidChange:(void (^)(UISearchBar* bar, NSInteger selectedScope))block {
    self.blockForSelectedScopeButtonIndexDidChange = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForPosition:(UIBarPosition (^)(UISearchBar* bar))block {
    self.blockForPosition = block;
    [self usingBlocks];
    return self;
}

@end
