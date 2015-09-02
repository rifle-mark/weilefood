//
//  OrderInfoHeaderCell.m
//  Weilefood
//
//  Created by kelei on 15/8/27.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "OrderInfoHeaderCell.h"

@interface OrderInfoHeaderCell ()

@property (nonatomic, strong) UILabel *nameTitleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneTitleLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *zipCodeTitleLabel;
@property (nonatomic, strong) UILabel *zipCodeLabel;
@property (nonatomic, strong) UIView  *lineView1;
@property (nonatomic, strong) UILabel *expressNameTitleLabel;
@property (nonatomic, strong) UILabel *expressNameLabel;
@property (nonatomic, strong) UILabel *expressNumTitleLabel;
@property (nonatomic, strong) UILabel *expressNumLabel;
@property (nonatomic, strong) UIView  *lineView2;

@end

static NSInteger const kTextTopBottmMargin  = 25;
static NSInteger const kTextLeftRigthMargin = 11;
static NSInteger const kValueLeftMargin     = 110;
static NSInteger const kLine2Height         = 7;

#define kTextFont [UIFont systemFontOfSize:14]

@implementation OrderInfoHeaderCell

+ (CGFloat)cellHeightWithAddress:(NSString *)address isShowExpressInfo:(BOOL)isShowExpressInfo {
    UIFont *font = kTextFont;
    CGFloat addressWidth = SCREEN_WIDTH - kValueLeftMargin - kTextTopBottmMargin;
    CGFloat addressHeight = [address boundingRectWithSize:CGSizeMake(addressWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size.height;
    
    CGFloat ret = kTextTopBottmMargin + font.lineHeight
    + kTextTopBottmMargin + font.lineHeight
    + kTextTopBottmMargin + addressHeight
    + kTextTopBottmMargin + font.lineHeight;
    if (isShowExpressInfo) {
        ret += kTextTopBottmMargin
        + kTextTopBottmMargin + font.lineHeight
        + kTextTopBottmMargin + font.lineHeight;
    }
    ret += kTextTopBottmMargin + kLine2Height;
    return ret;

}

+ (NSString *)reuseIdentifier {
    return @"OrderInfoHeaderCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *views = @[self.nameTitleLabel, self.nameLabel,
                           self.phoneTitleLabel, self.phoneLabel,
                           self.addressTitleLabel, self.addressLabel,
                           self.zipCodeTitleLabel, self.zipCodeLabel,
                           self.expressNameTitleLabel, self.expressNameLabel,
                           self.expressNumTitleLabel, self.expressNumLabel,
                           self.lineView1, self.lineView2];
        for (UIView *view in views) {
            [self.contentView addSubview:view];
        }
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    [self.nameTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kTextLeftRigthMargin));
        make.top.equalTo(self.nameTitleLabel.superview).offset(kTextTopBottmMargin);
    }];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kValueLeftMargin));
        make.right.equalTo(self.contentView).offset(-kTextLeftRigthMargin);
        make.top.equalTo(self.nameTitleLabel);
    }];
    [self.phoneTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kTextLeftRigthMargin));
        make.top.equalTo(self.nameTitleLabel.mas_baseline).offset(kTextTopBottmMargin);
    }];
    [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kValueLeftMargin));
        make.right.equalTo(self.contentView).offset(-kTextLeftRigthMargin);
        make.top.equalTo(self.phoneTitleLabel);
    }];
    [self.addressTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kTextLeftRigthMargin));
        make.top.equalTo(self.phoneTitleLabel.mas_baseline).offset(kTextTopBottmMargin);
    }];
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kValueLeftMargin));
        make.right.equalTo(self.contentView).offset(-kTextLeftRigthMargin);
        make.top.equalTo(self.addressTitleLabel);
    }];
    [self.zipCodeTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kTextLeftRigthMargin));
        make.top.equalTo(self.addressLabel.mas_baseline).offset(kTextTopBottmMargin);
    }];
    [self.zipCodeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kValueLeftMargin));
        make.right.equalTo(self.contentView).offset(-kTextLeftRigthMargin);
        make.top.equalTo(self.zipCodeTitleLabel);
    }];
    if (self.isShowExpressInfo) {
        [self.lineView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lineView1.superview).insets(UIEdgeInsetsMake(0, kTextLeftRigthMargin, 0, kTextLeftRigthMargin));
            make.top.equalTo(self.zipCodeLabel.mas_baseline).offset(kTextTopBottmMargin);
            make.height.equalTo(@k1pxWidth);
        }];
        [self.expressNameTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kTextLeftRigthMargin));
            make.top.equalTo(self.lineView1).offset(kTextTopBottmMargin);
        }];
        [self.expressNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kValueLeftMargin));
            make.right.equalTo(self.contentView).offset(-kTextLeftRigthMargin);
            make.top.equalTo(self.expressNameTitleLabel);
        }];
        [self.expressNumTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kTextLeftRigthMargin));
            make.top.equalTo(self.expressNameTitleLabel.mas_baseline).offset(kTextTopBottmMargin);
        }];
        [self.expressNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kValueLeftMargin));
            make.right.equalTo(self.contentView).offset(-kTextLeftRigthMargin);
            make.top.equalTo(self.expressNumTitleLabel);
        }];
    }
    [self.lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.lineView2.superview);
        make.height.equalTo(@(kLine2Height));
    }];
    [super updateConstraints];
}

