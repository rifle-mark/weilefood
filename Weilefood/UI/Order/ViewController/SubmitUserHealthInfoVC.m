//
//  SubmitUserHealthInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SubmitUserHealthInfoVC.h"
#import "InputView.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"


@implementation UIImage (ColorImage)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end


@interface SubmitUserHealthInfoVC () <UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *contentView;

@property (nonatomic, strong) InputView *nameView;
@property (nonatomic, strong) InputView *sexView;
@property (nonatomic, strong) InputView *ageView;
@property (nonatomic, strong) InputView *telView;
@property (nonatomic, strong) InputView *heightView;
@property (nonatomic, strong) InputView *weightView;
@property (nonatomic, strong) InputView *waistView;
@property (nonatomic, strong) InputView *addressView;
@property (nonatomic, strong) InputView *secondNameView;
@property (nonatomic, strong) InputView *secondTelView;
@property (nonatomic, strong) InputView *isChronicView;
@property (nonatomic, strong) InputView *chronicNameView;
@property (nonatomic, strong) InputView *sickDescView;
@property (nonatomic, strong) InputView *demandView;
@property (nonatomic, strong) InputView *forbiddenFoodView;
@property (nonatomic, strong) InputView *breakfastView;
@property (nonatomic, strong) InputView *lunchView;
@property (nonatomic, strong) InputView *dinnerView;
@property (nonatomic, strong) InputView *otherDescView;
@property (nonatomic, strong) InputView *remarkView;

@property (nonatomic, strong) UIButton *sexButton;
@property (nonatomic, strong) UIButton *isChronicButton;
@property (nonatomic, strong) UIButton *diabetesButton;
@property (nonatomic, strong) UIButton *hypertensionButton;
@property (nonatomic, strong) UIButton *highCholesterolButton;
@property (nonatomic, strong) UIButton *chronicKidneyDiseaseButton;

@property (nonatomic, strong) UIView  *lineView1;
@property (nonatomic, strong) UIView  *lineView2;
@property (nonatomic, strong) UIView  *lineView3;
@property (nonatomic, strong) UILabel *line3TitleLabel;
@property (nonatomic, strong) UIView  *footerView;
@property (nonatomic, strong) UILabel *footerLabel;

@property (nonatomic, strong) UIActionSheet *sexActionSheet;
@property (nonatomic, strong) UIActionSheet *isChronicActionSheet;

@property (nonatomic, assign) long long orderId;
@property (nonatomic, copy  ) NSString  *sex;
@property (nonatomic, assign) BOOL      isChronic;

@end

static NSInteger kContentMargin = 15;
static NSInteger kViewSpaced = 5;

@implementation SubmitUserHealthInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithOrderId:方法来初始化本界面");
    return nil;
}

