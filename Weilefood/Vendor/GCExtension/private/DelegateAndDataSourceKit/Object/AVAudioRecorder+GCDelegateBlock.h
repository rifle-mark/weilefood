//
//  AVAudioRecorder+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "GCMacro.h"

@interface AVAudioRecorder (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |audioRecorderDidFinishRecording:successfully:|
 */
GCBlockProperty void (^blockForAudioRecorderDidFinish)(AVAudioRecorder* recorder, BOOL successfully);

/**
 *  equal to -> |audioRecorderEncodeErrorDidOccur:error:|
 */
GCBlockProperty void (^blockForAudioRecorderEncodeError)(AVAudioRecorder* recoder, NSError* error);

@end
