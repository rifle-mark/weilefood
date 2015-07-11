//
//  UITableView+GCBlock.h
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"


/**
 *  This extension uses the catagory of the UITableView to implement using block instead of
 *  the delegate and the dataSource.
 */
@interface UITableView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks;

#pragma mark - datasource property
/**
 *  equal to -> |tableView:cellForRowAtIndexPath:|
 */
GCBlockProperty UITableViewCell* (^blockForRowCell)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |numberOfSectionsInTableView:|
 */
GCBlockProperty NSInteger (^blockForSectionNumber)(UITableView* tableView);

/**
 *  equal to -> |tableView:numberOfRowsInSection:|
 */
GCBlockProperty NSInteger (^blockForRowNumber)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |sectionIndexTitlesForTableView:|
 */
GCBlockProperty NSArray* (^blockForSectionIndexTitles)(UITableView* tableView);

/**
 *  equal to -> |tableView:sectionForSectionIndexTitle:atIndex:|
 */
GCBlockProperty NSInteger (^blockForSectionIndex)(UITableView* tableView, NSString* title, NSInteger index);

/**
 *  equal to -> |tableView:titleForFooterInSection:|
 */
GCBlockProperty NSString* (^blockForFooterTitle)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:titleForHeaderInSection:|
 */
GCBlockProperty NSString* (^blockForHeaderTitle)(UITableView* tableView, NSInteger seciton);

/**
 *  equal to -> |tableView:commitEditingStyle:forRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowCommitEditStyleForRow)(UITableView* tableView, UITableViewCellEditingStyle style, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:canEditRowAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForRowCanEditRow)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:canMoveRowAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForRowCanMoveRow)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:moveRowAtIndexPath:toIndexPath:|
 */
GCBlockProperty void (^blockForRowMove)(UITableView* tableView, NSIndexPath* fromIndexPath, NSIndexPath* toIndexPath);







#pragma mark - delegate property

/**
 *  equal to -> |tableView:heightForRowAtIndexPath:|
 */
GCBlockProperty CGFloat (^blockForRowHeight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:estimatedHeightForRowAtIndexPath:|
 */
GCBlockProperty CGFloat (^blockForRowEstimatedHeight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:indentationLevelForRowAtIndexPath:|
 */
GCBlockProperty NSInteger (^blockForRowIndentationLevel)(UITableView* tableView, NSIndexPath* indexPath) NS_AVAILABLE_IOS(8_0);

/**
 *  equal to -> |tableView:willDisplayCell:forRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowCellWillDisplay)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:editActionsForRowAtIndexPath:|
 */
GCBlockProperty NSArray* (^blockForRowEditActions)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  euqal to -> |tableView:accessoryButtonTappedForRowWithIndexPath:|
 */
GCBlockProperty void (^blockForRowAccessoryButtonTapped)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:willSelectRowAtIndexPath:|
 */
GCBlockProperty NSIndexPath* (^blockForRowWillSelect)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didSelectRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowDidSelect)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:willDeselectRowAtIndexPath:|
 */
GCBlockProperty NSIndexPath* (^blockForRowWillDeselect)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didDeselectRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowDidDeselecte)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:viewForHeaderInSection:|
 */
GCBlockProperty UIView* (^blockForHeaderView)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:viewForFooterInSection:|
 */
GCBlockProperty UIView* (^blockForFooterView)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:heightForHeaderInSection:|
 */
GCBlockProperty CGFloat (^blockForHeaderHeight)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:estimatedHeightForHeaderInSection:|
 */
GCBlockProperty CGFloat (^blockForHeaderEstimatedHeight)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:heightForFooterInSection:|
 */
GCBlockProperty CGFloat (^blockForFooterHeight)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:estimatedHeightForFooterInSection:|
 */
GCBlockProperty CGFloat (^blockForFooterEstimatedHeight)(UITableView* tableView, NSInteger section);

/**
 *  equal to -> |tableView:willDisplayHeaderView:forSection:|
 */
GCBlockProperty void (^blockForHeaderViewWillDisplay)(UITableView* tableView, UIView* headerView, NSInteger section);

/**
 *  equal to -> |tableView:willDisplayFooterView:forSection:|
 */
GCBlockProperty void (^blockForFooterViewWillDisplay)(UITableView* tableView, UIView* footerView, NSInteger section);

/**
 *  equal to -> |tableView:willBeginEditingRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowWillBeginEditing)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didEndEditingRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowDidEndEditing)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:editingStyleForRowAtIndexPath:|
 */
GCBlockProperty UITableViewCellEditingStyle (^blockForRowEditingStyle)(UITableView* tableView, NSIndexPath* indexPaht);

/**
 *  equal to -> |tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:|
 */
GCBlockProperty NSString* (^blockForRowDeleteConfirmationButtonTitle)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:shouldIndentWhileEditingRowAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForRowShouldIndentWhileEditing)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:|
 */
GCBlockProperty NSIndexPath* (^blockForRowMoveTargetIndexPath)(UITableView* tableView, NSIndexPath* fromIndexPath, NSIndexPath* proposedIndexPath);

/**
 *  equal to -> |tableView:didEndDisplayingCell:forRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowDidEndDisplayingCell)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didEndDisplayingHeaderView:forSection:|
 */
GCBlockProperty void (^blockForHeaderViewDidEndDisplaying)(UITableView* tableView, UIView* headerView, NSInteger section);

/**
 *  equal to -> |tableView:didEndDisplayingFooterView:forSection:|
 */
GCBlockProperty void (^blockForFooterViewDidEndDisplaying)(UITableView* tableView, UIView* footerView, NSInteger section);

/**
 *  equal to -> |tableView:shouldShowMenuForRowAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForRowShouldShowMenu)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:canPerformAction:forRowAtIndexPath:withSender:|
 */
GCBlockProperty BOOL (^blockForRowCanPerformAction)(UITableView* tableView, SEL action, NSIndexPath* indexPath, id sender);

/**
 *  equal to -> |tableView:performAction:forRowAtIndexPath:withSender:|
 */
GCBlockProperty void (^blockForRowPerformAction)(UITableView* tableView, SEL action, NSIndexPath* indexPath, id sender);

/**
 *  equal to -> |tableView:shouldHighlightRowAtIndexPath:|
 */
GCBlockProperty BOOL (^blockForRowShouldHighlight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didHighlightRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowDidHighlight)(UITableView* tableView, NSIndexPath* indexPath);

/**
 *  equal to -> |tableView:didUnhighlightRowAtIndexPath:|
 */
GCBlockProperty void (^blockForRowDidUnhighlight)(UITableView* tableView, NSIndexPath* indexPath);


@end
