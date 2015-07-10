//
//  UISearchBar+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UISearchBar (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |searchBar:textDidChange:|
 */
GCBlockProperty void (^blockForTextDidChange)(UISearchBar* bar, NSString* searchText);

/**
 *  equal to -> |searchBar:shouldChangeTextInRange:replacementText:|
 */
GCBlockProperty BOOL (^blockForShouldChangeText)(UISearchBar* bar, NSRange range, NSString* text);

/**
 *  equal to -> |searchBarShouldBeginEditing:|
 */
GCBlockProperty BOOL (^blockForShouldBeginEditing)(UISearchBar* bar);

/**
 *  equal to -> |searchBarTextDidBeginEditing:|
 */
GCBlockProperty void (^blockForTextDidBeginEditing)(UISearchBar* bar);

/**
 *  equal to -> |searchBarShouldEndEditing:|
 */
GCBlockProperty BOOL (^blockForShouldEndEditing)(UISearchBar* bar);

/**
 *  equal to -> |searchBarTextDidEndEditing:|
 */
GCBlockProperty void (^blockForTextDidEndEditing)(UISearchBar* bar);

/**
 *  equal to -> |searchBarBookmarkButtonClicked:|
 */
GCBlockProperty void (^blockForBookmarkButtonClicked)(UISearchBar* bar);

/**
 *  equal to -> |searchBarCancelButtonClicked:|
 */
GCBlockProperty void (^blockForCancelButtonClicked)(UISearchBar* bar);

/**
 *  equal to -> |searchBarSearchButtonClicked:|
 */
GCBlockProperty void (^blockForSearchButtonClicked)(UISearchBar* bar);

/**
 *  equal to -> |searchBarResultsListButtonClicked:|
 */
GCBlockProperty void (^blockForResultsListButtonClicked)(UISearchBar* bar);

/**
 *  equal to -> |searchBar:selectedScopeButtonIndexDidChange:|
 */
GCBlockProperty void (^blockForSelectedScopeButtonIndexDidChange)(UISearchBar* bar, NSInteger selectedScope);

/**
 *  equal to -> |positionForBar:|
 */
GCBlockProperty UIBarPosition (^blockForPosition)(UISearchBar* bar);


@end