- (id)initWithOrderId:(long long)orderId {
    if (self = [super init]) {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写资料";
    self.view.backgroundColor = k_COLOR_WHITE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(_submitAction)];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    NSArray *views = @[self.nameView, self.sexView, self.ageView, self.telView, self.heightView, self.weightView,
                       self.waistView, self.addressView, self.secondNameView, self.secondTelView, self.isChronicView,
                       self.chronicNameView, self.sickDescView, self.demandView, self.forbiddenFoodView, self.breakfastView,
                       self.lunchView, self.dinnerView, self.otherDescView, self.remarkView,
                       self.lineView1, self.lineView2, self.lineView3, self.line3TitleLabel, self.footerView];
    for (UIView *view in views) {
        [self.contentView addSubview:view];
    }
    
    [self.sexView addSubview:self.sexButton];
    [self.isChronicView addSubview:self.isChronicButton];
    [self.chronicNameView addSubview:self.diabetesButton];
    [self.chronicNameView addSubview:self.hypertensionButton];
    [self.chronicNameView addSubview:self.highCholesterolButton];
    [self.chronicNameView addSubview:self.chronicKidneyDiseaseButton];
    [self.footerView addSubview:self.footerLabel];
    
    [self.scrollView handleKeyboard];
    
    self.sex = @"男";
    self.isChronic = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(self.scrollView);
    }];
    
    NSArray *views = @[self.nameView, @[self.sexView, self.ageView],
                       self.telView, @[self.heightView, self.weightView],
                       self.waistView, self.addressView, self.secondNameView, self.secondTelView,
                       self.lineView1, self.isChronicView, self.chronicNameView, self.sickDescView,
                       self.lineView2, self.demandView, self.forbiddenFoodView,
                       self.lineView3, self.line3TitleLabel,
                       self.breakfastView, self.lunchView, self.dinnerView, self.otherDescView, self.remarkView,
                       ];
    UIView *prevView = nil;
    for (id view in views) {
        if ([view isKindOfClass:[NSArray class]]) {
            UIView *viewLeft = ((NSArray *)view)[0];
            UIView *viewRight = ((NSArray *)view)[1];
            [viewLeft mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kContentMargin);
                make.top.equalTo(prevView.mas_bottom).offset(kViewSpaced);
            }];
            [viewRight mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(viewLeft.mas_right).offset(kViewSpaced);
                make.right.equalTo(self.contentView).offset(-kContentMargin);
                make.top.width.equalTo(viewLeft);
            }];
            prevView = viewLeft;
            continue;
        }
        else if ([view isKindOfClass:[InputView class]]) {
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, kContentMargin, 0, kContentMargin));
                if (prevView) {
                    CGFloat offset = [prevView isKindOfClass:[InputView class]] ? kViewSpaced : kContentMargin;
                    make.top.equalTo(prevView.mas_bottom).offset(offset);
                }
                else {
                    make.top.equalTo(self.contentView).offset(kContentMargin);
                }
                if (((InputView *)view).style == InputViewStyleMultiLine) {
                    make.height.equalTo(@90);
                }
            }];
        }
        else if ([view isKindOfClass:[UILabel class]]) {// 分隔线标题
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kContentMargin);
                make.top.equalTo(prevView.mas_bottom).offset(kContentMargin);
            }];
        }
        else {// 分隔线
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(prevView.mas_bottom).offset(kContentMargin);
                make.height.equalTo(@1);
            }];
        }
        prevView = view;
    }
    [self.footerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(prevView.mas_bottom).offset(kContentMargin);
    }];
    [self.footerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.footerView).insets(UIEdgeInsetsMake(kContentMargin, kContentMargin, kContentMargin, kContentMargin));
    }];
    
    [self.sexButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.sexView.textField);
    }];
    [self.isChronicButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.isChronicView.textField);
    }];
    
    [self.diabetesButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.chronicNameView.textView);
        make.height.equalTo(@28);
    }];
    [self.hypertensionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.diabetesButton.mas_right).offset(kViewSpaced);
        make.bottom.width.height.equalTo(self.diabetesButton);
    }];
    [self.highCholesterolButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hypertensionButton.mas_right).offset(kViewSpaced);
        make.bottom.width.height.equalTo(self.hypertensionButton);
    }];
    [self.chronicKidneyDiseaseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.highCholesterolButton.mas_right).offset(kViewSpaced);
        make.right.equalTo(self.chronicNameView.textView);
        make.bottom.width.height.equalTo(self.highCholesterolButton);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet == self.sexActionSheet) {
        self.sex = buttonIndex == 0 ? @"女" : @"男";
    }
    else if (actionSheet == self.isChronicActionSheet) {
        self.isChronic = buttonIndex == 0;
    }
}

#pragma mark - private methods

- (NSString *)_getChronicNames {
    NSString *chronicNames = @"";
    NSArray *buttons = @[self.diabetesButton, self.hypertensionButton, self.highCholesterolButton, self.chronicKidneyDiseaseButton];
    for (UIButton *btn in buttons) {
        if (btn.selected) {
            if (chronicNames.length > 0) {
                chronicNames = [chronicNames stringByAppendingString:@","];
            }
            chronicNames = [chronicNames stringByAppendingString:[btn titleForState:UIControlStateNormal]];
        }
    }
    return chronicNames;
}

- (void)_submitAction {
    _weak(self);
    [MBProgressHUD showLoadingWithMessage:nil];
    [[WLServerHelper sharedInstance] order_submitUserHealthInfoWithOrderId:self.orderId
                                                                  trueName:self.nameView.text
                                                                       sex:self.sex
                                                                       age:self.ageView.text
                                                                       tel:self.telView.text
                                                                    height:self.heightView.text
                                                                    weight:self.weightView.text
                                                                     waist:self.waistView.text
                                                                   address:self.addressView.text
                                                                secondName:self.secondNameView.text
                                                                 secondTel:self.secondTelView.text
                                                                 isChronic:self.isChronic ? @"是" : @"否"
                                                               chronicName:[self _getChronicNames]
                                                                  sickDesc:self.sickDescView.text
                                                                    demand:self.demandView.text
                                                             forbiddenFood:self.forbiddenFoodView.text
                                                                 breakfast:self.breakfastView.text
                                                                     lunch:self.lunchView.text
                                                                    dinner:self.dinnerView.text
                                                                 otherDesc:self.otherDescView.text
                                                                    remark:self.remarkView.text
                                                                  callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                                                                      [MBProgressHUD hideLoading];
                                                                      _strong_check(self);
                                                                      ServerHelperErrorHandle;
                                                                      [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOrderInfoChanged object:@(self.orderId)];
                                                                      [self.navigationController popViewControllerAnimated:YES];
                                                                  }];
}

