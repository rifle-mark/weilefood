//
//  UserCenterListCell.m
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UserCenterListCell.h"

@interface UserCenterListCell ()

@property(nonatomic,strong)UIView           *mainV;
@property(nonatomic,strong)UIImageView      *iconV;
@property(nonatomic,strong)UIImageView      *redDotV;
@property(nonatomic,strong)UILabel          *titleL;
@property(nonatomic,strong)UIImageView      *arrawV;
@property(nonatomic,strong)UIView           *lineV;

@end

@implementation UserCenterListCell

+ (NSString*)reuseIdentify {
    return @"UserCenterListCellIdentify";
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_CLEAR;
        
        [self.contentView addSubview:self.mainV];
        [self.mainV addSubview:self.iconV];
        [self.mainV addSubview:self.redDotV];
        [self.mainV addSubview:self.titleL];
        [self.mainV addSubview:self.arrawV];
        [self.mainV addSubview:self.lineV];
        
        self.displayRedDot = NO;
        
        [self _layoutSubViews];
        [self _setupObserver];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [UIView animateWithDuration:0.3 animations:^{
        if (selected) {
            self.mainV.backgroundColor = k_COLOR_WHITESMOKE;
        }
        else {
            self.mainV.backgroundColor = k_COLOR_WHITE;
        }
    }];
}

#pragma mark - public methods

- (void)setDisplayRedDot:(BOOL)displayRedDot {
    _displayRedDot = displayRedDot;
    self.redDotV.hidden = !displayRedDot;
}

#pragma mark - private method

- (void)_layoutSubViews {
    [self.mainV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@60);
    }];
    
    [self.iconV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconV.superview).with.offset(12);
        make.centerY.equalTo(self.iconV.superview);
        make.size.mas_equalTo(ccs(27, 27));
    }];
    
    [self.redDotV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconV.mas_right);
        make.centerY.equalTo(self.iconV.mas_top);
    }];
    
    [self.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleL.superview);
        make.left.equalTo(self.iconV.mas_right).with.offset(13);
        make.right.equalTo(self.arrawV.mas_left);
    }];
    
    [self.arrawV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.arrawV.superview);
        make.right.equalTo(self.arrawV.superview.mas_right).offset(-20);
        make.size.mas_equalTo(self.arrawV.image.size);
    }];
    
    [self.lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineV.superview).with.offset(12);
        make.right.equalTo(self.lineV.superview).with.offset(-12);
        make.height.equalTo(@k1pxWidth);
    }];
}
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"itemType" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        switch (self.itemType) {
            case MyOrder: {
                self.iconV.image = [UIImage imageNamed:@"myorder_icon"];
                self.titleL.text = @"我的订单";
            }
                break;
            case MyFavorite: {
                self.iconV.image = [UIImage imageNamed:@"myfavorite_icon"];
                self.titleL.text = @"我的收藏";
            }
                break;
            case MyComment: {
                self.iconV.image = [UIImage imageNamed:@"mycomment_icon"];
                self.titleL.text = @"我的评论";
            }
                break;
            case ReplyMe: {
                self.iconV.image = [UIImage imageNamed:@"replyme_icon"];
                self.titleL.text = @"回复我的";
            }
                break;
            case FeedBack: {
                self.iconV.image = [UIImage imageNamed:@"feedback_icon"];
                self.titleL.text = @"意见反馈";
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - propertys
- (UIView *)mainV {
    if (!_mainV) {
        _mainV = [[UIView alloc] init];
        _mainV.backgroundColor = k_COLOR_WHITE;
    }
    return _mainV;
}

- (UIImageView *)iconV {
    if (!_iconV) {
        _iconV = [[UIImageView alloc] init];
    }
    return _iconV;
}

- (UIImageView *)redDotV {
    if (!_redDotV) {
        _redDotV = [[UIImageView alloc] init];
        _redDotV.image = [UIImage imageNamed:@"icon_newmessage"];
    }
    return _redDotV;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = k_COLOR_SLATEGRAY;
        _titleL.font = [UIFont boldSystemFontOfSize:16];
    }
    
    return _titleL;
}

- (UIImageView *)arrawV {
    if (!_arrawV) {
        _arrawV = [[UIImageView alloc] init];
        _arrawV.image = [UIImage imageNamed:@"discovery_all_icon_n"];
    }
    
    return _arrawV;
}

- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = k_COLOR_WHITESMOKE;
    }
    
    return _lineV;
}

@end
