//
//  AVAudioRecordDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "AVAudioRecordDelegateImplementationProxy.h"
#import <AVFoundation/AVFoundation.h>
#import "AVAudioRecorder+GCDelegateBlock.h"

@interface AVAudioRecordDelegateImplementation : NSObject <AVAudioRecorderDelegate>

@end



@implementation AVAudioRecordDelegateImplementation

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    recorder.blockForAudioRecorderDidFinish(recorder, flag);
}
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    recorder.blockForAudioRecorderEncodeError(recorder, error);
}

@end













@implementation AVAudioRecordDelegateImplementationProxy

+ (Class)realObjectClass {
    return [AVAudioRecordDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"audioRecorderDidFinishRecording:successfully:" : @"blockForAudioRecorderDidFinish",
                            @"audioRecorderEncodeErrorDidOccur:error:" : @"blockForAudioRecorderEncodeError",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
