//
//  ProductInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ProductInfoVC.h"

@interface ProductInfoVC ()

@property (nonatomic, strong) WLProductModel *product;

@end

@implementation ProductInfoVC

- (id)init {
    NSAssert(_product, @"请使用initWithProduct:来实例化");
    self = [super init];
    return self;
}

- (instancetype)initWithProduct:(WLProductModel *)product {
    NSParameterAssert(product);
    _product = product;
    if (self = [super init]) {
        self.product = product;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_WHITE;
}

@end
