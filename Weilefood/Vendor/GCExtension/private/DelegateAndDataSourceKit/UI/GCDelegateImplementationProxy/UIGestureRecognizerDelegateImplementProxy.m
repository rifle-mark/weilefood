//
//  UIGestureRecognizerDelegateImplementProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizerDelegateImplementProxy.h"

#import "UIGestureRecognizer+GCDelegateBlock.h"


@interface UIGestureRecognizerDelegateImplement : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIGestureRecognizer* owner;

@end

@implementation UIGestureRecognizerDelegateImplement

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return gestureRecognizer.blockForShouldBegin(gestureRecognizer);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return gestureRecognizer.blockForShouldReceiveTouch(gestureRecognizer, touch);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer.blockForShouldSimultaneous(gestureRecognizer, otherGestureRecognizer);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer.blockForShouldBeRequireToFailureBy(gestureRecognizer, otherGestureRecognizer);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return gestureRecognizer.blockForShouldRequireFailureOf(gestureRecognizer, otherGestureRecognizer);
}

@end




@implementation UIGestureRecognizerDelegateImplementProxy

+ (Class)realObjectClass {
    return [UIGestureRecognizerDelegateImplement class];
}

+ (NSString *)blockNamesForSelectorString:(NSString *)selectorString {
    NSString* blockName = @{
                            @"gestureRecognizerShouldBegin:" : @"blockForShouldBegin",
                            @"gestureRecognizer:shouldReceiveTouch:" : @"blockForShouldReceiveTouch",
                            @"gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:" : @"blockForShouldSimultaneous",
                            @"gestureRecognizer:shouldRequireFailureOfGestureRecognizer:" : @"blockForShouldRequireFailureOf",
                            @"gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:" : @"blockForShouldBeRequireToFailureBy,"
                            }[selectorString];
    return blockName ?: [super blockNamesForSelectorString:selectorString];
}

@end
