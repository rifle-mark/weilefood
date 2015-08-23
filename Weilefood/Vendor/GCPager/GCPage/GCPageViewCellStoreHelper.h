//
//  GCPageViewCellStoreHelper.h
//  GCPagerExtension
//
//  Created by zhoujinqiang on 15/1/23.
//  Copyright (c) 2015年 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCPageViewCell;

@interface GCPageViewCellStoreHelper : NSObject

- (void)registClass:(Class)cellClass withCellIdentifer:(NSString *)cellIdentifier;
- (GCPageViewCell *)dequeueReusablePageViewCellForIdentifer:(NSString *)cellIdentifer size:(CGSize)cellSize;
- (void)freeReusablePageViewCell:(GCPageViewCell *)cell;

@end
