//
//  UIPickerView+GCDelegateAndDataSourceBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIPickerView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks;

/**
 *  equal to -> |pickerView:rowHeightForComponent:|
 */
GCBlockProperty CGFloat (^blockForRowHeightForComponent)(UIPickerView* picker, NSInteger component);

/**
 *  equal to -> |pickerView:widthForComponent:|
 */
GCBlockProperty CGFloat (^blockForWidthForComponent)(UIPickerView* picker, NSInteger component);

/**
 *  equal to -> |pickerView:titleForRow:forComponent:|
 */
GCBlockProperty NSString* (^blockForTitltForRowForComponent)(UIPickerView* picker, NSInteger row, NSInteger component);

/**
 *  equal to -> |pickerView:attributedTitleForRow:forComponent:|
 */
GCBlockProperty NSAttributedString* (^blockForAttributedTitleForRowForComponent)(UIPickerView* picker, NSInteger row, NSInteger component);

/**
 *  equal to -> |pickerView:viewForRow:forComponent:reusingView:|
 */
GCBlockProperty UIView* (^blockForViewForRowForComponentWithReusingView)(UIPickerView* picker, NSInteger row, NSInteger component, UIView* reusingView);

/**
 *  equal to -> |pickerView:didSelectRow:inComponent:|
 */
GCBlockProperty void (^blockForDidSelectRowInComponent)(UIPickerView* picker, NSInteger row, NSInteger component);




/**
 *  equal to -> |numberOfComponentsInPickerView:|
 */
GCBlockProperty NSInteger (^blockForNumberOfComponents)(UIPickerView* picker);

/**
 *  equal to -> |pickerView:numberOfRowsInComponent:|
 */
GCBlockProperty NSInteger (^blockForNumberOfRowsInComponent)(UIPickerView* picker, NSInteger component);

@end
