//
//  WeiCommentCell.m
//  Sunflower
//
//  Created by makewei on 15/6/4.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "WLShareCell.h"

static CGFloat splitHeight = 5;
static CGFloat userVHeight = 68;
static CGFloat controlHeight = 47;

@implementation WLSharePicCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imgV = [[UIImageView alloc] init];
        self.imgV.clipsToBounds = YES;
        [self.contentView addSubview:self.imgV];
        _weak(self);
        self.clipsToBounds = YES;
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (void)prepareForReuse {
    self.imgV.contentMode = UIViewContentModeCenter;
    self.imgV.backgroundColor = k_COLOR_DARKGRAY;
    [self.imgV setImage:[UIImage imageNamed:@"default_placeholder"]];
}

+ (NSString *)reuseIdentify {
    return @"WeiCommentPicCellIdentify";
}

@end

@interface WLShareCell()

@property(nonatomic,strong)UIView       *splitV;
@property(nonatomic,strong)UIView       *userView;
@property(nonatomic,strong)UIImageView  *avatarV;
@property(nonatomic,strong)UILabel      *nameL;
@property(nonatomic,strong)UILabel      *time2L;
@property(nonatomic,strong)UIView       *contentV;
@property(nonatomic,strong)UILabel      *contentL;
@property(nonatomic,strong)UICollectionView *picsV;
@property(nonatomic,strong)UIView       *controlV;
@property(nonatomic,strong)UIView       *controlSplitV;
@property(nonatomic,strong)UIButton     *upBtn;
@property(nonatomic,strong)UIButton     *commentBtn;
@property(nonatomic,strong)UIView       *btnSplitV;

@property(nonatomic,strong)NSArray      *picUrlVArray;

@end

@implementation WLShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.splitV];
        [self.contentView addSubview:self.userView];
        [self.userView addSubview:self.avatarV];
        [self.userView addSubview:self.nameL];
        [self.userView addSubview:self.time2L];
        [self.contentView addSubview:self.controlV];
        [self.controlV addSubview:self.controlSplitV];
        [self.controlV addSubview:self.btnSplitV];
        [self.controlV addSubview:self.upBtn];
        [self.controlV addSubview:self.commentBtn];
        [self.contentView addSubview:self.contentV];
        [self.contentV addSubview:self.contentL];
        [self.contentV addSubview:self.picsV];
        
        [self _setupSubViews];
        [self _setupObserver];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)_setupSubViews {
    _weak(self);
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.contentView.superview);
        }];
    }
    [self.splitV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(splitHeight));
    }];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.contentView).with.offset(splitHeight);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(userVHeight));
    }];
    [self.avatarV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.centerY.equalTo(self.userView);
        make.left.equalTo(self.userView).with.offset(10);
        make.width.height.equalTo(@42);
    }];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.userView).with.offset(24);
        make.left.equalTo(self.userView).with.offset(65);
        make.right.equalTo(self.userView).with.offset(-10);
        make.height.equalTo(@16);
    }];
    [self.time2L mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.nameL.mas_bottom).with.offset(2);
        make.left.right.equalTo(self.nameL);
        make.height.equalTo(@12);
    }];
    
    [self.controlV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@31);
    }];
    [self.controlSplitV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.left.right.equalTo(self.controlV);
        make.height.equalTo(@1);
    }];
    [self.btnSplitV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.centerX.equalTo(self.controlV);
        make.top.bottom.equalTo(self.controlV);
        make.width.equalTo(@1);
    }];
    [self.upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.controlV).with.offset(1);
        make.left.bottom.equalTo(self.controlV);
        make.right.equalTo(self.btnSplitV.mas_left);
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.controlV).with.offset(1);
        make.right.bottom.equalTo(self.controlV);
        make.left.equalTo(self.btnSplitV.mas_right);
    }];

    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.userView.mas_bottom);
        make.left.equalTo(self.contentView).with.offset(66);
        make.right.equalTo(self.contentView).with.offset(-34);
        make.bottom.equalTo(self.controlV.mas_top);
    }];
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"share" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.avatarV sd_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:42 height:42 urlString:self.share.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.nameL.text = self.share.nickName;
        self.time2L.text = [self.share.createDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.contentL.attributedText = [[self class] _contentAttributeStringWithComment:self.share];
        [self.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.top.equalTo(self.contentV).with.offset(10);
            make.left.right.equalTo(self.contentV);
            make.height.equalTo(@([[self class] _contentHeightWithComment:self.share screenWidth:V_W_([UIApplication sharedApplication].keyWindow)]));
        }];
        
        self.picUrlVArray = [[self class] _picUrlArrayWithComment:self.share];
        [self.picsV reloadData];
        [self.picsV mas_remakeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.top.equalTo(self.contentL.mas_bottom).with.offset(10);
            make.left.right.equalTo(self.contentV);
            NSInteger picRowNumber = [WLShareCell _picRowNumberWithComment:self.share];
            CGFloat picHeight = [WLShareCell _picHeightWithScreenWidth:V_W_([UIApplication sharedApplication].keyWindow)];
            make.height.equalTo(@((picRowNumber==0?0:picRowNumber*(5+picHeight)+15)));
        }];
        
        if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.equalTo(self.contentView.superview);
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
                make.height.equalTo(@([WLShareCell heightWithComment:self.share screenWidth:[UIScreen mainScreen].bounds.size.width]));
            }];
        }
        
        [self.upBtn setTitle:[NSString stringWithFormat:@"(%lu)", (unsigned long)self.share.actionCount] forState:UIControlStateNormal];
        [self.commentBtn setTitle:[NSString stringWithFormat:@"(%lu)", (unsigned long)self.share.commentCount] forState:UIControlStateNormal];
        [self.upBtn setEnabled:!self.share.isLike];
    }];
    
    [self startObserveObject:self forKeyPath:@"isLike" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.upBtn setEnabled:!self.isLike];
    }];
}

