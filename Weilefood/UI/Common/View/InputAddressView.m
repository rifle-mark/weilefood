//
//  InputAddressView.m
//  Weilefood
//
//  Created by kelei on 15/8/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "InputAddressView.h"
#import "InputView.h"
#import "UITextView+Placeholder.h"

@interface InputAddressView ()

@property (nonatomic, strong) InputView *nameInputView;
@property (nonatomic, strong) InputView *phoneInputView;
@property (nonatomic, strong) InputView *cityInputView;
@property (nonatomic, strong) InputView *addressInputView;
@property (nonatomic, strong) InputView *zipCodeInputView;

@end

static NSInteger const kContentMargin = 11;
static NSInteger const kInputSpacing  = 5;
static NSInteger const kAddressHeight = 80;

static NSInteger const kTitleWidth = 80;

@implementation InputAddressView

+ (CGFloat)viewHeight {
    return kContentMargin
    + [InputView viewHeightOfStyleOneLine] * 4 + kAddressHeight + kInputSpacing * 4
    + kContentMargin;
}

- (id)init {
    if (self = [super init]) {
        [self selfInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self selfInit];
    }
    return self;
}

- (void)selfInit {
    [self addSubview:self.nameInputView];
    [self addSubview:self.phoneInputView];
    [self addSubview:self.cityInputView];
    [self addSubview:self.addressInputView];
    [self addSubview:self.zipCodeInputView];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.nameInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self).insets(UIEdgeInsetsMake(kContentMargin, kContentMargin, 0, kContentMargin));
    }];
    [self.phoneInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameInputView);
        make.top.equalTo(self.nameInputView.mas_bottom).offset(kInputSpacing);
    }];
    [self.cityInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneInputView);
        make.top.equalTo(self.phoneInputView.mas_bottom).offset(kInputSpacing);
    }];
    [self.addressInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.cityInputView);
        make.top.equalTo(self.cityInputView.mas_bottom).offset(kInputSpacing);
        make.height.equalTo(@(kAddressHeight));
    }];
    [self.zipCodeInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.addressInputView);
        make.top.equalTo(self.addressInputView.mas_bottom).offset(kInputSpacing);
    }];
    
    [super updateConstraints];
}

#pragma mark - public methods

- (NSString *)name {
    return self.nameInputView.textField.text;
}

- (void)setName:(NSString *)name {
    self.nameInputView.textField.text = name;
}

- (NSString *)phone {
    return self.phoneInputView.textField.text;
}

- (void)setPhone:(NSString *)phone {
    self.phoneInputView.textField.text = phone;
}

- (NSString *)city {
    return self.cityInputView.textField.text;
}

- (void)setCity:(NSString *)city {
    self.cityInputView.textField.text = city;
}

- (NSString *)address {
    return self.addressInputView.textView.text;
}

- (void)setAddress:(NSString *)address {
    self.addressInputView.textView.text = address;
}

- (NSString *)zipCode {
    return self.zipCodeInputView.textField.text;
}

- (void)setZipCode:(NSString *)zipCode {
    self.zipCodeInputView.textField.text = zipCode;
}

