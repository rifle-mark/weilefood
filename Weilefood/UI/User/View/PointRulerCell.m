//
//  PointRulerCell.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "PointRulerCell.h"
#import "WLModelHeader.h"

@interface PointRulerCell ()

@property(nonatomic,strong)UILabel      *pointTitleL;
@property(nonatomic,strong)UILabel      *pointL;
@property(nonatomic,strong)UIView       *lineV;

@end

@implementation PointRulerCell

+ (NSString *)reuseIdentify {
    return @"PointRulerCellIdentify";
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = k_COLOR_WHITE;
        
        [self.contentView addSubview:self.pointTitleL];
        [self.contentView addSubview:self.pointL];
        [self.contentView addSubview:self.lineV];
        
        [self _layoutSubViews];
        [self _setupObserver];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)_layoutSubViews {
    [self.pointTitleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pointTitleL.superview);
        make.left.equalTo(self.pointTitleL.superview).with.offset(15);
    }];
    
    [self.pointL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pointL.superview);
        make.right.equalTo(self.pointL.superview).with.offset(-15);
    }];
    
    [self.lineV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineV.superview);
        make.left.equalTo(self.lineV.superview).with.offset(15);
        make.right.equalTo(self.lineV.superview).with.offset(-15);
        make.height.equalTo(@0.4);
    }];
}

#pragma mark - private
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"ruler" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        self.pointTitleL.text = self.ruler.title;
        self.pointL.text = [NSString stringWithFormat:@"+%ld积分", self.ruler.points];
    }];
}

#pragma mark - propertys
- (UILabel *)pointTitleL {
    if (!_pointTitleL) {
        _pointTitleL = [[UILabel alloc] init];
        _pointTitleL.font = [UIFont systemFontOfSize:15];
        _pointTitleL.textColor = k_COLOR_SLATEGRAY;
    }
    return _pointTitleL;
}

- (UILabel *)pointL {
    if (!_pointL) {
        _pointL = [[UILabel alloc] init];
        _pointL.font = [UIFont boldSystemFontOfSize:15];
        _pointL.textColor = k_COLOR_GOLDENROD;
        _pointL.textAlignment = NSTextAlignmentRight;
    }
    return _pointL;
}

- (UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = k_COLOR_LAVENDER;
    }
    return _lineV;
}

@end
