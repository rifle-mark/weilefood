//
//  NSObject+GCAccessor.h
//  GCExtension
//
//  Created by njgarychow on 9/21/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  This extension is for add properties when your extension an exist class.
 *  When you use this Class Extension. You must do some step as follows:
 *  1   Guarantee the property is an object.
 *  2   Use @property declare the property in the .h file and use @dynamic to the property.
 *  3   Invoke the method |extensionAccessorGenerator| in your class's method |+load|.
 */
@interface NSObject (GCAccessor)


/**
 *  This method must be invoked in method |+load| by yourself.
 */
+ (void)extensionAccessorGenerator;

@end
