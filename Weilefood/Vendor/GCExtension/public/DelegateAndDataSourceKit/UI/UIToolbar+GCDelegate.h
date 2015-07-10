//
//  UIToolbar+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbar (GCDelegate)

/**
 *  equal to -> |positionForBar:|
 */
- (instancetype)withBlockForPosition:(UIBarPosition (^)(UIToolbar* bar))block;

@end
