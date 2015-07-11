//
//  GCMacro.h
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#ifndef GCExtension_GCMacro_h
#define GCExtension_GCMacro_h


//  invoke the block with parameters. it will check if the block is nil.
#define GCBlockInvoke(block, ...)   \
do {                            \
    if (block) {                \
        block(__VA_ARGS__);    \
    }                           \
} while(0)



//  retain the object when using arc.
#define GCRetain(object)    \
do {                \
    if (!object) {   \
        break;      \
    }               \
    CFTypeRef retainTarget = (__bridge CFTypeRef)(object);    \
    CFRetain(retainTarget);             \
} while(0)




//  release the object when using arc.
#define GCRelease(object)   \
do {                \
    if (!object) {   \
        break;      \
    }               \
    CFTypeRef releaseTarget = (__bridge CFTypeRef)(object);       \
    CFRelease(releaseTarget);            \
} while(0)




//  return the os version
#define GCIOSVersion()      \
    ([[[UIDevice currentDevice] systemVersion] floatValue])




//  return if the ios's version is above the |version|
#define GCIsOSAboveVersion(version)     \
    ((version) >= GCIOSVersion())


#define GCBlockProperty     @property (nonatomic, copy)


#endif