- (NSArray *)_getTextViewWithSuperView:(UIView *)superView {
    NSMutableArray *ret = [NSMutableArray array];
    for (UIView *view in superView.subviews) {
        if ([view isKindOfClass:[UITextField class]]
            || [view isKindOfClass:[UITextView class]]) {
            [ret addObject:view];
        }
        else {
            [ret addObjectsFromArray:[self _getTextViewWithSuperView:view]];
        }
    }
    return ret;
}

- (UIView *)_getNextTextViewWithView:(UIView *)view {
    CGPoint viewPoint = [view convertRect:view.bounds toView:self.contentView].origin;
    CGPoint nextTextViewPoint = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
    UIView *nextTextView = nil;
    
    NSArray *textViews = [self _getTextViewWithSuperView:self.contentView];
    for (UIView *textView in textViews) {
        if (textView != view && !textView.hidden && textView.alpha > 0) {
            CGPoint point = [textView convertRect:view.bounds toView:self.contentView].origin;
            if ((point.y < nextTextViewPoint.y || (point.y == nextTextViewPoint.y && point.x < nextTextViewPoint.x))
                && (point.y > viewPoint.y || (point.y == viewPoint.y && point.x > viewPoint.x))) {
                nextTextViewPoint = point;
                nextTextView = textView;
            }
        }
    }
    return nextTextView;
}

- (InputView *)_createInputViewWithStyle:(InputViewStyle)style title:(NSString *)title {
    return [self _createInputViewWithStyle:style title:title keyboardType:UIKeyboardTypeDefault];
}

- (InputView *)_createInputViewWithStyle:(InputViewStyle)style title:(NSString *)title keyboardType:(UIKeyboardType)keyboardType {
    _weak(self);
    return ({
        InputView *v = [[InputView alloc] initWithStyle:style];
        v.titleLabel.text = title;
        v.titleLabel.textColor = RGB(60, 145, 139);
        if (style == InputViewStyleOneLine) {
            v.textField.textColor = k_COLOR_STAR_DUST;
            v.textField.keyboardType = keyboardType;
            v.textField.returnKeyType = UIReturnKeyNext;
            [v.textField withBlockForShouldReturn:^BOOL(UITextField *view) {
                _strong_check(self, NO);
                UIView *nextView = [self _getNextTextViewWithView:view];
                if (nextView) {
                    [nextView becomeFirstResponder];
                }
                else {
                    [view resignFirstResponder];
                }
                return NO;
            }];
        }
        else {
            v.textView.textColor = k_COLOR_STAR_DUST;
            v.textView.keyboardType = keyboardType;
            v.textView.returnKeyType = UIReturnKeyNext;
            [v.textView withBlockForShouldChangeText:^BOOL(UITextView *view, NSRange range, NSString *text) {
                _strong_check(self, NO);
                if (![text isEqualToString:@"\n"]) {
                    return YES;
                }
                UIView *nextView = [self _getNextTextViewWithView:view];
                if (nextView) {
                    [nextView becomeFirstResponder];
                }
                else {
                    [view resignFirstResponder];
                }
                return NO;
            }];
        }
        v;
    });
}

- (UIButton *)_createChronicButtonWithTitle:(NSString *)title {
    return ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.titleLabel.font = [UIFont systemFontOfSize:13];
        v.layer.cornerRadius = 4;
        v.clipsToBounds = YES;
        [v setBackgroundImage:[UIImage imageWithColor:k_COLOR_WHITE] forState:UIControlStateNormal];
        [v setBackgroundImage:[UIImage imageWithColor:k_COLOR_MEDIUM_AQUAMARINE] forState:UIControlStateHighlighted];
        [v setBackgroundImage:[UIImage imageWithColor:k_COLOR_MEDIUM_AQUAMARINE] forState:UIControlStateSelected];
        [v setTitleColor:k_COLOR_STAR_DUST forState:UIControlStateNormal];
        [v setTitleColor:k_COLOR_WHITE forState:UIControlStateHighlighted];
        [v setTitleColor:k_COLOR_WHITE forState:UIControlStateSelected];
        [v setTitle:title forState:UIControlStateNormal];
        [v addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            control.selected = !control.selected;
        }];
        v;
    });
}

- (UIView *)_createLineView {
    return ({
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = k_COLOR_WHITESMOKE;
        v;
    });
}

#pragma mark - private property methods

- (void)setSex:(NSString *)sex {
    _sex = [sex copy];
    NSString *title = [NSString stringWithFormat:@"%@　　▼", sex];
    [self.sexButton setTitle:title forState:UIControlStateNormal];
}

