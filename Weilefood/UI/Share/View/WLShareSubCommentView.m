//
//  BZArticleCommentView.m
//  BazaarShelf
//
//  Created by zhoujinqiang on 15/3/4.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "WLShareSubCommentView.h"

#import "WLShareModel.h"

@interface WLShareSubCommentView ()

@property (nonatomic, copy) void (^submitAction)(NSString* commentContent, NSNumber* rootCommentID);
@property (nonatomic, strong) UIButton* submitButton;
@property (nonatomic, strong) UIView* lineView;

@end

@implementation WLShareSubCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _setupLineView];
        [self _setupCommentTextView];
        [self _setupSubmitButton];
        self.backgroundColor = RGB(151, 149, 149);
    }
    return self;
}

- (instancetype)withSubmitAction:(void (^)(NSString* commentContent, NSNumber* rootCommentID))action {
    self.submitAction = action;
    return self;
}

- (void)setComment:(WLShareModel *)comment {
    _comment = comment;
    if (comment) {
        self.placeholderString = @"";
        self.commentTextView.text = self.placeholderString;
    }
    else {
        [self clearContent];
    }
}

- (void)clearContent {
    _placeholderString = nil;
    self.commentTextView.text = @"";
}

- (BOOL)becomeFirstResponder {
    return [self.commentTextView becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    return [self.commentTextView resignFirstResponder];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self);
        make.height.equalTo(@1);
    }];
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
        make.width.equalTo(@70);
    }];
    [self.commentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(10);
        make.right.equalTo(self.submitButton.mas_left).with.offset(-10);
        make.bottom.equalTo(self).with.offset(-10);
    }];
}

- (void)_setupLineView {
    self.lineView = ({
        UIView* v = [[UIView alloc] init];
        v.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        v;
    });
    [self addSubview:self.lineView];
}

- (void)_setupCommentTextView {
    self.commentTextView = ({
        UITextView* tv = [[UITextView alloc] init];
        tv.layer.cornerRadius = 2;
        tv.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f];
        tv.textColor = [UIColor whiteColor];
        tv.keyboardAppearance = UIKeyboardAppearanceDark;
        tv.font = [UIFont boldSystemFontOfSize:14];
        tv;
    });
    [self addSubview:self.commentTextView];
}
- (void)_setupSubmitButton {
    self.submitButton = ({
        _weak(self);
        UIButton* btn = [[UIButton alloc] init];
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        btn.layer.cornerRadius = 2.f;
        btn.layer.borderColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.3] CGColor];
        btn.layer.borderWidth = 1.f;
        [btn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong(self);
            NSMutableString* commentContent = [self.commentTextView.text mutableCopy];
            NSNumber* parentCommentID = self.comment ? @(self.comment.shareId) : @0;
            NSString* tmp = commentContent;
            if (self.placeholderString) {
                tmp = [commentContent stringByReplacingOccurrencesOfString:self.placeholderString withString:@""];
            }
            if ([NSString isNilEmptyOrBlankString:tmp]) {
                [MBProgressHUD showErrorWithMessage:@"请输入回复内容"];
                return;
            }
            GCBlockInvoke(self.submitAction, self.commentTextView.text, parentCommentID);
        }];
        btn;
    });
    [self addSubview:self.submitButton];
}

@end
