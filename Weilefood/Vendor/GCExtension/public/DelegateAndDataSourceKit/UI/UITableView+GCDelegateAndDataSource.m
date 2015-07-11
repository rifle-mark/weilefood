//
//  UITableView+GCDelegateAndDataSource.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITableView+GCDelegateAndDataSource.h"

#import "UITableView+GCDelegateAndDataSourceBlock.h"

@implementation UITableView (GCDelegateAndDataSource)

- (instancetype)withBlockForRowCell:(UITableViewCell* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowCell = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSectionNumber:(NSInteger (^)(UITableView* view))block {
    self.blockForSectionNumber = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowNumber:(NSInteger (^)(UITableView* view, NSInteger section))block {
    self.blockForRowNumber = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSectionIndexTitles:(NSArray* (^)(UITableView* view))block {
    self.blockForSectionIndexTitles = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSectionIndex:(NSInteger (^)(UITableView* view, NSString* title, NSInteger index))block {
    self.blockForSectionIndex = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForFooterTitle:(NSString* (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterTitle = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForHeaderTitle:(NSString* (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderTitle = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowCommitEditStyleForRow:(void (^)(UITableView* view, UITableViewCellEditingStyle style, NSIndexPath* path))block {
    self.blockForRowCommitEditStyleForRow = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowCanEdit:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowCanEditRow = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowCanMove:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowCanMoveRow = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowMove:(void (^)(UITableView* view, NSIndexPath* fromPath, NSIndexPath* toPath))block {
    self.blockForRowMove = block;
    [self usingBlocks];
    return self;
}







#pragma mark - delegate property

- (instancetype)withBlockForRowHeight:(CGFloat (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowHeight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowEstimatedHeight:(CGFloat (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowEstimatedHeight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowIndentationLevel:(NSInteger (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowIndentationLevel = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowCellWillDisplay:(void (^)(UITableView* view, UITableViewCell* cell, NSIndexPath* path))block {
    self.blockForRowCellWillDisplay = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowEditActions:(NSArray* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowEditActions = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowAccessoryButtonTapped:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowAccessoryButtonTapped = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowWillSelect:(NSIndexPath* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowWillSelect = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDidSelect:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidSelect = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowWillDeselect:(NSIndexPath* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowWillDeselect = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDidDeselect:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidDeselecte = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForHeaderView:(UIView* (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderView = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForFooterView:(UIView* (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterView = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForHeaderHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderHeight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForHeaderEstimatedHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderEstimatedHeight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForFooterHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterHeight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForFooterEstimatedHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterEstimatedHeight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForHeaderViewWillDisplay:(void (^)(UITableView* view, UIView* headerView, NSInteger section))block {
    self.blockForHeaderViewWillDisplay = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForFooterViewWillDisplay:(void (^)(UITableView* view, UIView* footerView, NSInteger section))block {
    self.blockForFooterViewWillDisplay = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowWillBeginEditing:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowWillBeginEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDidEditing:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidEndEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowEditingStyle:(UITableViewCellEditingStyle (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowEditingStyle = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDeleteConfirmationButtonTitle:(NSString* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDeleteConfirmationButtonTitle = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowShouldIndentWhileEditing:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowShouldIndentWhileEditing = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowMoveTargetIndexPath:(NSIndexPath* (^)(UITableView* view, NSIndexPath* fromPath, NSIndexPath* proposedPath))block {
    self.blockForRowMoveTargetIndexPath = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDidEndDisplayingCell:(void (^)(UITableView* view, UITableViewCell* cell, NSIndexPath* path))block {
    self.blockForRowDidEndDisplayingCell = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForHeaderViewDidEndDisplaying:(void (^)(UITableView* view, UIView* headerView, NSInteger section))block {
    self.blockForHeaderViewDidEndDisplaying = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForFooterViewDidEndDisplaying:(void (^)(UITableView* view, UIView* footerView, NSInteger section))block {
    self.blockForFooterViewDidEndDisplaying = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowShouldShowMenu:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowShouldShowMenu = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowCanPerformAction:(BOOL (^)(UITableView* view, SEL action, NSIndexPath* path, id sender))block {
    self.blockForRowCanPerformAction = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowPerformAction:(void (^)(UITableView* view, SEL action, NSIndexPath* path, id sender))block {
    self.blockForRowPerformAction = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowShouldHighlight:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowShouldHighlight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDidHighlight:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidHighlight = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForRowDidUnhighlight:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidUnhighlight = block;
    [self usingBlocks];
    return self;
}

@end
