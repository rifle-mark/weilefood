//
//  MyFavoriteCell.m
//  Weilefood
//
//  Created by kelei on 15/9/1.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MyFavoriteCell.h"

@implementation UILabel (FixesNumberOfLines)
- (void) layoutSubviews {
    [super layoutSubviews];
    self.preferredMaxLayoutWidth = self.bounds.size.width;
}
@end

@interface MyFavoriteCell ()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MyFavoriteCell

+ (CGFloat)cellHeight {
    return 75;
}

+ (NSString *)reuseIdentifier {
    return @"MyFavoriteCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)updateConstraints {
    [self.typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.titleLabel);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(@0);
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (void)setType:(NSString *)type {
    _type = [type copy];
    self.typeLabel.text = type;
}

- (void)setTypeColor:(UIColor *)typeColor {
    _typeColor = typeColor;
    self.typeLabel.textColor = typeColor;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

#pragma mark - private property methods

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont boldSystemFontOfSize:15];
        [_typeLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _typeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = k_COLOR_SLATEGRAY;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

@end
