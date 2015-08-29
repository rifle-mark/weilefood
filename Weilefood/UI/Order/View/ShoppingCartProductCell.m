//
//  ShoppingCartProductCell.m
//  Weilefood
//
//  Created by kelei on 15/8/25.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ShoppingCartProductCell.h"

@interface ShoppingCartProductCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UIButton    *selectButton;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UILabel     *quantityLabel;
@property (nonatomic, strong) UILabel     *quantityLabel2;
@property (nonatomic, strong) UIButton    *addButton;
@property (nonatomic, strong) UIButton    *lessButton;
@property (nonatomic, strong) UIView      *lineView;

@property (nonatomic, copy) ShoppingCartProductCellStdBlock quantityChangedBlock;
@property (nonatomic, copy) ShoppingCartProductCellStdBlock isSelectedChangedBlock;

@end

@implementation ShoppingCartProductCell

+ (CGFloat)cellHeight {
    return 123;
}

+ (NSString *)reuseIdentifier {
    return @"ShoppingCartProductCell";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _displaySelectControl = YES;
        _displayQuantityControl = YES;
        
        NSArray *views = @[self.picImageView, self.selectButton, self.nameLabel, self.priceLabel,
                           self.quantityLabel2,
                           self.quantityLabel, self.addButton, self.lessButton, self.lineView];
        for (UIView *view in views) {
            [self.contentView addSubview:view];
        }
        
        [self _remakeConstraints];
    }
    return self;
}

- (void)_remakeConstraints {
    [self.picImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.picImageView.superview).insets(UIEdgeInsetsMake(11, 11, 11, 0));
        make.width.equalTo(self.picImageView.mas_height);
    }];
    [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.picImageView);
        make.width.height.equalTo(@30);
    }];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_right).offset(17);
        make.right.equalTo(self.nameLabel.superview).offset(-11);
        make.top.equalTo(self.picImageView);
    }];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.quantityLabel.mas_top).offset(-12);
    }];
    
    [self.lessButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.picImageView);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    [self.quantityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lessButton.mas_right).offset(-k1pxWidth);
        make.bottom.height.equalTo(self.lessButton);
        make.width.equalTo(@49);
    }];
    [self.quantityLabel2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.lessButton);
    }];
    [self.addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.quantityLabel.mas_right).offset(-k1pxWidth);
        make.bottom.width.height.equalTo(self.lessButton);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.lineView.superview);
        make.height.equalTo(@k1pxWidth);
    }];
}

#pragma mark - public methods

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    [self.picImageView my_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}

- (void)setPrice:(CGFloat)price {
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", price];
}

- (void)setQuantity:(NSInteger)quantity {
    _quantity = quantity;
    self.quantityLabel.text = [NSString stringWithFormat:@"%ld", (long)quantity];
    self.quantityLabel2.text = [NSString stringWithFormat:@"× %ld", (long)quantity];
    self.lessButton.enabled = quantity > 1;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    NSString *imageNamed = isSelected ? @"shoppingcart_btn_select_h" : @"shoppingcart_btn_select_n";
    [self.selectButton setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
}

- (void)setDisplaySelectControl:(BOOL)displaySelectControl {
    _displaySelectControl = displaySelectControl;
    self.selectButton.hidden = !displaySelectControl;
}

- (void)setDisplayQuantityControl:(BOOL)displayQuantityControl {
    _displayQuantityControl = displayQuantityControl;
    self.lessButton.hidden    = !displayQuantityControl;
    self.quantityLabel.hidden = !displayQuantityControl;
    self.addButton.hidden     = !displayQuantityControl;
}

- (void)quantityChangedBlock:(ShoppingCartProductCellStdBlock)block {
    self.quantityChangedBlock = block;
}

- (void)isSelectedChangedBlock:(ShoppingCartProductCellStdBlock)block {
    self.isSelectedChangedBlock = block;
}

#pragma mark - private property methods

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
    }
    return _picImageView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weak(self);
        [_selectButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.isSelected = !self.isSelected;
            GCBlockInvoke(self.isSelectedChangedBlock, self);
        }];
    }
    return _selectButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = k_COLOR_DIMGRAY;
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:14];
        _priceLabel.textColor = k_COLOR_ANZAC;
    }
    return _priceLabel;
}

- (UILabel *)quantityLabel {
    if (!_quantityLabel) {
        _quantityLabel = [[UILabel alloc] init];
        _quantityLabel.backgroundColor = k_COLOR_WHITE;
        _quantityLabel.font = [UIFont systemFontOfSize:16];
        _quantityLabel.textColor = k_COLOR_ORANGE;
        _quantityLabel.textAlignment = NSTextAlignmentCenter;
        _quantityLabel.layer.borderWidth = k1pxWidth;
        _quantityLabel.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
    }
    return _quantityLabel;
}

- (UILabel *)quantityLabel2 {
    if (!_quantityLabel2) {
        _quantityLabel2 = [[UILabel alloc] init];
        _quantityLabel2.font = [UIFont boldSystemFontOfSize:15];
        _quantityLabel2.textColor = k_COLOR_DIMGRAY;
    }
    return _quantityLabel2;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = k_COLOR_WHITE;
        _addButton.layer.borderWidth = k1pxWidth;
        _addButton.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        [_addButton setImage:[UIImage imageNamed:@"shoppingcart_btn_add_n"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"shoppingcart_btn_add_d"] forState:UIControlStateDisabled];
        _weak(self);
        [_addButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.quantity++;
            GCBlockInvoke(self.quantityChangedBlock, self);
        }];
    }
    return _addButton;
}

- (UIButton *)lessButton {
    if (!_lessButton) {
        _lessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lessButton.backgroundColor = k_COLOR_WHITE;
        _lessButton.layer.borderWidth = k1pxWidth;
        _lessButton.layer.borderColor = k_COLOR_DARKGRAY.CGColor;
        [_lessButton setImage:[UIImage imageNamed:@"shoppingcart_btn_less_n"] forState:UIControlStateNormal];
        [_lessButton setImage:[UIImage imageNamed:@"shoppingcart_btn_less_d"] forState:UIControlStateDisabled];
        _weak(self);
        [_lessButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.quantity--;
            GCBlockInvoke(self.quantityChangedBlock, self);
        }];
    }
    return _lessButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineView;
}

@end
