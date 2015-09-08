//
//  DoctorDescriptionCell.m
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorDescriptionCell.h"

@interface DoctorDescriptionCell ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView  *lineView;

@property (nonatomic, copy  ) DoctorDescriptionCellResetHeightBlock resetHeightBlock;

@end

static NSInteger const kDescTopBottomMargin = 10;
static NSInteger const kDescLeftRightMargin = 12;
static NSInteger const kLineHeight          = 7;

#define kDescFont [UIFont systemFontOfSize:14]

@implementation DoctorDescriptionCell

+ (NSString *)reuseIdentifier {
    return @"DoctorDescriptionCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.webView];
        [self.contentView addSubview:self.lineView];
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(kDescTopBottomMargin, kDescLeftRightMargin, 0, kDescLeftRightMargin));
        make.bottom.equalTo(self.lineView.mas_top).offset(-kDescTopBottomMargin);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(kLineHeight));
    }];
}

#pragma mark - public methods

- (void)setDesc:(NSString *)desc {
    _desc = [desc copy];
    [self.webView loadHTMLString:desc baseURL:nil];
}

- (void)resetHeightBlock:(DoctorDescriptionCellResetHeightBlock)resetHeightBlock {
    self.resetHeightBlock = resetHeightBlock;
}

#pragma mark - private property methods

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.scrollEnabled = NO;
        _weak(self);
        [_webView withBlockForDidFinishLoad:^(UIWebView *view) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _strong_check(self);
                CGFloat newHeight = kDescTopBottomMargin + self.webView.scrollView.contentSize.height + kDescTopBottomMargin + kLineHeight;
                GCBlockInvoke(self.resetHeightBlock, newHeight);
            });
        }];
    }
    return _webView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineView;
}

@end
