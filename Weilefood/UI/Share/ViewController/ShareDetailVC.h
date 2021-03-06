//
//  WeiCommentDetailVC.h
//  Sunflower
//
//  Created by makewei on 15/6/2.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLShareModel;
@interface ShareDetailVC : UIViewController

@property(nonatomic,strong)WLShareModel     *share;
@property(nonatomic,copy)void(^shareDeleteSuccessBlock)();

- (void)showCommentViewWithShare:(WLShareModel*)share;

@end
