//
//  UIScrollView+MJRefreshDefault.m
//  Weilefood
//
//  Created by kelei on 15/8/13.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UIScrollView+MJRefreshDefault.h"

@implementation UIScrollView (MJRefreshDefault)

- (void)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)block {
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}

- (void)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)block {
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
}

@end
