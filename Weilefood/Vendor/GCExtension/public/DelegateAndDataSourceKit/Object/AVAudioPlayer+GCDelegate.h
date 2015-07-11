//
//  AVAudioPlayer+GCDelegate.h
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAudioPlayer (GCDelegate)

/**
 *  equal to -> |audioPlayerDidFinishPlaying:successfully:|
 */
- (instancetype)withBlockForAudioPlayerDidFinish:(void (^)(AVAudioPlayer* player, BOOL successfully))block;

/**
 *  equal to -> |audioPlayerDecodeErrorDidOccur:error:|
 */
- (instancetype)withBlockforAudioPlayerDecodeError:(void (^)(AVAudioPlayer* player, NSError* error))block;

@end
