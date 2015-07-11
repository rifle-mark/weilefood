//
//  NSObject+GCProxyGetter.h
//  GCExtension
//
//  Created by njgarychow on 2/18/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCProxyRegister)

- (void)registerBlockProxyWithClass:(Class)proxyClass;

@end
