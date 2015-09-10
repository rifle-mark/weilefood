//
//  MyCommentCell.m
//  Weilefood
//
//  Created by makewei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyCommentCell.h"

#import "WLModelHeader.h"

@interface MyCommentCell ()

@property(nonatomic,strong)UITextView   *commentContentT;
@property(nonatomic,strong)UILabel      *timeL;
@property(nonatomic,strong)UILabel      *fromL;
@property(nonatomic,strong)UIButton     *subjectBtn;
@property(nonatomic,strong)UIView       *seperatorV;

@property (nonatomic,strong) WLCommentModel    *comment;
@property (nonatomic,assign) MyCommentCellMode mode;

@end

@implementation MyCommentCell

+ (NSString *)reuseIdentify {
    return @"MyCommentCellIdentify";
}

+ (CGFloat)heightOfCellWithComment:(WLCommentModel*)comment mode:(MyCommentCellMode)mode {
    return  20/*top margin*/
            + 20/*content<-->time*/
            + 12/*time height*/
            + 5/*time<-->from*/
            + 14/*from height*/
            + 15/*bottom margin*/
            + 5/*separator height*/
            + ceil([[[self class] contentAttributedStringOfComment:comment mode:mode] boundingRectWithSize:ccs([UIScreen mainScreen].bounds.size.width-30, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
}

+ (NSAttributedString *)contentAttributedStringOfComment:(WLCommentModel *)comment mode:(MyCommentCellMode)mode {
    
    NSMutableAttributedString *replyString = nil;
    NSMutableAttributedString *contentString = nil;
    if (comment.parentId != 0) {
        NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
        ps.lineSpacing = 5;
        NSString *replyStr = mode == MyCommentCellModeMyReply ? [NSString stringWithFormat:@"回复 %@: ", comment.toNickName] : [NSString stringWithFormat:@"%@ 回复: ", comment.nickName];
        replyString = [[NSMutableAttributedString alloc]
                       initWithString:replyStr
                       attributes:@{NSParagraphStyleAttributeName:ps,
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                    NSForegroundColorAttributeName:k_COLOR_SLATEGRAY}];
        [replyString addAttribute:NSLinkAttributeName value:@"foodcircle://userClick" range:[[replyString string] rangeOfString:[NSString stringWithFormat:@"%@", mode == MyCommentCellModeMyReply ? comment.toNickName : comment.nickName]]];
        [replyString addAttribute:NSForegroundColorAttributeName value:k_COLOR_GOLDENROD range:[[replyString string] rangeOfString:[NSString stringWithFormat:@"%@", mode == MyCommentCellModeMyReply ? comment.toNickName : comment.nickName]]];
    }
    NSMutableParagraphStyle *ps1 = [[NSMutableParagraphStyle alloc] init];
    ps1.lineSpacing = 5;
    contentString = [[NSMutableAttributedString alloc]
                     initWithString:comment.content
                     attributes:@{NSParagraphStyleAttributeName:ps1,
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                  NSForegroundColorAttributeName:k_COLOR_SLATEGRAY}];
    if (replyString) {
        [replyString appendAttributedString:contentString];
        return replyString;
    }
    else {
        return contentString;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.commentContentT];
        [self.contentView addSubview:self.timeL];
        [self.contentView addSubview:self.fromL];
        [self.contentView addSubview:self.subjectBtn];
        [self.contentView addSubview:self.seperatorV];
        
        [self _setupObserver];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [self _layoutSubViews];
    [super updateConstraints];
}

#pragma mark - public

- (void)setComment:(WLCommentModel *)comment mode:(MyCommentCellMode)mode {
    self.comment = comment;
    self.mode = mode;
    self.commentContentT.attributedText = [[self class] contentAttributedStringOfComment:comment mode:self.mode];
    self.timeL.text = [self.comment.createDate timeAgoSinceNow];
    [self.subjectBtn setTitle:self.comment.title forState:UIControlStateNormal];
}

#pragma mark - private

- (void)_layoutSubViews {
    
    [self.commentContentT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentContentT.superview).with.offset(15);
        make.left.equalTo(self.commentContentT.superview).with.offset(15);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width-30));
    }];
    
    [self.timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentContentT.mas_bottom).with.offset(20);
        make.left.equalTo(self.commentContentT);
    }];
    
    [self.fromL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeL.mas_bottom).with.offset(5);
        make.left.equalTo(self.commentContentT);
    }];
    
    [self.subjectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fromL);
        make.left.equalTo(self.fromL.mas_right).with.offset(5);
        make.right.equalTo(self.commentContentT);
    }];
    
    [self.seperatorV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fromL.mas_bottom).with.offset(15);
        make.height.equalTo(@5);
        make.left.right.equalTo(self.seperatorV.superview);
    }];
}
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"needSeperator" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        self.seperatorV.hidden = !self.needSeperator;
    }];
}

#pragma mark - property

- (UITextView *)commentContentT {
    if (!_commentContentT) {
        _commentContentT = [[UITextView alloc] init];
        _commentContentT.editable = NO;
        _commentContentT.tintColor = k_COLOR_GOLDENROD;
        _commentContentT.textContainerInset = UIEdgeInsetsMake(5, 0, 0, 0);
        _commentContentT.showsHorizontalScrollIndicator = NO;
        _commentContentT.showsVerticalScrollIndicator = NO;
        _commentContentT.scrollEnabled = NO;
        _commentContentT.textContainer.lineFragmentPadding = 0;
        _weak(self);
        [_commentContentT withBlockForShouldInteractURL:^BOOL(UITextView *view, NSURL *url, NSRange range) {
            _strong_check(self, NO);
            GCBlockInvoke(self.userClickBlock, self.comment);
            return NO;
        }];
    }
    return _commentContentT;
}

- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [[UILabel alloc] init];
        _timeL.font = [UIFont boldSystemFontOfSize:12];
        _timeL.textColor = k_COLOR_DARKGRAY;
        _timeL.numberOfLines = 1;
    }
    return _timeL;
}

- (UILabel *)fromL {
    if (!_fromL) {
        _fromL = [[UILabel alloc] init];
        _fromL.font = [UIFont boldSystemFontOfSize:14];
        _fromL.textColor = k_COLOR_STAR_DUST;
        _fromL.text = @"来自: ";
        [_fromL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _fromL;
}

- (UIButton *)subjectBtn {
    if (!_subjectBtn) {
        _subjectBtn = [[UIButton alloc] init];
        _subjectBtn.backgroundColor = k_COLOR_CLEAR;
        [_subjectBtn setTitleColor:k_COLOR_GOLDENROD forState:UIControlStateNormal];
        _subjectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _subjectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _subjectBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _weak(self);
        [_subjectBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.subjectClickBlock, self.comment);
        }];
    }
    return _subjectBtn;
}

- (UIView *)seperatorV {
    if (!_seperatorV) {
        _seperatorV = [[UIView alloc] init];
        _seperatorV.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _seperatorV;
}
@end
