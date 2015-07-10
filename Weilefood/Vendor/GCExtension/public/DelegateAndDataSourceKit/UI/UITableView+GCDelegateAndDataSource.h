//
//  UITableView+GCDelegateAndDataSource.h
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (GCDelegateAndDataSource)

/**
 *  equal to -> |tableView:cellForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowCell:(UITableViewCell* (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |numberOfSectionsInTableView:|
 */
- (instancetype)withBlockForSectionNumber:(NSInteger (^)(UITableView* view))block;

/**
 *  equal to -> |tableView:numberOfRowsInSection:|
 */
- (instancetype)withBlockForRowNumber:(NSInteger (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |sectionIndexTitlesForTableView:|
 */
- (instancetype)withBlockForSectionIndexTitles:(NSArray* (^)(UITableView* view))block;

/**
 *  equal to -> |tableView:sectionForSectionIndexTitle:atIndex:|
 */
- (instancetype)withBlockForSectionIndex:(NSInteger (^)(UITableView* view, NSString* title, NSInteger index))block;

/**
 *  equal to -> |tableView:titleForFooterInSection:|
 */
- (instancetype)withBlockForFooterTitle:(NSString* (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:titleForHeaderInSection:|
 */
- (instancetype)withBlockForHeaderTitle:(NSString* (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:commitEditingStyle:forRowAtIndexPath:|
 */
- (instancetype)withBlockForRowCommitEditStyleForRow:(void (^)(UITableView* view, UITableViewCellEditingStyle style, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:canEditRowAtIndexPath:|
 */
- (instancetype)withBlockForRowCanEdit:(BOOL (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:canMoveRowAtIndexPath:|
 */
- (instancetype)withBlockForRowCanMove:(BOOL (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:moveRowAtIndexPath:toIndexPath:|
 */
- (instancetype)withBlockForRowMove:(void (^)(UITableView* view, NSIndexPath* fromPath, NSIndexPath* toPath))block;







#pragma mark - delegate property

/**
 *  equal to -> |tableView:heightForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowHeight:(CGFloat (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:estimatedHeightForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowEstimatedHeight:(CGFloat (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:indentationLevelForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowIndentationLevel:(NSInteger (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:willDisplayCell:forRowAtIndexPath:|
 */
- (instancetype)withBlockForRowCellWillDisplay:(void (^)(UITableView* view, UITableViewCell* cell, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:editActionsForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowEditActions:(NSArray* (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  euqal to -> |tableView:accessoryButtonTappedForRowWithIndexPath:|
 */
- (instancetype)withBlockForRowAccessoryButtonTapped:(void (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:willSelectRowAtIndexPath:|
 */
- (instancetype)withBlockForRowWillSelect:(NSIndexPath* (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:didSelectRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDidSelect:(void (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:willDeselectRowAtIndexPath:|
 */
- (instancetype)withBlockForRowWillDeselect:(NSIndexPath* (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:didDeselectRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDidDeselect:(void (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:viewForHeaderInSection:|
 */
- (instancetype)withBlockForHeaderView:(UIView* (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:viewForFooterInSection:|
 */
- (instancetype)withBlockForFooterView:(UIView* (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:heightForHeaderInSection:|
 */
- (instancetype)withBlockForHeaderHeight:(CGFloat (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:estimatedHeightForHeaderInSection:|
 */
- (instancetype)withBlockForHeaderEstimatedHeight:(CGFloat (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:heightForFooterInSection:|
 */
- (instancetype)withBlockForFooterHeight:(CGFloat (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:estimatedHeightForFooterInSection:|
 */
- (instancetype)withBlockForFooterEstimatedHeight:(CGFloat (^)(UITableView* view, NSInteger section))block;

/**
 *  equal to -> |tableView:willDisplayHeaderView:forSection:|
 */
- (instancetype)withBlockForHeaderViewWillDisplay:(void (^)(UITableView* view, UIView* headerView, NSInteger section))block;

/**
 *  equal to -> |tableView:willDisplayFooterView:forSection:|
 */
- (instancetype)withBlockForFooterViewWillDisplay:(void (^)(UITableView* view, UIView* footerView, NSInteger section))block;

/**
 *  equal to -> |tableView:willBeginEditingRowAtIndexPath:|
 */
- (instancetype)withBlockForRowWillBeginEditing:(void (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:didEndEditingRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDidEditing:(void (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:editingStyleForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowEditingStyle:(UITableViewCellEditingStyle (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDeleteConfirmationButtonTitle:(NSString* (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:shouldIndentWhileEditingRowAtIndexPath:|
 */
- (instancetype)withBlockForRowShouldIndentWhileEditing:(BOOL (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:|
 */
- (instancetype)withBlockForRowMoveTargetIndexPath:(NSIndexPath* (^)(UITableView* view, NSIndexPath* fromPath, NSIndexPath* proposedPath))block;

/**
 *  equal to -> |tableView:didEndDisplayingCell:forRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDidEndDisplayingCell:(void (^)(UITableView* view, UITableViewCell* cell, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:didEndDisplayingHeaderView:forSection:|
 */
- (instancetype)withBlockForHeaderViewDidEndDisplaying:(void (^)(UITableView* view, UIView* headerView, NSInteger section))block;

/**
 *  equal to -> |tableView:didEndDisplayingFooterView:forSection:|
 */
- (instancetype)withBlockForFooterViewDidEndDisplaying:(void (^)(UITableView* view, UIView* footerView, NSInteger section))block;

/**
 *  equal to -> |tableView:shouldShowMenuForRowAtIndexPath:|
 */
- (instancetype)withBlockForRowShouldShowMenu:(BOOL (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:canPerformAction:forRowAtIndexPath:withSender:|
 */
- (instancetype)withBlockForRowCanPerformAction:(BOOL (^)(UITableView* view, SEL action, NSIndexPath* path, id sender))block;

/**
 *  equal to -> |tableView:performAction:forRowAtIndexPath:withSender:|
 */
- (instancetype)withBlockForRowPerformAction:(void (^)(UITableView* view, SEL action, NSIndexPath* path, id sender))block;

/**
 *  equal to -> |tableView:shouldHighlightRowAtIndexPath:|
 */
- (instancetype)withBlockForRowShouldHighlight:(BOOL (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:didHighlightRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDidHighlight:(void (^)(UITableView* view, NSIndexPath* path))block;

/**
 *  equal to -> |tableView:didUnhighlightRowAtIndexPath:|
 */
- (instancetype)withBlockForRowDidUnhighlight:(void (^)(UITableView* view, NSIndexPath* path))block;


@end
