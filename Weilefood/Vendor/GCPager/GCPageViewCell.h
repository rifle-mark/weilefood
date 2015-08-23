//
//  GCPageViewCell.h
//  GCPagerExtension
//
//  Created by njgarychow on 1/16/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCPageViewCell : UIView

@property (nonatomic, readonly) NSString* reuseIdentifier;

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  Optional. This cell will be reused. Override this method to initialize the state.
 */
- (void)prepareForReuse;
/**
 *  Optional. This cell has disappear. Override this method to free memory or some other resouces.
 */
- (void)prepareForFree;

@end