- (BOOL)checkInput {
    if (!self.name || self.name.length <= 0) {
        NSString *msg = [NSString stringWithFormat:@"请输入 %@", self.nameInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.nameInputView.textField becomeFirstResponder];
        return NO;
    }
    if (self.name.length < 2) {
        NSString *msg = [NSString stringWithFormat:@"%@ 内容太少，请补充", self.nameInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.nameInputView.textField becomeFirstResponder];
        return NO;
    }
    if (!self.phone || self.phone.length <= 0) {
        NSString *msg = [NSString stringWithFormat:@"请输入 %@", self.phoneInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.phoneInputView.textField becomeFirstResponder];
        return NO;
    }
    if (self.phone.length != 11) {
        NSString *msg = [NSString stringWithFormat:@"请输入有效的 %@", self.phoneInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.phoneInputView.textField becomeFirstResponder];
        return NO;
    }
    if (!self.city || self.city.length <= 0) {
        NSString *msg = [NSString stringWithFormat:@"请输入 %@", self.cityInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.cityInputView.textField becomeFirstResponder];
        return NO;
    }
    if (self.city.length < 6) {
        NSString *msg = [NSString stringWithFormat:@"%@ 内容太少，请补充", self.cityInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.cityInputView.textField becomeFirstResponder];
        return NO;
    }
    if (!self.address || self.address.length <= 0) {
        NSString *msg = [NSString stringWithFormat:@"请输入 %@", self.addressInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.addressInputView.textView becomeFirstResponder];
        return NO;
    }
    if (self.address.length < 4) {
        NSString *msg = [NSString stringWithFormat:@"%@ 内容太少，请补充", self.addressInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.addressInputView.textView becomeFirstResponder];
        return NO;
    }
    if (!self.zipCode || self.zipCode.length <= 0) {
        NSString *msg = [NSString stringWithFormat:@"请输入 %@", self.zipCodeInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.zipCodeInputView.textField becomeFirstResponder];
        return NO;
    }
    if (self.zipCode.length != 6) {
        NSString *msg = [NSString stringWithFormat:@"请输入有效的 %@", self.zipCodeInputView.titleLabel.text];
        [MBProgressHUD showErrorWithMessage:msg];
        [self.zipCodeInputView.textField becomeFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - private property methods

- (InputView *)nameInputView {
    if (!_nameInputView) {
        _nameInputView = [[InputView alloc] init];
        _nameInputView.titleWidth = kTitleWidth;
        _nameInputView.titleLabel.text = @"收货人姓名";
        _nameInputView.textField.returnKeyType = UIReturnKeyNext;
        _weak(self);
        [_nameInputView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self.phoneInputView.textField becomeFirstResponder];
            return NO;
        }];
    }
    return _nameInputView;
}

- (InputView *)phoneInputView {
    if (!_phoneInputView) {
        _phoneInputView = [[InputView alloc] init];
        _phoneInputView.titleWidth = kTitleWidth;
        _phoneInputView.titleLabel.text = @"联系电话";
        _phoneInputView.textField.returnKeyType = UIReturnKeyNext;
        _phoneInputView.textField.keyboardType = UIKeyboardTypePhonePad;
        _weak(self);
        [_phoneInputView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self.cityInputView.textField becomeFirstResponder];
            return NO;
        }];
    }
    return _phoneInputView;
}

- (InputView *)cityInputView {
    if (!_cityInputView) {
        _cityInputView = [[InputView alloc] init];
        _cityInputView.titleWidth = kTitleWidth;
        _cityInputView.titleLabel.text = @"收货地址";
        _cityInputView.textField.returnKeyType = UIReturnKeyNext;
        _cityInputView.textField.placeholder = @"省、市、区";
        _weak(self);
        [_cityInputView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            _strong_check(self, NO);
            [self.addressInputView.textView becomeFirstResponder];
            return NO;
        }];
    }
    return _cityInputView;
}

- (InputView *)addressInputView {
    if (!_addressInputView) {
        _addressInputView = [[InputView alloc] initWithStyle:InputViewStyleMultiLine];
        _addressInputView.titleLabel.text = @"详细地址";
        _addressInputView.titleLabel.hidden = YES;
        _addressInputView.textField.hidden = YES;
        
        _addressInputView.textView.placeholder = @"输入详细地址";
        _addressInputView.textView.returnKeyType = UIReturnKeyNext;
        _weak(self);
        [_addressInputView.textView withBlockForShouldChangeText:^BOOL(UITextView *view, NSRange range, NSString *text) {
            _strong_check(self, NO);
            if ([text isEqualToString:@"\n"]) {
                [self.zipCodeInputView.textField becomeFirstResponder];
                return NO;
            }
            return YES;
        }];
    }
    return _addressInputView;
}

- (InputView *)zipCodeInputView {
    if (!_zipCodeInputView) {
        _zipCodeInputView = [[InputView alloc] init];
        _zipCodeInputView.titleWidth = kTitleWidth;
        _zipCodeInputView.titleLabel.text = @"邮政编码";
        _zipCodeInputView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _zipCodeInputView.textField.returnKeyType = UIReturnKeyDone;
        [_zipCodeInputView.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
            [view resignFirstResponder];
            return NO;
        }];
    }
    return _zipCodeInputView;
}

@end
