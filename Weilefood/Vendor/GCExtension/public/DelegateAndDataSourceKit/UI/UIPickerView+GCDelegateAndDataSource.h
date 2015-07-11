//
//  UIPickerView+GCDelegateAndDataSource.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPickerView (GCDelegateAndDataSource)

/**
 *  equal to -> |pickerView:rowHeightForComponent:|
 */
- (instancetype)withBlockForRowHeightForComponent:(CGFloat (^)(UIPickerView* picker, NSInteger component))block;
/**
 *  equal to -> |pickerView:widthForComponent:|
 */
- (instancetype)withBlockForWidthForComponent:(CGFloat (^)(UIPickerView* picker, NSInteger component))block;

/**
 *  equal to -> |pickerView:titleForRow:forComponent:|
 */
- (instancetype)withBlockForTitltForRowForComponent:(NSString* (^)(UIPickerView* picker, NSInteger row, NSInteger component))block;

/**
 *  equal to -> |pickerView:attributedTitleForRow:forComponent:|
 */
- (instancetype)withBlockForAttributedTitleForRowForComponent:(NSAttributedString* (^)(UIPickerView* picker, NSInteger row, NSInteger component))block;

/**
 *  equal to -> |pickerView:viewForRow:forComponent:reusingView:|
 */
- (instancetype)withBlockForViewForRowForComponentWithReusingView:(UIView* (^)(UIPickerView* picker, NSInteger row, NSInteger component, UIView* reusingView))block;

/**
 *  equal to -> |pickerView:didSelectRow:inComponent:|
 */
- (instancetype)withBlockForDidSelectRowInComponent:(void (^)(UIPickerView* picker, NSInteger row, NSInteger component))block;



/**
 *  equal to -> |numberOfComponentsInPickerView:|
 */
- (instancetype)withBlockForNumberOfComponents:(NSInteger (^)(UIPickerView* picker))block;

/**
 *  equal to -> |pickerView:numberOfRowsInComponent:|
 */
- (instancetype)withBlockForNumberOfRowsInComponent:(NSInteger (^)(UIPickerView* picker, NSInteger component))block;

@end