- (void)setIsChronic:(BOOL)isChronic {
    _isChronic = isChronic;
    NSString *title = [NSString stringWithFormat:@"%@　　　　　　▼", isChronic ? @"是" : @"否"];
    [self.isChronicButton setTitle:title forState:UIControlStateNormal];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        
        _nameView          = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"姓名"];
        _sexView           = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"性别"];
        _sexView.textField.hidden = YES;
        _ageView           = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"年龄" keyboardType:UIKeyboardTypeNumberPad];
        _telView           = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"联系电话" keyboardType:UIKeyboardTypeNumberPad];
        _heightView        = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"身高(cm)" keyboardType:UIKeyboardTypeNumberPad];
        _weightView        = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"体重(kg)" keyboardType:UIKeyboardTypeNumberPad];
        _waistView         = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"腰围(选填)" keyboardType:UIKeyboardTypeNumberPad];
        _addressView       = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"家庭住址"];
        _secondNameView    = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"第二联系人姓名"];
        _secondTelView     = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"第二联系人电话"];
        _isChronicView     = [self _createInputViewWithStyle:InputViewStyleOneLine title:@"是否确诊慢性病"];
        _isChronicView.textField.hidden = YES;
        _chronicNameView   = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"慢性病名称(点击多选)"];
        _chronicNameView.textView.hidden = YES;
        _sickDescView      = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"患病程度概述"];
        _demandView        = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"调理诉求"];
        _forbiddenFoodView = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"忌口食物"];
        _breakfastView     = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"早餐"];
        _lunchView         = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"午餐"];
        _dinnerView        = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"晚餐"];
        _otherDescView     = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"其他"];
        _remarkView        = [self _createInputViewWithStyle:InputViewStyleMultiLine title:@"备注"];
        
        _diabetesButton = [self _createChronicButtonWithTitle:@"糖尿病"];
        _hypertensionButton = [self _createChronicButtonWithTitle:@"高血压"];
        _highCholesterolButton = [self _createChronicButtonWithTitle:@"高血脂"];
        _chronicKidneyDiseaseButton = [self _createChronicButtonWithTitle:@"慢性肾病"];
        
        _lineView1 = [self _createLineView];
        _lineView2 = [self _createLineView];
        _lineView3 = [self _createLineView];
    }
    return _contentView;
}

- (UIButton *)sexButton {
    if (!_sexButton) {
        _sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sexButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _sexButton.titleLabel.font = self.sexView.textField.font;
        [_sexButton setTitleColor:self.sexView.textField.textColor forState:UIControlStateNormal];
        _weak(self);
        [_sexButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            if (!self.sexActionSheet) {
                self.sexActionSheet = [[UIActionSheet alloc] initWithTitle:self.sexView.titleLabel.text delegate:self cancelButtonTitle:@"男" destructiveButtonTitle:@"女" otherButtonTitles:nil];
            }
            [self.sexActionSheet showInView:self.view];
        }];
    }
    return _sexButton;
}

- (UIButton *)isChronicButton {
    if (!_isChronicButton) {
        _isChronicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _isChronicButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _isChronicButton.titleLabel.font = self.isChronicView.textField.font;
        [_isChronicButton setTitleColor:self.isChronicView.textField.textColor forState:UIControlStateNormal];
        _weak(self);
        [_isChronicButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            if (!self.isChronicActionSheet) {
                self.isChronicActionSheet = [[UIActionSheet alloc] initWithTitle:self.isChronicView.titleLabel.text delegate:self cancelButtonTitle:@"否" destructiveButtonTitle:@"是" otherButtonTitles:nil];
            }
            [self.isChronicActionSheet showInView:self.view];
        }];
    }
    return _isChronicButton;
}

- (UILabel *)line3TitleLabel {
    if (!_line3TitleLabel) {
        _line3TitleLabel = [[UILabel alloc] init];
        _line3TitleLabel.font = [UIFont boldSystemFontOfSize:15];
        _line3TitleLabel.textColor = k_COLOR_STAR_DUST;
        _line3TitleLabel.text = @"往餐内容";
    }
    return _line3TitleLabel;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = k_COLOR_MEDIUM_AQUAMARINE;
    }
    return _footerView;
}

- (UILabel *)footerLabel {
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc] init];
        _footerLabel.font = [UIFont boldSystemFontOfSize:14];
        _footerLabel.textColor = k_COLOR_WHITE;
        _footerLabel.numberOfLines = 0;
        _footerLabel.text = @"尊敬的用户您好，\n为了更贴切您的需求和服务，“味了”营养师管家会在24小时之内对您的需求进行回复，“味了”让您的生活更健康，感谢您的信任。";
    }
    return _footerLabel;
}

@end
