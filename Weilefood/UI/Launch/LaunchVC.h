//
//  LaunchVC.h
//  Weilefood
//
//  Created by makewei on 15/9/4.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LaunchVCFinishBlock)();

@interface LaunchVC : UIViewController

- (void)finishBlock:(LaunchVCFinishBlock)finishBlock;

@end
