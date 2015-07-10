//
//  UISearchBar+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (GCDelegate)

/**
 *  equal to -> |searchBar:textDidChange:|
 */
- (instancetype)withBlockForTextDidChange:(void (^)(UISearchBar* bar, NSString* searchText))block;

/**
 *  equal to -> |searchBar:shouldChangeTextInRange:replacementText:|
 */
- (instancetype)withBlockForShouldChangeText:(BOOL (^)(UISearchBar* bar, NSRange range, NSString* text))block;

/**
 *  equal to -> |searchBarShouldBeginEditing:|
 */
- (instancetype)withBlockForShouldBeginEditing:(BOOL (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarTextDidBeginEditing:|
 */
- (instancetype)withBlockForTextDidBeginEditing:(void (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarShouldEndEditing:|
 */
- (instancetype)withBlockForShouldEndEditing:(BOOL (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarTextDidEndEditing:|
 */
- (instancetype)withBlockForTextDidEndEditing:(void (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarBookmarkButtonClicked:|
 */
- (instancetype)withBlockForBookmarkButtonClicked:(void (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarCancelButtonClicked:|
 */
- (instancetype)withBlockForCancelButtonClicked:(void (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarSearchButtonClicked:|
 */
- (instancetype)withBlockForSearchButtonClicked:(void (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBarResultsListButtonClicked:|
 */
- (instancetype)withBlockForResultsListButtonClicked:(void (^)(UISearchBar* bar))block;

/**
 *  equal to -> |searchBar:selectedScopeButtonIndexDidChange:|
 */
- (instancetype)withBlockForSelectedScopeButtonIndexDidChange:(void (^)(UISearchBar* bar, NSInteger selectedScope))block;

/**
 *  equal to -> |positionForBar:|
 */
- (instancetype)withBlockForPosition:(UIBarPosition (^)(UISearchBar* bar))block;

@end
