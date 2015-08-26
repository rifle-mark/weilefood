//
//  WLDatabaseHelper+ShoppingCartItem.m
//  Weilefood
//
//  Created by kelei on 15/8/17.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDatabaseHelper+ShoppingCartItem.h"
#import "WLModelHeader.h"

@implementation WLDatabaseHelper (ShoppingCartItem)

+ (WLMOShoppingCartItem *)_findWithType:(WLOrderProductType)type refId:(long long)refId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %ld AND refId = %ld", type, refId];
    return [WLMOShoppingCartItem MR_findFirstWithPredicate:predicate];
}

+ (NSArray *)shoppingCart_findItems {
    NSMutableArray *ret = [NSMutableArray array];
    NSArray *items = [WLMOShoppingCartItem MR_findAll];
    for (WLMOShoppingCartItem *item in items) {
        WLShoppingCartItemModel *model = [[WLShoppingCartItemModel alloc] init];
        [self copyPropertyValuesFromManagedObject:item toObject:model];
        [ret addObject:model];
    }
    return ret;
}

+ (WLShoppingCartItemModel *)shoppingCart_findItemWithType:(WLOrderProductType)type refId:(long long)refId {
    WLShoppingCartItemModel *model = nil;
    WLMOShoppingCartItem *managedObject = [self _findWithType:type refId:refId];
    if (managedObject) {
        model = [[WLShoppingCartItemModel alloc] init];
        [self copyPropertyValuesFromManagedObject:managedObject toObject:model];
    }
    return model;
}

+ (void)shoppingCart_saveItem:(WLShoppingCartItemModel *)model {
    NSParameterAssert(model);
    WLMOShoppingCartItem *managedObject = [self _findWithType:model.type refId:model.refId];
    if (!managedObject) {
        managedObject = [WLMOShoppingCartItem MR_createEntity];
    }
    [self copyPropertyValuesFromObject:model toManagedObject:managedObject];
}

+ (void)shoppingCart_delete:(WLShoppingCartItemModel *)model {
    [self shoppingCart_deleteWithType:model.type refId:model.refId];
}

+ (void)shoppingCart_deleteWithType:(WLOrderProductType)type refId:(long long)refId {
    WLMOShoppingCartItem *managedObject = [self _findWithType:type refId:refId];
    if (managedObject) {
        [managedObject MR_deleteEntity];
    }
}

+ (void)shoppingCart_deleteAll {
    [WLMOShoppingCartItem MR_truncateAll];
}

@end
