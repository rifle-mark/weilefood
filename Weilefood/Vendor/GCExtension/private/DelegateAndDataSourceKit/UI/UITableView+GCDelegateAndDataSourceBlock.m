//
//  UITableView+GCBlock.m
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITableView+GCDelegateAndDataSourceBlock.h"

#import <objc/runtime.h>
#import "NSObject+GCAccessor.h"
#import "UITableViewDelegateAndDataSourceImplementationProxy.h"
#import "NSObject+GCProxyRegister.h"


#pragma mark - UITableView+GCBlock

@implementation UITableView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UITableViewDelegateAndDataSourceImplementationProxy class]];
}

@dynamic blockForRowCell;
@dynamic blockForSectionNumber;
@dynamic blockForRowNumber;
@dynamic blockForSectionIndexTitles;
@dynamic blockForSectionIndex;
@dynamic blockForFooterTitle;
@dynamic blockForHeaderTitle;
@dynamic blockForRowCommitEditStyleForRow;
@dynamic blockForRowCanEditRow;
@dynamic blockForRowCanMoveRow;
@dynamic blockForRowMove;

@dynamic blockForRowHeight;
@dynamic blockForRowEstimatedHeight;
@dynamic blockForRowIndentationLevel;
@dynamic blockForRowCellWillDisplay;
@dynamic blockForRowEditActions;
@dynamic blockForRowAccessoryButtonTapped;
@dynamic blockForRowWillSelect;
@dynamic blockForRowDidSelect;
@dynamic blockForRowWillDeselect;
@dynamic blockForRowDidDeselecte;
@dynamic blockForHeaderView;
@dynamic blockForFooterView;
@dynamic blockForHeaderHeight;
@dynamic blockForHeaderEstimatedHeight;
@dynamic blockForFooterHeight;
@dynamic blockForFooterEstimatedHeight;
@dynamic blockForHeaderViewWillDisplay;
@dynamic blockForFooterViewWillDisplay;
@dynamic blockForRowWillBeginEditing;
@dynamic blockForRowDidEndEditing;
@dynamic blockForRowEditingStyle;
@dynamic blockForRowDeleteConfirmationButtonTitle;
@dynamic blockForRowShouldIndentWhileEditing;
@dynamic blockForRowMoveTargetIndexPath;
@dynamic blockForRowDidEndDisplayingCell;
@dynamic blockForHeaderViewDidEndDisplaying;
@dynamic blockForFooterViewDidEndDisplaying;
@dynamic blockForRowShouldShowMenu;
@dynamic blockForRowCanPerformAction;
@dynamic blockForRowPerformAction;
@dynamic blockForRowShouldHighlight;
@dynamic blockForRowDidHighlight;
@dynamic blockForRowDidUnhighlight;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end

