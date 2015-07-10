//
//  AVAudioPlayer+GCDelegateBlock.h
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "GCMacro.h"

@interface AVAudioPlayer (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |audioPlayerDidFinishPlaying:successfully:|
 */
GCBlockProperty void (^blockForAudioPlayerDidFinish)(AVAudioPlayer* player, BOOL successfully);

/**
 *  equal to -> |audioPlayerDecodeErrorDidOccur:error:|
 */
GCBlockProperty void (^blockForAudioPlayerDecodeError)(AVAudioPlayer* player, NSError* error);


@end