- (void)addUpCount {
    [self.upBtn setTitle:[NSString stringWithFormat:@"(%@)", @(self.share.actionCount +1)] forState:UIControlStateNormal];
}
- (void)addCommentCount {
    
}

+ (NSString *)reuseIdentify {
    return @"WeiCommentCellIdentify";
}

+ (CGFloat)heightWithComment:(WLShareModel *)share screenWidth:(CGFloat)width {

    NSInteger picRowNumber = [WLShareCell _picRowNumberWithComment:share];
    CGFloat picHeight = [WLShareCell _picHeightWithScreenWidth:width];
    return splitHeight+userVHeight+(picRowNumber==0?0:picRowNumber*(5+picHeight)+15)+controlHeight+30+[WLShareCell _contentHeightWithComment:share screenWidth:width];
}

+ (CGFloat)_contentHeightWithComment:(WLShareModel *)share screenWidth:(CGFloat)width {
    NSAttributedString *contentStr = [WLShareCell _contentAttributeStringWithComment:share];
    CGRect contentRect = [contentStr boundingRectWithSize:ccs(width-100, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return contentRect.size.height;
}

+ (NSInteger)_picRowNumberWithComment:(WLShareModel *)share {
    if ([NSString isNilEmptyOrBlankString:share.images]) {
        return 0;
    }
    NSArray *images = [WLShareCell _picUrlArrayWithComment:share];
    if ([images count] <= 0) {
        return 0;
    }
    
    NSInteger columCount = 3;
    NSUInteger imageCount = [images count];
    NSInteger rowCount = 1;
    while (imageCount > columCount) {
        rowCount += 1;
        imageCount -= 3;
    }
    return rowCount;
}

+ (NSArray*)_picUrlArrayWithComment:(WLShareModel *)share {
    return [[share.images stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByString:@","];
}

+ (CGFloat)_picHeightWithScreenWidth:(CGFloat)width {
    CGFloat totalwidth = width - 110;
    return totalwidth / 3;
}

+ (NSAttributedString *)_contentAttributeStringWithComment:(WLShareModel *)share {
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.alignment = NSTextAlignmentLeft;
    ps.lineBreakMode = NSLineBreakByWordWrapping;
    ps.lineHeightMultiple = 1;
    NSDictionary *att = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                          NSForegroundColorAttributeName:k_COLOR_DIMGRAY,
                          NSBackgroundColorAttributeName:k_COLOR_CLEAR,
                          NSParagraphStyleAttributeName:ps};
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:share.content attributes:att];
    return str;
}

#pragma mark - propertys

- (UIView *)splitV {
    if (!_splitV) {
        _splitV = [[UIView alloc] init];
        _splitV.backgroundColor = k_COLOR_LAVENDER;
    }
    return _splitV;
}
- (UIView *)userView {
    if (!_userView) {
        _userView = [[UIView alloc] init];
        _userView.backgroundColor = k_COLOR_CLEAR;
    }
    return _userView;
}
- (UIImageView *)avatarV {
    if (!_avatarV) {
        _avatarV = [[UIImageView alloc] init];
        _avatarV.clipsToBounds = YES;
        _avatarV.layer.cornerRadius = 22;
    }
    return _avatarV;
}
- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.backgroundColor = k_COLOR_CLEAR;
        _nameL.font = [UIFont boldSystemFontOfSize:15];
        _nameL.textColor = k_COLOR_GOLDENROD;
    }
    return _nameL;
}
- (UILabel *)time2L {
    if (!_time2L) {
        _time2L = [[UILabel alloc] init];
        _time2L.backgroundColor = k_COLOR_CLEAR;
        _time2L.font = [UIFont boldSystemFontOfSize:11];
        _time2L.textColor = k_COLOR_DARKGRAY;
    }
    return _time2L;
}
- (UIView *)controlV {
    if (!_controlV) {
        _controlV = [[UIView alloc] init];
        _controlV.backgroundColor = k_COLOR_CLEAR;
    }
    return _controlV;
}
- (UIView *)controlSplitV {
    if (!_controlSplitV) {
        _controlSplitV = [[UIView alloc] init];
        _controlSplitV.backgroundColor = k_COLOR_LAVENDER;
    }
    return _controlSplitV;
}
- (UIView *)btnSplitV {
    if (!_btnSplitV) {
        _btnSplitV = [[UIView alloc] init];
        _btnSplitV.backgroundColor = k_COLOR_LAVENDER;
    }
    return _btnSplitV;
}
- (UIButton *)upBtn {
    if (!_upBtn) {
        _upBtn = [[UIButton alloc] init];
        [_upBtn setImage:[UIImage imageNamed:@"wl_share_up_btn"] forState:UIControlStateNormal];
        [_upBtn setImage:[UIImage imageNamed:@"wl_share_up_btn_h"] forState:UIControlStateDisabled];
        _upBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
        _upBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
        _upBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_upBtn setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_upBtn setTitleColor:k_COLOR_LAVENDER forState:UIControlStateHighlighted];
        _weak(self);
        [_upBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.likeActionBlock, self.share);
        }];
    }
    return _upBtn;
}
- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"wl_share_sub_btn"] forState:UIControlStateNormal];
        _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
        _commentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_commentBtn setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_commentBtn setTitleColor:k_COLOR_LAVENDER forState:UIControlStateHighlighted];
        _weak(self);
        [_commentBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            GCBlockInvoke(self.commentActionBlock, self.share);
        }];
    }
    return _commentBtn;
}
- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.backgroundColor = k_COLOR_CLEAR;
    }
    return _contentV;
}
- (UILabel *)contentL {
    if (!_contentL) {
        _contentL = [[UILabel alloc] init];
        _contentL.numberOfLines = 0;
    }
    return _contentL;
}
- (UICollectionView *)picsV {
    if (!_picsV) {
        UICollectionViewFlowLayout *picLayout = [[UICollectionViewFlowLayout alloc] init];
        picLayout.minimumLineSpacing = 5;
        picLayout.minimumInteritemSpacing = 5;
        picLayout.headerReferenceSize = ccs(0, 0);
        picLayout.footerReferenceSize = ccs(0, 0);
        picLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        CGFloat picWH = [[self class] _picHeightWithScreenWidth:[[UIScreen mainScreen] bounds].size.width];
        picLayout.itemSize = ccs(picWH, picWH);
        _picsV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:picLayout];
        [_picsV registerClass:[WLSharePicCell class] forCellWithReuseIdentifier:[WLSharePicCell reuseIdentify]];
        _picsV.showsHorizontalScrollIndicator = NO;
        _picsV.showsVerticalScrollIndicator = NO;
        [_picsV setScrollEnabled:NO];
        _picsV.backgroundColor = k_COLOR_WHITE;
        _weak(self);
        [_picsV withBlockForSectionNumber:^NSInteger(UICollectionView *view) {
            return 1;
        }];
        [_picsV withBlockForItemNumber:^NSInteger(UICollectionView *view, NSInteger section) {
            _strong_check(self, 0);
            return [self.picUrlVArray count];
        }];
        [_picsV withBlockForItemCell:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            WLSharePicCell *cell = [view dequeueReusableCellWithReuseIdentifier:[WLSharePicCell reuseIdentify] forIndexPath:path];
            if (!cell) {
                cell = [[WLSharePicCell alloc] init];
            }
            _weak(cell);
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.picUrlVArray[path.row]] placeholderImage:[UIImage imageNamed:@"default_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    _strong_check(cell);
                    cell.imgV.contentMode = UIViewContentModeScaleAspectFill;
                    cell.imgV.clipsToBounds = YES;
                    cell.imgV.image = image;
                }
            }];
            
            return cell;
        }];
        [_picsV withBlockForItemDidSelect:^(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self);
            GCBlockInvoke(self.picShowBlock, self.picUrlVArray, path.item);
        }];
    }
    return _picsV;
}
@end
