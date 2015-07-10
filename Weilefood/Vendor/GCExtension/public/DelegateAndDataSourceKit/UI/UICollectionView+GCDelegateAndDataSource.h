//
//  UICollectionView+GCDelegateAndDataSource.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (GCDelegateAndDataSource)

/**
 *  equal to -> |collectionView:numberOfItemsInSection:|
 */
- (instancetype)withBlockForItemNumber:(NSInteger (^)(UICollectionView* view, NSInteger section))block;

/**
 *  equal to -> |numberOfSectionsInCollectionView:|
 */
- (instancetype)withBlockForSectionNumber:(NSInteger (^)(UICollectionView* view))block;

/**
 *  equal to -> |collectionView:cellForItemAtIndexPath:|
 */
- (instancetype)withBlockForItemCell:(UICollectionViewCell* (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:viewForSupplementaryElementOfKind:atIndexPath:|
 */
- (instancetype)withBlockForSupplementaryElement:(UICollectionReusableView* (^)(UICollectionView* view, NSString* kind, NSIndexPath* path))block;




/**
 *  equal to -> |collectionView:shouldSelectItemAtIndexPath:|
 */
- (instancetype)withBlockForItemShouldSelect:(BOOL (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:didSelectItemAtIndexPath:|
 */
- (instancetype)withBlockForItemDidSelect:(void (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:shouldDeselectItemAtIndexPath:|
 */
- (instancetype)withBlockForItemShouldDeselect:(BOOL (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:didDeselectItemAtIndexPath:|
 */
- (instancetype)withBlockForItemDidDeselect:(void (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:shouldHighlightItemAtIndexPath:|
 */
- (instancetype)withBlockForItemShouldHighlight:(BOOL (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:didHighlightItemAtIndexPath:|
 */
- (instancetype)withBlockForItemDidHighlight:(void (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:didUnhighlightItemAtIndexPath:|
 */
- (instancetype)withBlockForItemDidUnhighlight:(void (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:willDisplayCell:forItemAtIndexPath:|
 */
- (instancetype)withBlockForItemWillDisplay:(void (^)(UICollectionView* view, UICollectionViewCell* cell, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:|
 */
- (instancetype)withBlockForSupplementaryWillDisplay:(void (^)(UICollectionView* view, UICollectionReusableView* reusableView, NSString* elementKind, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:didEndDisplayingCell:forItemAtIndexPath:|
 */
- (instancetype)withBlockForItemCellDidEndDisplay:(void (^)(UICollectionView* view, UICollectionViewCell* cell, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:|
 */
- (instancetype)withBlockForSupplementaryDidEndDisplay:(void (^)(UICollectionView* view, UICollectionReusableView* reusableView, NSString* elementKind, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:transitionLayoutForOldLayout:newLayout:|
 */
- (instancetype)withBlockForLayoutTransition:(UICollectionViewTransitionLayout* (^)(UICollectionView* view, UICollectionViewLayout* fromLayout, UICollectionViewLayout* toLayout))block;

/**
 *  equal to -> |collectionView:shouldShowMenuForItemAtIndexPath:|
 */
- (instancetype)withBlockForItemMenuShouldShow:(BOOL (^)(UICollectionView* view, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:canPerformAction:forItemAtIndexPath:withSender:|
 */
- (instancetype)withBlockForItemCanPerformAction:(BOOL (^)(UICollectionView* view, SEL action, NSIndexPath* path, id sender))block;

/**
 *  equal to -> |collectionView:performAction:forItemAtIndexPath:withSender:|
 */
- (instancetype)withBlockForItemPerformAction:(void (^)(UICollectionView* view, SEL action, NSIndexPath* path, id sender))block;





/**
 *  equal to -> |collectionView:layout:sizeForItemAtIndexPath:|
 */
- (instancetype)withBlockForFlowlayoutSize:(CGSize (^)(UICollectionView* view, UICollectionViewLayout* layout, NSIndexPath* path))block;

/**
 *  equal to -> |collectionView:layout:insetForSectionAtIndex:|
 */
- (instancetype)withBlockForFlowLayoutSectionInset:(UIEdgeInsets (^)(UICollectionView* view, UICollectionViewLayout* layout, NSInteger section))block;

/**
 *  equal to -> |collectionView:layout:minimumLineSpacingForSectionAtIndex:|
 */
- (instancetype)withBlockForFlowLayoutSectionMinimumSpacing:(CGFloat (^)(UICollectionView* view, UICollectionViewLayout* layout, NSInteger section))block;

/**
 *  equal to -> |collectionView:layout:minimumInteritemSpacingForSectionAtIndex:|
 */
- (instancetype)withBlockForFlowLayoutSectionMinimumInteritemSpacing:(CGFloat (^)(UICollectionView* view, UICollectionViewLayout* layout, NSInteger section))block;

/**
 *  equal to -> |collectionView:layout:referenceSizeForHeaderInSection:|
 */
- (instancetype)withBlockForFlowLayoutHeaderReferenceSize:(CGSize (^)(UICollectionView* view, UICollectionViewLayout* layout, NSInteger section))block;

/**
 *  equal to -> |collectionView:layout:referenceSizeForFooterInSection:|
 */
- (instancetype)withBlockForFlowLayoutFooterReferenceSize:(CGSize (^)(UICollectionView* view, UICollectionViewLayout* layout, NSInteger section))block;


@end
