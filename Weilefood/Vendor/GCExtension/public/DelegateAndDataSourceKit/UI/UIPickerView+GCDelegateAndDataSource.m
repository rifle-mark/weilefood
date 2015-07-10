//
//  UIPickerView+GCDelegateAndDataSource.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPickerView+GCDelegateAndDataSource.h"
#import "UIPickerView+GCDelegateAndDataSourceBlock.h"

@implementation UIPickerView (GCDelegateAndDataSource)

- (instancetype)withBlockForRowHeightForComponent:(CGFloat (^)(UIPickerView* picker, NSInteger component))block {
    self.blockForRowHeightForComponent = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForWidthForComponent:(CGFloat (^)(UIPickerView* picker, NSInteger component))block {
    self.blockForWidthForComponent = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForTitltForRowForComponent:(NSString* (^)(UIPickerView* picker, NSInteger row, NSInteger component))block {
    self.blockForTitltForRowForComponent = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForAttributedTitleForRowForComponent:(NSAttributedString* (^)(UIPickerView* picker, NSInteger row, NSInteger component))block {
    self.blockForAttributedTitleForRowForComponent = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForViewForRowForComponentWithReusingView:(UIView* (^)(UIPickerView* picker, NSInteger row, NSInteger component, UIView* reusingView))block {
    self.blockForViewForRowForComponentWithReusingView = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForDidSelectRowInComponent:(void (^)(UIPickerView* picker, NSInteger row, NSInteger component))block {
    self.blockForDidSelectRowInComponent = block;
    [self usingBlocks];
    return self;
}



- (instancetype)withBlockForNumberOfComponents:(NSInteger (^)(UIPickerView* picker))block {
    self.blockForNumberOfComponents = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForNumberOfRowsInComponent:(NSInteger (^)(UIPickerView* picker, NSInteger component))block {
    self.blockForNumberOfRowsInComponent = block;
    [self usingBlocks];
    return self;
}

@end
