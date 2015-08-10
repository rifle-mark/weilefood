//
//  MarketChildChannelView.m
//  Weilefood
//
//  Created by kelei on 15/8/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MarketChildChannelView.h"


@interface MCCVChannelCell : UITableViewCell
@property (nonatomic, strong) UIImage  *iconImage;
@property (nonatomic, strong) UIImage  *checkedIconImage;
@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, assign) BOOL     checked;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *checkedImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@end
@implementation MCCVChannelCell
+ (NSInteger)cellHeight {
    return 44;
}
+ (NSString *)reuseIdentifier {
    return @"MCCVChannelCell";
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.checkedImageView];
        [self _makeConstraints];
    }
    return self;
}
- (void)_makeConstraints {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.superview).offset(15);
        make.top.equalTo(self.iconImageView.superview).offset(5);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(12);
        make.right.equalTo(self.nameLabel.superview).offset(-15);
        make.top.bottom.equalTo(self.iconImageView);
    }];
    [self.checkedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(self.nameLabel);
    }];
}
- (void)setChecked:(BOOL)checked {
    _checked = checked;
    self.iconImageView.image = checked ? self.checkedIconImage : self.iconImage;
    self.nameLabel.textColor = checked ? k_COLOR_SLATEGRAY : k_COLOR_MAROOM;
    self.checkedImageView.hidden = !checked;
}
- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    [self setChecked:self.checked];
}
- (void)setcheckedIconImage:(UIImage *)checkedIconImage {
    _checkedIconImage = checkedIconImage;
    [self setChecked:self.checked];
}
- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}
- (UIImageView *)checkedImageView {
    if (!_checkedImageView) {
        _checkedImageView = [[UIImageView alloc] init];
        _checkedImageView.image = [UIImage imageNamed:@"mc_icon_selected"];
    }
    return _checkedImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
@end

/*******************************************************************************************
 *******************************************************************************************/
#pragma mark - MarketChannelView

@interface MarketChildChannelView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton    *collapseButton;

@property (nonatomic, copy) void (^selectBlock)(MarketChildChannelView *view);
@property (nonatomic, copy) void (^collapseBlock)(MarketChildChannelView *view);

@end

@implementation MarketChildChannelView

+ (NSInteger)viewHeight {
    return [MCCVChannelCell cellHeight] * 6;
}

- (id)init {
    if (self = [super init]) {
        [self addSubview:self.tableView];
        [self addSubview:self.collapseButton];
        [self _makeConstraints];
    }
    return self;
}

#pragma mark - pubild methods

- (void)setSelectChanneID:(kChannelID)selectChanneID {
    _selectChanneID = selectChanneID;
    [self.tableView reloadData];
}

- (void)selectBlock:(void (^)(MarketChildChannelView *))block {
    self.selectBlock = block;
}

- (void)collapseBlock:(void (^)(MarketChildChannelView *))block {
    self.collapseBlock = block;
}

- (BOOL)supportThisChannelID:(kChannelID)channelID {
    return [self _getRowWithChannelID:channelID] >= 0;
}

#pragma mark - private methods

- (void)_makeConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@([MCCVChannelCell cellHeight] * 5));
    }];
    [self.collapseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}

- (kChannelID)_getChannelIDWithRow:(NSInteger)row {
    switch (row) {
        case 1:
            return kChannelID_YX_LYTL;
        case 2:
            return kChannelID_YX_YSBT;
        case 3:
            return kChannelID_YX_TSMS;
        case 4:
            return kChannelID_YX_JXCP;
        default:
            return kChannelID_YX;
    }
}

- (NSInteger)_getRowWithChannelID:(kChannelID)channelID {
    switch (channelID) {
        case kChannelID_YX:
            return 0;
        case kChannelID_YX_LYTL:
            return 1;
        case kChannelID_YX_YSBT:
            return 2;
        case kChannelID_YX_TSMS:
            return 3;
        case kChannelID_YX_JXCP:
            return 4;
        default:
            return -1;
    }
}

#pragma mark - private property methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = k_COLOR_WHITE;
        _tableView.separatorColor = k_COLOR_LAVENDER;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.rowHeight = [MCCVChannelCell cellHeight];
        [_tableView registerClass:[MCCVChannelCell class] forCellReuseIdentifier:[MCCVChannelCell reuseIdentifier]];
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 5;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            MCCVChannelCell *cell = [view dequeueReusableCellWithIdentifier:[MCCVChannelCell reuseIdentifier] forIndexPath:path];
            kChannelID channelID = [self _getChannelIDWithRow:path.row];
            switch (channelID) {
                case kChannelID_YX: {
                    cell.iconImage         = [UIImage imageNamed:@"mc_icon_all_n"];
                    cell.checkedIconImage = [UIImage imageNamed:@"mc_icon_all_h"];
                    cell.name              = @"全部";
                    break;
                }
                case kChannelID_YX_LYTL: {
                    cell.iconImage         = [UIImage imageNamed:@"mc_icon_LYTL_n"];
                    cell.checkedIconImage = [UIImage imageNamed:@"mc_icon_LYTL_h"];
                    cell.name              = @"粮油调料";
                    break;
                }
                case kChannelID_YX_YSBT: {
                    cell.iconImage         = [UIImage imageNamed:@"mc_icon_YSBT_n"];
                    cell.checkedIconImage = [UIImage imageNamed:@"mc_icon_YSBT_h"];
                    cell.name              = @"养生煲汤";
                    break;
                }
                case kChannelID_YX_TSMS: {
                    cell.iconImage         = [UIImage imageNamed:@"mc_icon_TSMS_n"];
                    cell.checkedIconImage = [UIImage imageNamed:@"mc_icon_TSMS_h"];
                    cell.name              = @"特色美食";
                    break;
                }
                case kChannelID_YX_JXCP: {
                    cell.iconImage         = [UIImage imageNamed:@"mc_icon_JXCP_n"];
                    cell.checkedIconImage = [UIImage imageNamed:@"mc_icon_JXCP_h"];
                    cell.name              = @"精选茶品";
                    break;
                }
                default: {
                    break;
                }
            }
            cell.tag     = channelID;
            cell.checked = self.selectChanneID == channelID;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            MCCVChannelCell *cell = (MCCVChannelCell *)[view cellForRowAtIndexPath:path];
            self.selectChanneID = cell.tag;
            GCBlockInvoke(self.selectBlock, self);
        }];
        
    }
    return _tableView;
}

- (UIButton *)collapseButton {
    if (!_collapseButton) {
        _collapseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collapseButton setImage:[UIImage imageNamed:@"mc_btn_collapse"] forState:UIControlStateNormal];
        [_collapseButton sizeToFit];
        _weak(self);
        [_collapseButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.collapseBlock, self);
        }];
    }
    return _collapseButton;
}

@end
