//
//  UITableViewDelegateAndDataSourceImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 10/14/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UITableViewDelegateAndDataSourceImplementationProxy.h"

#import "UITableView+GCDelegateAndDataSourceBlock.h"

@interface UITableViewDelegateAndDataSourceImplementation : UIScrollViewDelegateImplementation <UITableViewDelegate, UITableViewDataSource>

@end

@implementation UITableViewDelegateAndDataSourceImplementation

#pragma mark - UITableView Datasource method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowCell(tableView, indexPath);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.blockForSectionNumber(tableView);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.blockForRowNumber(tableView, section);
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return tableView.blockForSectionIndexTitles(tableView);
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return tableView.blockForSectionIndex(tableView, title, index);
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterTitle(tableView, section);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderTitle(tableView, section);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowCommitEditStyleForRow(tableView, editingStyle, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowCanEditRow(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowCanMoveRow(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    tableView.blockForRowMove(tableView, sourceIndexPath, destinationIndexPath);
}

#pragma mark - UITableView Delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowHeight(tableView, indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowEstimatedHeight(tableView, indexPath);
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowIndentationLevel(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowCellWillDisplay(tableView, cell, indexPath);
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowEditActions(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowAccessoryButtonTapped(tableView, indexPath);
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowWillSelect(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidSelect(tableView, indexPath);
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowWillDeselect(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidDeselecte(tableView, indexPath);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderView(tableView, section);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterView(tableView, section);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderHeight(tableView, section);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return tableView.blockForHeaderEstimatedHeight(tableView, section);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterHeight(tableView, section);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return tableView.blockForFooterEstimatedHeight(tableView, section);
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForHeaderViewWillDisplay(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForFooterViewWillDisplay(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowWillBeginEditing(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidEndEditing(tableView, indexPath);
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowEditingStyle(tableView, indexPath);
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowDeleteConfirmationButtonTitle(tableView, indexPath);
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowShouldIndentWhileEditing(tableView, indexPath);
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return tableView.blockForRowMoveTargetIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidEndDisplayingCell(tableView, cell, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForHeaderViewDidEndDisplaying(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    tableView.blockForFooterViewDidEndDisplaying(tableView, view, section);
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowShouldShowMenu(tableView, indexPath);
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return tableView.blockForRowCanPerformAction(tableView, action, indexPath, sender);
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    tableView.blockForRowPerformAction(tableView, action, indexPath, sender);
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.blockForRowShouldHighlight(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidHighlight(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.blockForRowDidUnhighlight(tableView, indexPath);
}

@end




@implementation UITableViewDelegateAndDataSourceImplementationProxy

+ (Class)realObjectClass {
    return [UITableViewDelegateAndDataSourceImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"tableView:cellForRowAtIndexPath:" : @"blockForRowCell",
                            @"numberOfSectionsInTableView:" : @"blockForSectionNumber",
                            @"tableView:numberOfRowsInSection:" : @"blockForRowNumber",
                            @"sectionIndexTitlesForTableView:" : @"blockForSectionIndexTitles",
                            @"tableView:sectionForSectionIndexTitle:atIndex:" : @"blockForSectionIndex",
                            @"tableView:titleForFooterInSection:" : @"blockForFooterTitle",
                            @"tableView:titleForHeaderInSection:" : @"blockForHeaderTitle",
                            @"tableView:commitEditingStyle:forRowAtIndexPath:" : @"blockForRowCommitEditStyleForRow",
                            @"tableView:canEditRowAtIndexPath:" : @"blockForRowCanEditRow",
                            @"tableView:canMoveRowAtIndexPath:" : @"blockForRowCanMoveRow",
                            @"tableView:moveRowAtIndexPath:toIndexPath:" : @"blockForRowMove",
                            @"tableView:heightForRowAtIndexPath:" : @"blockForRowHeight",
                            @"tableView:estimatedHeightForRowAtIndexPath:" : @"blockForRowEstimatedHeight",
                            @"tableView:indentationLevelForRowAtIndexPath:" : @"blockForRowIndentationLevel",
                            @"tableView:willDisplayCell:forRowAtIndexPath:" : @"blockForRowCellWillDisplay",
                            @"tableView:editActionsForRowAtIndexPath:" : @"blockForRowEditActions",
                            @"tableView:accessoryButtonTappedForRowWithIndexPath:" : @"blockForRowAccessoryButtonTapped",
                            @"tableView:willSelectRowAtIndexPath:" : @"blockForRowWillSelect",
                            @"tableView:didSelectRowAtIndexPath:" : @"blockForRowDidSelect",
                            @"tableView:willDeselectRowAtIndexPath:" : @"blockForRowWillDeselect",
                            @"tableView:didDeselectRowAtIndexPath:" : @"blockForRowDidDeselecte",
                            @"tableView:viewForHeaderInSection:" : @"blockForHeaderView",
                            @"tableView:viewForFooterInSection:" : @"blockForFooterView",
                            @"tableView:heightForHeaderInSection:" : @"blockForHeaderHeight",
                            @"tableView:estimatedHeightForHeaderInSection:" : @"blockForHeaderEstimatedHeight",
                            @"tableView:heightForFooterInSection:" : @"blockForFooterHeight",
                            @"tableView:estimatedHeightForFooterInSection:" : @"blockForFooterEstimatedHeight",
                            @"tableView:willDisplayHeaderView:forSection:" : @"blockForHeaderViewWillDisplay",
                            @"tableView:willDisplayFooterView:forSection:" : @"blockForFooterViewWillDisplay",
                            @"tableView:willBeginEditingRowAtIndexPath:" : @"blockForRowWillBeginEditing",
                            @"tableView:didEndEditingRowAtIndexPath:" : @"blockForRowDidEndEditing",
                            @"tableView:editingStyleForRowAtIndexPath:" : @"blockForRowEditingStyle",
                            @"tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:" : @"blockForRowDeleteConfirmationButtonTitle",
                            @"tableView:shouldIndentWhileEditingRowAtIndexPath:" : @"blockForRowShouldIndentWhileEditing",
                            @"tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:" : @"blockForRowMoveTargetIndexPath",
                            @"tableView:didEndDisplayingCell:forRowAtIndexPath:" : @"blockForRowDidEndDisplayingCell",
                            @"tableView:didEndDisplayingHeaderView:forSection:" : @"blockForHeaderViewDidEndDisplaying",
                            @"tableView:didEndDisplayingFooterView:forSection:" : @"blockForFooterViewDidEndDisplaying",
                            @"tableView:shouldShowMenuForRowAtIndexPath:" : @"blockForRowShouldShowMenu",
                            @"tableView:canPerformAction:forRowAtIndexPath:withSender:" : @"blockForRowCanPerformAction",
                            @"tableView:performAction:forRowAtIndexPath:withSender:" : @"blockForRowPerformAction",
                            @"tableView:shouldHighlightRowAtIndexPath:" : @"blockForRowShouldHighlight",
                            @"tableView:didHighlightRowAtIndexPath:" : @"blockForRowDidHighlight",
                            @"tableView:didUnhighlightRowAtIndexPath:" : @"blockForRowDidUnhighlight",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end