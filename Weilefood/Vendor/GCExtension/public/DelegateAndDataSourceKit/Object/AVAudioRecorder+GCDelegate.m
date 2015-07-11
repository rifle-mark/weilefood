//
//  AVAudioRecorder+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "AVAudioRecorder+GCDelegate.h"
#import "AVAudioRecorder+GCDelegateBlock.h"

@implementation AVAudioRecorder (GCDelegate)

- (instancetype)withBlockForAudioRecorderDidFinish:(void (^)(AVAudioRecorder *, BOOL))block {
    self.blockForAudioRecorderDidFinish = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForAudioRecorderEncodeError:(void (^)(AVAudioRecorder *, NSError *))block {
    self.blockForAudioRecorderEncodeError = block;
    [self usingBlocks];
    return self;
}


@end
