//
//  AVAudioPlayerDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 3/24/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "AVAudioPlayerDelegateImplementationProxy.h"
#import <AVFoundation/AVFoundation.h>
#import "AVAudioPlayer+GCDelegateBlock.h"

@interface AVAudioPlayerDelegateImplementation : NSObject <AVAudioPlayerDelegate>

@end


@implementation AVAudioPlayerDelegateImplementation

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    player.blockForAudioPlayerDidFinish(player, flag);
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    player.blockForAudioPlayerDecodeError(player, error);
}

@end





@implementation AVAudioPlayerDelegateImplementationProxy

+ (Class)realObjectClass {
    return [AVAudioPlayerDelegateImplementation class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"audioPlayerDidFinishPlaying:successfully:" : @"blockForAudioPlayerDidFinish",
                            @"audioPlayerDecodeErrorDidOccur:error:" : @"blockForAudioPlayerDecodeError",
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}


@end
