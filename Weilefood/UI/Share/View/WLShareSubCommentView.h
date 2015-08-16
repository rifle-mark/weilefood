//
//  BZArticleCommentView.h
//  BazaarShelf
//
//  Created by zhoujinqiang on 15/3/4.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLShareModel;
@interface WLShareSubCommentView : UIView

@property (nonatomic, strong) NSString* placeholderString;
@property (nonatomic, strong) WLShareModel* comment;
@property (nonatomic, strong) UITextView* commentTextView;

- (instancetype)withSubmitAction:(void (^)(NSString* commentContent, NSNumber* rootCommentID))action;

- (void)clearContent;

@end
