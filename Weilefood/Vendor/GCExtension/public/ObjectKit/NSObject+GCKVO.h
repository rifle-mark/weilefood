//
//  NSObject+GCKVO.h
//  GCExtension
//
//  Created by njgarychow on 9/16/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GCKVOBlock)(NSObject* target, NSString* keyPath, NSDictionary* change);

/**
 *  This class extension is for KVO.
 *  You can add an observe using block. You don't need to override the method
 *  |observeValueForKeyPath:ofObject:change:context:|. 
 *  You don't have to remove the stop the observe. When either the observer or the 
 *  target deallocation. The observe action will be stop automatic.
 */
@interface NSObject (GCKVO)

/**
 *  start observe an object's keyPath. using the options NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld.
 *
 *  @param observeTarger the target object want to be observed.
 *  @param keyPath       the keyPath of the object. same as kvo.
 *  @param handler       if the keyPath's value change, the handler block will be invoke.
 */
- (void)startObserveObject:(NSObject *)observeTarger
                forKeyPath:(NSString *)keyPath
                usingBlock:(GCKVOBlock)handler;
/**
 *  start observe an object's keyPath.
 *
 *  @param observeTarger the target object want to be observed.
 *  @param keyPath       the keyPath of the object. same as kvo.
 *  @param options       the same as kvo.
 *  @param handler       if the keyPath's value change, the handler block will be invoke.
 */
- (void)startObserveObject:(NSObject *)observeTarger
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                usingBlock:(GCKVOBlock)handler;

/**
 *  stop observe an object's keyPath.
 *
 *  @param observeTarger the target object was observed.
 *  @param keyPath       the same as kvo.
 */
- (void)stopObserveObject:(NSObject *)observeTarger
               forKeyPath:(NSString *)keyPath;

@end
