//
//  DoctorServiceCell.m
//  Weilefood
//
//  Created by kelei on 15/8/23.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "DoctorServiceCell.h"

@interface DoctorServiceCell ()

@property (nonatomic, strong) UIView   *view;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UILabel  *descLabel;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, copy) BuyClickBlock buyClickBlock;

@end

static NSInteger const kContentMargin   = 12;
static NSInteger const kNameHeight      = 56;
static NSInteger const kDescMargin      = 18;
static NSInteger const kBuyTopMargin    = 21;
static NSInteger const kBuyHeight       = 48;
static NSInteger const kBuyBottomMargin = 10;

#define kDescFont [UIFont systemFontOfSize:15]

@implementation DoctorServiceCell

+ (CGFloat)cellHeightWithDesc:(NSString *)desc {
    CGFloat descWidth = SCREEN_WIDTH - kContentMargin * 2 - kDescMargin * 2;
    CGFloat descHeight = [desc boundingRectWithSize:CGSizeMake(descWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kDescFont} context:nil].size.height;
    return kContentMargin
    + kNameHeight
    + kDescMargin + descHeight
    + kBuyTopMargin + kBuyHeight + kBuyBottomMargin;
}

+ (NSString *)reuseIdentifier {
    return @"DoctorServiceCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.view];
        [self.view addSubview:self.nameLabel];
        [self.view addSubview:self.descLabel];
        [self.view addSubview:self.lineView];
        [self.view addSubview:self.buyButton];
        
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.superview).insets(UIEdgeInsetsMake(kContentMargin, kContentMargin, 0, kContentMargin));
    }];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.nameLabel.superview);
        make.height.equalTo(@(kNameHeight));
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.nameLabel);
        make.height.equalTo(@k1pxWidth);
    }];
    [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel).insets(UIEdgeInsetsMake(0, kDescMargin, 0, kDescMargin));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kDescMargin);
    }];
    [self.buyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.descLabel);
        make.top.equalTo(self.descLabel.mas_baseline).offset(kBuyTopMargin);
        make.height.equalTo(@(kBuyHeight));
    }];
}

#pragma mark - public methods

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setDesc:(NSString *)desc {
    _desc = [desc copy];
    self.descLabel.text = desc;
}

- (void)setPrice:(CGFloat)price {
    _price = price;
    [self.buyButton setTitle:[NSString stringWithFormat:@"￥%.2f 购买", price] forState:UIControlStateNormal];
}

- (void)buyClickBlock:(BuyClickBlock)block {
    self.buyClickBlock = block;
}

#pragma mark - private property methods

- (UIView *)view {
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.backgroundColor = k_COLOR_MEDIUM_AQUAMARINE;
        _view.layer.cornerRadius = 4;
    }
    return _view;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_SILVER_TREE;
    }
    return _lineView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:26];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = k_COLOR_WHITE;
        _nameLabel.layer.shadowColor = k_COLOR_BLACK.CGColor;
        _nameLabel.layer.shadowOpacity = 0.2;
        _nameLabel.layer.shadowOffset = CGSizeMake(0, -1);
        _nameLabel.layer.shadowRadius = 10;
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textColor = k_COLOR_WHITE;
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [_buyButton setTitleColor:k_COLOR_ANZAC forState:UIControlStateNormal];
        [_buyButton setBackgroundImage:[UIImage imageNamed:@"doctorinfo_btn_buy"] forState:UIControlStateNormal];
        _weak(self);
        [_buyButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.buyClickBlock, self);
        }];
    }
    return _buyButton;
}

@end
