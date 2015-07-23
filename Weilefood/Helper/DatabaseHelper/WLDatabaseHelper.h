//
//  WLDatabaseHelper.h
//  Weilefood
//
//  Created by kelei on 15/7/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDatabaseHelper : NSObject

/**
 *  将fromObject模型的属性值复制给NSManagedObject对应的属性
 *
 *  @param fromObject    项目中的数据模型LCXXXXModel
 *  @param managedObject 项目中数据模型对应的NSManagedObject对象
 */
+ (void)copyPropertyValuesFromObject:(NSObject *)fromObject toManagedObject:(NSManagedObject *)managedObject;

/**
 *  将NSManagedObject的属性值复制给toObject模型
 *
 *  @param managedObject 项目中数据模型对应的NSManagedObject对象
 *  @param toObject      项目中的数据模型LCXXXXModel
 */
+ (void)copyPropertyValuesFromManagedObject:(NSManagedObject *)managedObject toObject:(NSObject *)toObject;

@end
