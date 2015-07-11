//
//  NSObject+GCNotificationObserver.h
//  GCExtension
//
//  Created by njgarychow on 14-8-4.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GCNotificationObserverBlock)(NSNotification* notification);

/**
 *  This Extension is used for add a observe of notificationcenter using Block.
 *  Also after we add the observer to the notificationcenter using the method 
 *  |addObserverForName:usingBlock:|, we don't have to remove the observer when 
 *  |self| is dealloc.
 */
@interface NSObject (GCNotificationObserver)


/**
 *  add class |self| to observe the notification named |name|. The |block| will be invoked when
 *  the notification is posted.
 *
 *  @param name     The name of the notification which want to be observed. |name| can't be nil.
 *  @param anObject It's the object which post the notification. if |anObject| is nil, observe all objects'
                    posting notifications.
 *  @param block    |block| is the callback when the notification is posted. |block| can't be nil.
 */
+ (void)addObserverForNotificationName:(NSString *)name
                                object:(id)anObject
                            usingBlock:(GCNotificationObserverBlock)block;
/**
 *  Equal to |addObserverForNotificationName:object:usingBlocks:| with nil to |anObject|.
 */
+ (void)addObserverForNotificationName:(NSString *)name
                            usingBlock:(GCNotificationObserverBlock)block;

/**
 *  remove class |self| to observe the notifications those named |name|.
 *
 *  @param name     the name of the notification which want to stop observing. |name| can't be nil.
 *  @param anObject It's the object which post the notification. if |anObject| is nil, remove all observers 
                    named |name|
 */
+ (void)removeObserverForNotificationName:(NSString *)name object:(id)anObject;
/**
 *  Equal to |removeObserverForNotificationName:object| with nil to |anObject|.
 */
+ (void)removeObserverForNotificationName:(NSString *)name;




/**
 *  add |self| to observe the notification named |name|. The |block| will be invoked when
 *  the notification is posted.
 *
 *  @param name     The name of the notification which want to be observed. |name| can't be nil.
 *  @param anObject It's the object which post the notification. if |anObject| is nil, observe all objects'
 posting notifications.
 *  @param block    |block| is the callback when the notification is posted. |block| can't be nil.
 */
- (void)addObserverForNotificationName:(NSString *)name
                                object:(id)anObject
                            usingBlock:(GCNotificationObserverBlock)block;
/**
 *  Equal to |addObserverForNotificationName:object:usingBlocks:| with nil to |anObject|.
 */
- (void)addObserverForNotificationName:(NSString *)name
                            usingBlock:(GCNotificationObserverBlock)block;

/**
 *  remove |self| to observe the notifications those named |name|.
 *
 *  @param name     the name of the notification which want to stop observing. |name| can't be nil.
 *  @param anObject It's the object which post the notification. if |anObject| is nil, remove all observers
 named |name|
 */
- (void)removeObserverForNotificationName:(NSString *)name object:(id)anObject;
/**
 *  Equal to |removeObserverForNotificationName:object| with nil to |anObject|.
 */
- (void)removeObserverForNotificationName:(NSString *)name;

@end