#pragma mark - public methods

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setPhone:(NSString *)phone {
    _phone = [phone copy];
    self.phoneLabel.text = phone;
}

- (void)setAddress:(NSString *)address {
    _address = [address copy];
    self.addressLabel.text = address;
}

- (void)setZipCode:(NSString *)zipCode {
    _zipCode = [zipCode copy];
    self.zipCodeLabel.text = zipCode;
}

- (void)setIsShowExpressInfo:(BOOL)isShowExpressInfo {
    _isShowExpressInfo = isShowExpressInfo;
    [self setNeedsUpdateConstraints];
}

- (void)setExpressName:(NSString *)expressName {
    _expressName = [expressName copy];
    self.expressNameLabel.text = expressName;
}

- (void)setExpressNum:(NSString *)expressNum {
    _expressNum = [expressNum copy];
    self.expressNumLabel.text = expressNum;
}

#pragma mark - private methods

- (UILabel *)_createTitleLabel {
    return ({
        UILabel *v = [[UILabel alloc] init];
        v.font = kTextFont;
        v.textColor = k_COLOR_SLATEGRAY;
        v;
    });
}

- (UILabel *)_createValueLabel {
    return ({
        UILabel *v = [[UILabel alloc] init];
        v.font = kTextFont;
        v.textColor = k_COLOR_STAR_DUST;
        v;
    });
}

- (UIView *)_createView {
    return ({
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = k_COLOR_LAVENDER;
        v;
    });
}

#pragma mark - private property methods

- (UILabel *)nameTitleLabel {
    if (!_nameTitleLabel) {
        _nameTitleLabel = [self _createTitleLabel];
        _nameTitleLabel.text = @"收货人姓名";
    }
    return _nameTitleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [self _createValueLabel];
    }
    return _nameLabel;
}

- (UILabel *)phoneTitleLabel {
    if (!_phoneTitleLabel) {
        _phoneTitleLabel = [self _createTitleLabel];
        _phoneTitleLabel.text = @"联系电话";
    }
    return _phoneTitleLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [self _createValueLabel];
    }
    return _phoneLabel;
}

- (UILabel *)addressTitleLabel {
    if (!_addressTitleLabel) {
        _addressTitleLabel = [self _createTitleLabel];
        _addressTitleLabel.text = @"收货地址";
    }
    return _addressTitleLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [self _createValueLabel];
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

- (UILabel *)zipCodeTitleLabel {
    if (!_zipCodeTitleLabel) {
        _zipCodeTitleLabel = [self _createTitleLabel];
        _zipCodeTitleLabel.text = @"邮政编码";
    }
    return _zipCodeTitleLabel;
}

- (UILabel *)zipCodeLabel {
    if (!_zipCodeLabel) {
        _zipCodeLabel = [self _createValueLabel];
    }
    return _zipCodeLabel;
}

- (UILabel *)expressNameTitleLabel {
    if (!_expressNameTitleLabel) {
        _expressNameTitleLabel = [self _createTitleLabel];
        _expressNameTitleLabel.text = @"承运人";
    }
    return _expressNameTitleLabel;
}

- (UILabel *)expressNameLabel {
    if (!_expressNameLabel) {
        _expressNameLabel = [self _createValueLabel];
    }
    return _expressNameLabel;
}

- (UILabel *)expressNumTitleLabel {
    if (!_expressNumTitleLabel) {
        _expressNumTitleLabel = [self _createTitleLabel];
        _expressNumTitleLabel.text = @"运单编号";
    }
    return _expressNumTitleLabel;
}

- (UILabel *)expressNumLabel {
    if (!_expressNumLabel) {
        _expressNumLabel = [self _createValueLabel];
    }
    return _expressNumLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [self _createView];
    }
    return _lineView1;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [self _createView];
    }
    return _lineView2;
}

@end
