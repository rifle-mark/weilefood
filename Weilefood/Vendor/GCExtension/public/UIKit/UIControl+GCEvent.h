//
//  UIControl+GCEventBlock.h
//  GCExtension
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GCControlEventActionBlock)(UIControl* control, NSSet* touches);

/**
 *  This Extension is used for add UIControlEvents to the UIControls.
 */
@interface UIControl (GCEvent)

/**
 *  add actionBlock for paticular event. you can call this method mutiple times for a paticular event.
 *
 *  @param event    the particular event.
 *  @param action   action will be invoked when the particular event happen. |action| can't be nil.
 */
- (void)addControlEvents:(UIControlEvents)event action:(GCControlEventActionBlock)action;

/**
 *  remove all the actionBlocks for paticular event.
 *
 *  @param event    the particular event.
 */
- (void)removeAllControlEventsAction:(UIControlEvents)event;

@end
