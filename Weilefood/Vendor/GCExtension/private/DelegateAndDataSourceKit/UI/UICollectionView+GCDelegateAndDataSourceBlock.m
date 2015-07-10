//
//  UICollectionView+GCDelegateAndDataSourceBlock.m
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UICollectionView+GCDelegateAndDataSourceBlock.h"
#import "NSObject+GCAccessor.h"
#import "UICollectionViewDelegateAndDataSourceImplementationProxy.h"
#import "NSObject+GCProxyRegister.h"

@implementation UICollectionView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UICollectionViewDelegateAndDataSourceImplementationProxy class]];
}


@dynamic blockForItemNumber;
@dynamic blockForSectionNumber;
@dynamic blockForItemCell;
@dynamic blockForSupplementaryElement;

@dynamic blockForItemShouldSelect;
@dynamic blockForItemDidSelect;
@dynamic blockForItemShouldDeselect;
@dynamic blockForItemDidDeselect;
@dynamic blockForItemShouldHighlight;
@dynamic blockForItemDidHighlight;
@dynamic blockForItemDidUnhighlight;
@dynamic blockForItemWillDisplay;
@dynamic blockForSupplementaryWillDisplay;
@dynamic blockForItemCellDidEndDisplay;
@dynamic blockForSupplementaryDidEndDisplay;
@dynamic blockForLayoutTransition;
@dynamic blockForItemMenuShouldShow;
@dynamic blockForItemCanPerformAction;
@dynamic blockForItemPerformAction;

@dynamic blockForFlowLayoutSize;
@dynamic blockForFlowLayoutSectionInset;
@dynamic blockForFlowLayoutSectionMinimumSpacing;
@dynamic blockForFlowLayoutSectionMinimumInteritemSpacing;
@dynamic blockForFlowLayoutHeaderReferenceSize;
@dynamic blockForFlowLayoutFooterReferenceSize;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
