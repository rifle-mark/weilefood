//
//  UIBarButtonItem+Ext.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIBarButtonItem+Ext.h"

@implementation UIBarButtonItem (Ext)

+ (instancetype)createNavigationFixedItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = -10;
    return item;
    
}

@end
