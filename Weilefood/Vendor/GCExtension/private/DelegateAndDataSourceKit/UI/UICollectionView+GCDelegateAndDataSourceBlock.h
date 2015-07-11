//
//  UICollectionView+GCDelegateAndDataSourceBlock.h
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UICollectionView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks;

/**
 *  equal to -> |collectionView:numberOfItemsInSection:|
 */
GCBlockProperty NSInteger (^blockForItemNumber)(UICollectionView* collectionView, NSInteger section);

/**
 *  equal to -> |numberOfSectionsInCollectionView:|
 */
GCBlockProperty NSInteger (^blockForSectionNumber)(UICollectionView* collectionView);

/**
 *  equal to -> |collectionView:cellForItemAtIndexPath:|
 */
GCBlockProperty UICollectionViewCell* (^blockForItemCell)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:viewForSupplementaryElementOfKind:atIndexPath:|
 */
GCBlockProperty UICollectionReusableView* (^blockForSupplementaryElement)(UICollectionView* collectionView, NSString* kind, NSIndexPath* indexPath);




/**
 *  equal to -> |collectionView:shouldSelectItemAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForItemShouldSelect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didSelectItemAtIndexPath:|
 */
GCBlockProperty void (^blockForItemDidSelect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:shouldDeselectItemAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForItemShouldDeselect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didDeselectItemAtIndexPath:|
 */
GCBlockProperty void (^blockForItemDidDeselect)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:shouldHighlightItemAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForItemShouldHighlight)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didHighlightItemAtIndexPath:|
 */
GCBlockProperty void (^blockForItemDidHighlight)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didUnhighlightItemAtIndexPath:|
 */
GCBlockProperty void (^blockForItemDidUnhighlight)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:willDisplayCell:forItemAtIndexPath:|
 */
GCBlockProperty void (^blockForItemWillDisplay)(UICollectionView* collectionView, UICollectionViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:|
 */
GCBlockProperty void (^blockForSupplementaryWillDisplay)(UICollectionView* collectionView, UICollectionReusableView* view, NSString* elementKind, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didEndDisplayingCell:forItemAtIndexPath:|
 */
GCBlockProperty void (^blockForItemCellDidEndDisplay)(UICollectionView* collectionView, UICollectionViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:|
 */
GCBlockProperty void (^blockForSupplementaryDidEndDisplay)(UICollectionView* collectionView, UICollectionReusableView* view, NSString* elementKind, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:transitionLayoutForOldLayout:newLayout:|
 */
GCBlockProperty UICollectionViewTransitionLayout* (^blockForLayoutTransition)(UICollectionView* collectionView, UICollectionViewLayout* fromLayout, UICollectionViewLayout* toLayout);

/**
 *  equal to -> |collectionView:shouldShowMenuForItemAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForItemMenuShouldShow)(UICollectionView* collectionView, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:canPerformAction:forItemAtIndexPath:withSender:|
 */
GCBlockProperty BOOL (^blockForItemCanPerformAction)(UICollectionView* collectionView, SEL action, NSIndexPath* indexPath, id sender);

/**
 *  equal to -> |collectionView:performAction:forItemAtIndexPath:withSender:|
 */
GCBlockProperty void (^blockForItemPerformAction)(UICollectionView* collectionView, SEL action, NSIndexPath* indexPath, id sender);





/**
 *  equal to -> |collectionView:layout:sizeForItemAtIndexPath:|
 */
GCBlockProperty CGSize (^blockForFlowLayoutSize)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSIndexPath* indexPath);

/**
 *  equal to -> |collectionView:layout:insetForSectionAtIndex:|
 */
GCBlockProperty UIEdgeInsets (^blockForFlowLayoutSectionInset)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSInteger section);

/**
 *  equal to -> |collectionView:layout:minimumLineSpacingForSectionAtIndex:|
 */
GCBlockProperty CGFloat (^blockForFlowLayoutSectionMinimumSpacing)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSInteger section);

/**
 *  equal to -> |collectionView:layout:minimumInteritemSpacingForSectionAtIndex:|
 */
GCBlockProperty CGFloat (^blockForFlowLayoutSectionMinimumInteritemSpacing)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSInteger section);

/**
 *  equal to -> |collectionView:layout:referenceSizeForHeaderInSection:|
 */
GCBlockProperty CGSize (^blockForFlowLayoutHeaderReferenceSize)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSInteger section);

/**
 *  equal to -> |collectionView:layout:referenceSizeForFooterInSection:|
 */
GCBlockProperty CGSize (^blockForFlowLayoutFooterReferenceSize)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSInteger section);

@end
