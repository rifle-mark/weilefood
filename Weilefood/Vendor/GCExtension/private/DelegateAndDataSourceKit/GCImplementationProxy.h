//
//  GCImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/17/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCImplementationProxy : NSProxy

@property (nonatomic, weak) id owner;

/**
 *  SubClass override this method. Don't invoke this method directly.
 */
+ (Class)realObjectClass;

/**
 *  SubClass override this method. Don't invoke this method directly.
 */
+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString;

- (id)init;

@end
