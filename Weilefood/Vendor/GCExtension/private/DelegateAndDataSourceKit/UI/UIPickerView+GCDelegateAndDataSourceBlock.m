//
//  UIPickerView+GCDelegateAndDataSourceBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPickerView+GCDelegateAndDataSourceBlock.h"

#import "UIPickerViewDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>
#import "NSObject+GCProxyRegister.h"

@implementation UIPickerView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[UIPickerViewDelegateImplementationProxy class]];
}


@dynamic blockForRowHeightForComponent;
@dynamic blockForWidthForComponent;
@dynamic blockForTitltForRowForComponent;
@dynamic blockForAttributedTitleForRowForComponent;
@dynamic blockForViewForRowForComponentWithReusingView;
@dynamic blockForDidSelectRowInComponent;

@dynamic blockForNumberOfComponents;
@dynamic blockForNumberOfRowsInComponent;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
