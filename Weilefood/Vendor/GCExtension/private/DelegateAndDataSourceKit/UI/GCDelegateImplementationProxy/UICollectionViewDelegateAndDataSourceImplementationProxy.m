//
//  UICollectionViewDelegateAndDataSourceImplementProxy.m
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UICollectionViewDelegateAndDataSourceImplementationProxy.h"

#import "UICollectionView+GCDelegateAndDataSourceBlock.h"


@interface UICollectionViewDelegateAndDataSourceImplementation : UIScrollViewDelegateImplementation <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation UICollectionViewDelegateAndDataSourceImplementation

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView.blockForItemNumber(collectionView, section);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return collectionView.blockForSectionNumber(collectionView);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemCell(collectionView, indexPath);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForSupplementaryElement(collectionView, kind, indexPath);
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemShouldSelect(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidSelect(collectionView, indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemShouldDeselect(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidDeselect(collectionView, indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemShouldHighlight(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidHighlight(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemDidUnhighlight(collectionView, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemWillDisplay(collectionView, cell, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForSupplementaryWillDisplay(collectionView, view, elementKind, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForItemCellDidEndDisplay(collectionView, cell, indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    collectionView.blockForSupplementaryDidEndDisplay(collectionView, view, elementKind, indexPath);
}
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout {
    return collectionView.blockForLayoutTransition(collectionView, fromLayout, toLayout);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForItemMenuShouldShow(collectionView, indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return collectionView.blockForItemCanPerformAction(collectionView, action, indexPath, sender);
}
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    collectionView.blockForItemPerformAction(collectionView, action, indexPath, sender);
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.blockForFlowLayoutSize(collectionView, collectionViewLayout, indexPath);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return collectionView.blockForFlowLayoutSectionInset(collectionView, collectionViewLayout, section);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.blockForFlowLayoutSectionMinimumSpacing(collectionView, collectionViewLayout, section);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.blockForFlowLayoutSectionMinimumInteritemSpacing(collectionView, collectionViewLayout, section);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return collectionView.blockForFlowLayoutHeaderReferenceSize(collectionView, collectionViewLayout, section);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return collectionView.blockForFlowLayoutFooterReferenceSize(collectionView, collectionViewLayout, section);
}

@end







@implementation UICollectionViewDelegateAndDataSourceImplementationProxy

+ (Class)realObjectClass {
    return [UICollectionViewDelegateAndDataSourceImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"collectionView:numberOfItemsInSection:" : @"blockForItemNumber",
                            @"numberOfSectionsInCollectionView:" : @"blockForSectionNumber",
                            @"collectionView:cellForItemAtIndexPath:" : @"blockForItemCell",
                            @"collectionView:viewForSupplementaryElementOfKind:atIndexPath:" : @"blockForSupplementaryElement",
                            @"collectionView:shouldSelectItemAtIndexPath:" : @"blockForItemShouldSelect",
                            @"collectionView:didSelectItemAtIndexPath:" : @"blockForItemDidSelect",
                            @"collectionView:shouldDeselectItemAtIndexPath:" : @"blockForItemShouldDeselect",
                            @"collectionView:didDeselectItemAtIndexPath:" : @"blockForItemDidDeselect",
                            @"collectionView:shouldHighlightItemAtIndexPath:" : @"blockForItemShouldHighlight",
                            @"collectionView:didHighlightItemAtIndexPath:" : @"blockForItemDidHighlight",
                            @"collectionView:didUnhighlightItemAtIndexPath:" : @"blockForItemDidUnhighlight",
                            @"collectionView:willDisplayCell:forItemAtIndexPath:" : @"blockForItemWillDisplay",
                            @"collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:" : @"blockForSupplementaryWillDisplay",
                            @"collectionView:didEndDisplayingCell:forItemAtIndexPath:" : @"blockForItemCellDidEndDisplay",
                            @"collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:" : @"blockForSupplementaryDidEndDisplay",
                            @"collectionView:transitionLayoutForOldLayout:newLayout:" : @"blockForLayoutTransition",
                            @"collectionView:shouldShowMenuForItemAtIndexPath" : @"blockForItemMenuShouldShow",
                            @"collectionView:canPerformAction:forItemAtIndexPath:withSender:" : @"blockForItemCanPerformAction",
                            @"collectionView:performAction:forItemAtIndexPath:withSender:" : @"blockForItemPerformAction",
                            
                            @"collectionView:layout:sizeForItemAtIndexPath:" : @"blockForFlowLayoutSize",
                            @"collectionView:layout:insetForSectionAtIndex:" : @"blockForFlowLayoutSectionInset",
                            @"collectionView:layout:minimumLineSpacingForSectionAtIndex:" : @"blockForFlowLayoutSectionMinimumSpacing",
                            @"collectionView:layout:minimumInteritemSpacingForSectionAtIndex:" : @"blockForFlowLayoutSectionMinimumInteritemSpacing",
                            @"collectionView:layout:referenceSizeForHeaderInSection:" : @"blockForFlowLayoutHeaderReferenceSize",
                            @"collectionView:layout:referenceSizeForFooterInSection:" : @"blockForFlowLayoutFooterReferenceSize",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
