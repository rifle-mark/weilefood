//
//  WLDatabaseHelper.m
//  Weilefood
//
//  Created by kelei on 15/7/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDatabaseHelper.h"

@implementation WLDatabaseHelper

+ (void)copyPropertyValuesWithClass:(Class)class FromObject:(NSObject *)fromObject toObject:(NSObject *)toObject {
    NSParameterAssert(class);
    NSParameterAssert(fromObject);
    NSParameterAssert(toObject);
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [toObject setValue:[fromObject valueForKey:propertyName] forKey:propertyName];
    }
}

+ (void)copyPropertyValuesFromObject:(NSObject *)fromObject toManagedObject:(NSManagedObject *)managedObject {
    [self copyPropertyValuesWithClass:[fromObject class] FromObject:fromObject toObject:managedObject];
}

+ (void)copyPropertyValuesFromManagedObject:(NSManagedObject *)managedObject toObject:(NSObject *)toObject {
    [self copyPropertyValuesWithClass:[toObject class] FromObject:managedObject toObject:toObject];
}

@end
