//
//  AVAudioRecorder+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "AVAudioRecorder+GCDelegateBlock.h"
#import "NSObject+GCProxyRegister.h"
#import "NSObject+GCAccessor.h"
#import "AVAudioRecordDelegateImplementationProxy.h"

@implementation AVAudioRecorder (GCDelegateBlock)

@dynamic blockForAudioRecorderDidFinish;
@dynamic blockForAudioRecorderEncodeError;

+ (void)load {
    [self extensionAccessorGenerator];
}

- (void)usingBlocks {
    [self registerBlockProxyWithClass:[AVAudioRecordDelegateImplementationProxy class]];
}

@end
