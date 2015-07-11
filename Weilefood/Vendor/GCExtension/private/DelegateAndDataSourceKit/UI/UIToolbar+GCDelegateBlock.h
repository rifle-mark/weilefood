//
//  UIToolbar+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMacro.h"

@interface UIToolbar (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |positionForBar:|
 */
GCBlockProperty UIBarPosition (^blockForPosition)(UIToolbar* bar);

@end
