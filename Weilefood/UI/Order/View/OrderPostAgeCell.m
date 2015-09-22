//
//  OrderPostAgeCell.m
//  Weilefood
//
//  Created by kelei on 15/9/22.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderPostAgeCell.h"

@interface OrderPostAgeCell ()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *postAgeLabel;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation OrderPostAgeCell

/**
 *  Cell展示所需要的高度
 *
 *  @return 高度
 */
+ (CGFloat)cellHeight {
    return 65;
}

+ (NSString *)reuseIdentifier {
    return @"OrderItemPostAgeCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.postAgeLabel];
        [self.contentView addSubview:self.lineView];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(11);
        make.centerY.equalTo(@0);
    }];
    [self.postAgeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel.mas_right);
        make.right.equalTo(self.contentView).offset(-11);
        make.centerY.equalTo(@0);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (void)setPostAge:(CGFloat)postAge {
    _postAge = postAge;
    self.postAgeLabel.text = [NSString stringWithFormat:@"￥%.2f", postAge];
}

#pragma mark - private property methods

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:14];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
        [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"配送费" attributes:@{NSForegroundColorAttributeName: k_COLOR_SLATEGRAY}]];
        [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"（订单超过150元免配送费）" attributes:@{NSForegroundColorAttributeName: k_COLOR_STAR_DUST}]];
        _descLabel.attributedText = attrStr;
    }
    return _descLabel;
}

- (UILabel *)postAgeLabel {
    if (!_postAgeLabel) {
        _postAgeLabel = [[UILabel alloc] init];
        _postAgeLabel.font = [UIFont systemFontOfSize:14];
        _postAgeLabel.textColor = k_COLOR_ORANGE;
        [_postAgeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_postAgeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _postAgeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

@end
