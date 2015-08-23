//
//  GCPageViewCell.m
//  GCPagerExtension
//
//  Created by njgarychow on 1/16/15.
//  Copyright (c) 2015 njgarychow. All rights reserved.
//

#import "GCPageViewCell.h"

@implementation GCPageViewCell

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame]) {
        _reuseIdentifier = [reuseIdentifier copy];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(NO, @"use |initWithFrame:cellIdentifier:| instead");
    return nil;
}

- (void)prepareForReuse {}
- (void)prepareForFree {}

@end
