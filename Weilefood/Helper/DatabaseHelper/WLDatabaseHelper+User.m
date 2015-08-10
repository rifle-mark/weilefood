//
//  WLDatabaseHelper+User.m
//  Weilefood
//
//  Created by kelei on 15/7/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLDatabaseHelper+User.h"
#import "WLModelHeader.h"

@implementation WLDatabaseHelper (User)

+ (WLUserModel *)user_find {
    WLUserModel *model = nil;
    WLMOUser *managedObject = [WLMOUser MR_findFirst];
    if (managedObject) {
        model = [[WLUserModel alloc] init];
        [self copyPropertyValuesFromManagedObject:managedObject toObject:model];
    }
    return model;
}

+ (void)user_save:(WLUserModel *)model {
    NSParameterAssert(model);
    
    WLMOUser *managedObject = [WLMOUser MR_findFirst];
    if (!managedObject) {
        managedObject = [WLMOUser MR_createEntity];
    }
    [self copyPropertyValuesFromObject:model toManagedObject:managedObject];
}

+ (void)user_delete {
    [WLMOUser MR_truncateAll];
}

@end
