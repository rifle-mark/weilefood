//
//  NSObject+GCAccessor.m
//  GCExtension
//
//  Created by njgarychow on 9/21/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "NSObject+GCAccessor.h"

#import <objc/runtime.h>

@interface GCExtensionAccessorWrapper : NSObject

@property (nonatomic, strong) id nonatomic_strong_property;
@property (nonatomic, weak) id nonatomic_weak_property;
@property (nonatomic, copy) id nonatomic_copy_property;
@property (atomic, strong) id atomic_strong_property;
@property (atomic, weak) id atomic_weak_property;
@property (atomic, copy) id atomic_copy_property;

@end

@implementation GCExtensionAccessorWrapper

@end













@implementation NSObject (GCAccessor)
- (NSMutableDictionary *)properties {
    static char const PropertyDictionaryKey;
    NSMutableDictionary* propertiesDic = objc_getAssociatedObject(self, &PropertyDictionaryKey);
    if (!propertiesDic) {
        propertiesDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &PropertyDictionaryKey, propertiesDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return propertiesDic;
}
- (void)_setPropertyThroughoutSelector:(SEL)selector property:(id)property {
    NSString* propertyKey = getPropertiesKeyStringWithGetOrSetSelector(selector);
    if (property) {
        [[self properties] setObject:property forKey:propertyKey];
    }
    else {
        [[self properties] removeObjectForKey:propertyKey];
    }
}
- (id)_getPropertyThroughoutSelector:(SEL)selector {
    NSString* blockKey = getPropertiesKeyStringWithGetOrSetSelector(selector);
    return [[self properties] objectForKey:blockKey];
}
static inline NSString * getPropertiesKeyStringWithGetOrSetSelector(SEL selector) {
    NSString* selectorName = [NSStringFromSelector(selector) lowercaseString];
    return [selectorName
            stringByReplacingOccurrencesOfString:@"(^set|:)"
            withString:@""
            options:NSRegularExpressionSearch
            range:NSMakeRange(0, [selectorName length])];
}
static inline void nonatomic_strong_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.nonatomic_strong_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id nonatomic_strong_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.nonatomic_strong_property;
}
static inline void nonatomic_copy_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.nonatomic_copy_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id nonatomic_copy_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.nonatomic_copy_property;
}
static inline void nonatomic_weak_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.nonatomic_weak_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id nonatomic_weak_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.nonatomic_weak_property;
}
static inline void atomic_strong_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.atomic_strong_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id atomic_strong_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.atomic_strong_property;
}
static inline void atomic_copy_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.atomic_copy_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id atomic_copy_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.atomic_copy_property;
}
static inline void atomic_weak_setter(id self, SEL _cmd, id property) {
    GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];
    wrapper.atomic_weak_property = property;
    [self _setPropertyThroughoutSelector:_cmd property:wrapper];
}
static inline id atomic_weak_getter(id self, SEL _cmd) {
    GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];
    return wrapper.atomic_weak_property;
}
static inline SEL propertyGetterSelector(NSString* propertyString) {
    return NSSelectorFromString(propertyString);
}
static inline SEL propertySetterSelector(NSString* propertyString) {
    NSString* head = [propertyString substringToIndex:1];
    NSString* rest = [propertyString substringFromIndex:1];
    return NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [head uppercaseString], rest]);
};

+ (void)_extensionProperty:(NSString *)propertyName setter:(IMP)setter getter:(IMP)getter {
    if (setter) {
        SEL setterSEL = propertySetterSelector(propertyName);
        class_addMethod(self, setterSEL, (IMP)(setter), "v@:@");
    }
    if (getter) {
        SEL getterSEL = propertyGetterSelector(propertyName);
        class_addMethod(self, getterSEL, (IMP)(getter), "@@:");
    }
}



+ (void)load {
    [self extensionAccessorGenerator];
}

+ (void)extensionAccessorGenerator {
    
    unsigned int propertyCount;
    objc_property_t* propertyList = class_copyPropertyList(self, &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t p = propertyList[i];
        NSString* propertyName = [NSString stringWithCString:property_getName(p)
                                                    encoding:NSUTF8StringEncoding];
        if (class_getInstanceMethod([self class], propertyGetterSelector(propertyName))) {
            continue;
        }
        
        NSArray* types = [[NSString stringWithCString:property_getAttributes(p)
                                             encoding:NSUTF8StringEncoding]
                          componentsSeparatedByString:@","];
        BOOL (^IsTargetTypeInTheTypes)(NSString* targetType) = ^(NSString* targetType) {
            for (NSString* type in types) {
                if ([type hasPrefix:targetType]) {
                    return YES;
                }
            }
            return NO;
        };
        
        if (IsTargetTypeInTheTypes(@"G")) continue;
        if (IsTargetTypeInTheTypes(@"S")) continue;
        if (!IsTargetTypeInTheTypes(@"T@")) continue;
        if (!IsTargetTypeInTheTypes(@"D")) continue;
        
        BOOL isReadonly     = IsTargetTypeInTheTypes(@"R");    //  1 << 1
        BOOL isCopy         = IsTargetTypeInTheTypes(@"C");    //  1 << 2
        BOOL isStrong       = IsTargetTypeInTheTypes(@"&");    //  1 << 3
        BOOL isNonatomic    = IsTargetTypeInTheTypes(@"N");    //  1 << 4
        BOOL isWeak         = IsTargetTypeInTheTypes(@"W");    //  1 << 5
        
        IMP setter = nil;
        IMP getter = nil;
        if (isNonatomic && isCopy) {
            getter = (IMP)nonatomic_copy_getter;
            setter = isReadonly ? nil : (IMP)nonatomic_copy_setter;
        }
        else if (isNonatomic && isStrong) {
            getter = (IMP)nonatomic_strong_getter;
            setter = isReadonly ? nil : (IMP)nonatomic_strong_setter;
        }
        else if (isNonatomic && isWeak) {
            getter = (IMP)nonatomic_weak_getter;
            setter = isReadonly ? nil : (IMP)nonatomic_weak_setter;
        }
        else if (isCopy) {
            getter = (IMP)atomic_copy_getter;
            setter = isReadonly ? nil : (IMP)atomic_copy_setter;
        }
        else if (isStrong) {
            getter = (IMP)atomic_strong_getter;
            setter = isReadonly ? nil : (IMP)atomic_strong_setter;
        }
        else if (isWeak) {
            getter = (IMP)atomic_weak_getter;
            setter = isReadonly ? nil : (IMP)atomic_weak_setter;
        }
        else {
            NSLog(@"the property |%@| did not generate accesser method", propertyName);
        }
        [self _extensionProperty:propertyName setter:setter getter:getter];
    }
}

@end
