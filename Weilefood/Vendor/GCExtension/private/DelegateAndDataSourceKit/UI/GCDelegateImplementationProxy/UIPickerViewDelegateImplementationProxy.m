//
//  UIPickerViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPickerViewDelegateImplementationProxy.h"
#import "UIPickerView+GCDelegateAndDataSourceBlock.h"

@interface UIPickerViewDelegateImplementation : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation UIPickerViewDelegateImplementation

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.blockForWidthForComponent(pickerView, component);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return pickerView.blockForRowHeightForComponent(pickerView, component);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerView.blockForTitltForRowForComponent(pickerView, row, component);
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerView.blockForAttributedTitleForRowForComponent(pickerView, row, component);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    return pickerView.blockForViewForRowForComponentWithReusingView(pickerView, row, component, view);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    pickerView.blockForDidSelectRowInComponent(pickerView, row, component);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return pickerView.blockForNumberOfComponents(pickerView);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerView.blockForNumberOfRowsInComponent(pickerView, component);
}

@end








@implementation UIPickerViewDelegateImplementationProxy

+ (Class)realObjectClass {
    return [UIPickerViewDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"pickerView:rowHeightForComponent:" : @"blockForRowHeightForComponent",
                            @"pickerView:widthForComponent:" : @"blockForWidthForComponent",
                            @"pickerView:titleForRow:forComponent:" : @"blockForTitltForRowForComponent",
                            @"pickerView:attributedTitleForRow:forComponent:" : @"blockForAttributedTitleForRowForComponent",
                            @"pickerView:viewForRow:forComponent:reusingView:" : @"blockForViewForRowForComponentWithReusingView",
                            @"pickerView:didSelectRow:inComponent:" : @"blockForDidSelectRowInComponent",
                            @"numberOfComponentsInPickerView:" : @"blockForNumberOfComponents",
                            @"pickerView:numberOfRowsInComponent:" : @"blockForNumberOfRowsInComponent",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
