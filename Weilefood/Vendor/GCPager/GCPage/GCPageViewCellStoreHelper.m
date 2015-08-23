//
//  GCPageViewCellStoreHelper.m
//  GCPagerExtension
//
//  Created by zhoujinqiang on 15/1/23.
//  Copyright (c) 2015年 njgarychow. All rights reserved.
//

#import "GCPageViewCellStoreHelper.h"
#import "GCPageViewCell.h"

@interface GCPageViewCellStoreHelper ()

@property (nonatomic, strong) NSMutableDictionary* freeCellDictionary;
@property (nonatomic, strong) NSMutableDictionary* classesDictionary;

@end

@implementation GCPageViewCellStoreHelper

- (instancetype)init {
    if (self = [super init]) {
        self.freeCellDictionary = [NSMutableDictionary dictionary];
        self.classesDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registClass:(Class)cellClass withCellIdentifer:(NSString *)cellIdentifier {
    NSParameterAssert(cellClass != NULL);
    NSParameterAssert([cellIdentifier isKindOfClass:[NSString class]]);
    
    self.classesDictionary[cellIdentifier] = cellClass;
    if (!self.freeCellDictionary[cellIdentifier]) {
        self.freeCellDictionary[cellIdentifier] = [NSMutableArray array];
    }
}

- (GCPageViewCell *)dequeueReusablePageViewCellForIdentifer:(NSString *)cellIdentifer size:(CGSize)cellSize {
    NSMutableArray* freeCellArray = self.freeCellDictionary[cellIdentifer];
    GCPageViewCell* cell = [freeCellArray lastObject];
    [freeCellArray removeObject:cell];
    if (!cell) {
        cell = [[self.classesDictionary[cellIdentifer] alloc] initWithFrame:(CGRect){{0, 0}, cellSize}
                                                            reuseIdentifier:cellIdentifer];
        cell.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    [cell prepareForReuse];
    return cell;
}

- (void)freeReusablePageViewCell:(GCPageViewCell *)cell {
    [cell prepareForFree];
    for (NSString* cellIdentifer in [self.classesDictionary allKeys]) {
        Class cls = self.classesDictionary[cellIdentifer];
        if ([cell class] == cls) {
            [self.freeCellDictionary[cellIdentifer] addObject:cell];
            break;
        }
    }
}

@end
