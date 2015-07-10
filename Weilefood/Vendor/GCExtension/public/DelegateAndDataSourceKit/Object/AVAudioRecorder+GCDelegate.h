//
//  AVAudioRecorder+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAudioRecorder (GCDelegate)

/**
 *  equal to -> |audioRecorderDidFinishRecording:successfully:|
 */
- (instancetype)withBlockForAudioRecorderDidFinish:(void (^)(AVAudioRecorder* recorder, BOOL successfully))block;

/**
 *  equal to -> |audioRecorderEncodeErrorDidOccur:error:|
 */
- (instancetype)withBlockForAudioRecorderEncodeError:(void (^)(AVAudioRecorder* recorder, NSError* error))block;

@end
