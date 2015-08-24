//
//  DoctorDescriptionCell.m
//  Weilefood
//
//  Created by kelei on 15/8/24.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorDescriptionCell.h"

@interface DoctorDescriptionCell ()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView  *lineView;

@end

static NSInteger const kDescTopMargin       = 5;
static NSInteger const kDescLeftRightMargin = 12;
static NSInteger const kDescBottomMargin    = 20;
static NSInteger const kLineHeight          = 7;

#define kDescFont [UIFont systemFontOfSize:14]

@implementation DoctorDescriptionCell

+ (CGFloat)cellHeightWithDesc:(NSString *)desc {
    CGFloat descWidth = SCREEN_WIDTH - kDescLeftRightMargin * 2;
    CGFloat descHeight = [desc boundingRectWithSize:CGSizeMake(descWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kDescFont} context:nil].size.height;
    return kDescTopMargin + descHeight + kDescBottomMargin + kLineHeight;
}

+ (NSString *)reuseIdentifier {
    return @"DoctorDescriptionCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.lineView];
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(kDescTopMargin, kDescLeftRightMargin, 0, kDescLeftRightMargin));
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(kLineHeight));
    }];
}

#pragma mark - public methods

- (void)setDesc:(NSString *)desc {
    _desc = [desc copy];
    self.descLabel.text = desc;
}

#pragma mark - private property methods

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = kDescFont;
        _descLabel.textColor = k_COLOR_STAR_DUST;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _lineView;
}

@end
