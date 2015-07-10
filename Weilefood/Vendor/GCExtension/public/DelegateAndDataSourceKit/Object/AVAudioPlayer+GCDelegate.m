//
//  AVAudioPlayer+GCDelegate.m
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "AVAudioPlayer+GCDelegate.h"
#import "AVAudioPlayer+GCDelegateBlock.h"

@implementation AVAudioPlayer (GCDelegate)

- (instancetype)withBlockForAudioPlayerDidFinish:(void (^)(AVAudioPlayer *, BOOL))block {
    self.blockForAudioPlayerDidFinish = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockforAudioPlayerDecodeError:(void (^)(AVAudioPlayer *, NSError *))block {
    self.blockForAudioPlayerDecodeError = block;
    [self usingBlocks];
    return self;
}

@end
