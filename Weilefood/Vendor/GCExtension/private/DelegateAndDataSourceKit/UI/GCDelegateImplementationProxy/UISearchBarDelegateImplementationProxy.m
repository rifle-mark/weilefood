//
//  UISearchBarDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UISearchBarDelegateImplementationProxy.h"
#import "UISearchBar+GCDelegateBlock.h"


@interface UISearchBarDelegateImplementation : NSObject <UISearchBarDelegate>

@end


@implementation UISearchBarDelegateImplementation

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return searchBar.blockForShouldBeginEditing(searchBar);
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.blockForTextDidBeginEditing(searchBar);
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return searchBar.blockForShouldEndEditing(searchBar);
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.blockForTextDidEndEditing(searchBar);
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchBar.blockForTextDidChange(searchBar, searchText);
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return searchBar.blockForShouldChangeText(searchBar, range, text);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForSearchButtonClicked(searchBar);
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForBookmarkButtonClicked(searchBar);
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForCancelButtonClicked(searchBar);
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForResultsListButtonClicked(searchBar);
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    searchBar.blockForSelectedScopeButtonIndexDidChange(searchBar, selectedScope);
}
- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return ((UISearchBar *)bar).blockForPosition((UISearchBar *)bar);
}

@end







@implementation UISearchBarDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UISearchBarDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"searchBar:textDidChange:" : @"blockForTextDidChange",
                            @"searchBar:shouldChangeTextInRange:replacementText:" : @"blockForShouldChangeText",
                            @"searchBarShouldBeginEditing:" : @"blockForShouldBeginEditing",
                            @"searchBarTextDidBeginEditing:" : @"blockForTextDidBeginEditing",
                            @"blockForShouldEndEditing:" : @"blockForShouldEndEditing",
                            @"searchBarTextDidEndEditing:" : @"blockForTextDidEndEditing",
                            @"searchBarBookmarkButtonClicked:" : @"blockForBookmarkButtonClicked",
                            @"searchBarCancelButtonClicked:" : @"blockForCancelButtonClicked",
                            @"blockForSearchButtonClicked:" : @"blockForSearchButtonClicked",
                            @"searchBarResultsListButtonClicked:" : @"blockForResultsListButtonClicked",
                            @"searchBar:selectedScopeButtonIndexDidChange:" : @"blockForSelectedScopeButtonIndexDidChange",
                            @"positionForBar:" : @"blockForPosition",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
