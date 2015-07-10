//
//  AVAudioPlayer+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "AVAudioPlayer+GCDelegateBlock.h"
#import "NSObject+GCAccessor.h"
#import "NSObject+GCProxyRegister.h"
#import "AVAudioPlayerDelegateImplementationProxy.h"

@implementation AVAudioPlayer (GCDelegateBlock)

@dynamic blockForAudioPlayerDidFinish;
@dynamic blockForAudioPlayerDecodeError;

+ (void)load {
    [self extensionAccessorGenerator];
}

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[AVAudioPlayerDelegateImplementationProxy class]];
}

@end
