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

@property(nonatomic,strong)UIView       *userView;
@property(nonatomic,strong)UIImageView  *avatarV;
@property(nonatomic,strong)UILabel      *nameL;
@property(nonatomic,strong)UILabel      *time2L;
@property(nonatomic,strong)UIView       *contentV;
@property(nonatomic,strong)UILabel      *contentL;
@property(nonatomic,strong)UICollectionView *picsV;
@property(nonatomic,strong)UIView       *controlV;
@property(nonatomic,strong)UIButton     *upBtn;
@property(nonatomic,strong)UIButton     *commentBtn;

@property(nonatomic,strong)NSArray      *picUrlVArray;

@end

@implementation WLShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
    UIView *splitV = [[UIView alloc] init];
    splitV.backgroundColor = k_COLOR_LAVENDER;
    [self.contentView addSubview:splitV];
    [splitV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(splitHeight));
    }];
    
    self.userView = [[UIView alloc] init];
    self.userView.backgroundColor = k_COLOR_CLEAR;
    [self.contentView addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.contentView).with.offset(splitHeight);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(userVHeight));
    }];
    
    self.avatarV = [[UIImageView alloc] init];
    self.avatarV.clipsToBounds = YES;
    self.avatarV.layer.cornerRadius = 22;
    [self.userView addSubview:self.avatarV];
    [self.avatarV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.centerY.equalTo(self.userView);
        make.left.equalTo(self.userView).with.offset(10);
        make.width.height.equalTo(@42);
    }];
    
    self.nameL = [[UILabel alloc] init];
    self.nameL.backgroundColor = k_COLOR_CLEAR;
    self.nameL.font = [UIFont boldSystemFontOfSize:15];
    self.nameL.textColor = k_COLOR_GOLDENROD;
    [self.userView addSubview:self.nameL];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.userView).with.offset(24);
        make.left.equalTo(self.userView).with.offset(65);
        make.right.equalTo(self.userView).with.offset(-10);
        make.height.equalTo(@16);
    }];
    
    self.time2L = [[UILabel alloc] init];
    self.time2L.backgroundColor = k_COLOR_CLEAR;
    self.time2L.font = [UIFont boldSystemFontOfSize:11];
    self.time2L.textColor = k_COLOR_DARKGRAY;
    [self.userView addSubview:self.time2L];
    [self.time2L mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.nameL.mas_bottom).with.offset(2);
        make.left.right.equalTo(self.nameL);
        make.height.equalTo(@12);
    }];
    
    self.controlV = [[UIView alloc] init];
    self.controlV.backgroundColor = k_COLOR_CLEAR;
    [self.contentView addSubview:self.controlV];
    [self.controlV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@31);
    }];
    
    UIView *controlSplitV = [[UIView alloc] init];
    controlSplitV.backgroundColor = k_COLOR_LAVENDER;
    [self.controlV addSubview:controlSplitV];
    [controlSplitV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.left.right.equalTo(self.controlV);
        make.height.equalTo(@1);
    }];
    
    UIView *btnSplitV = [[UIView alloc] init];
    btnSplitV.backgroundColor = k_COLOR_LAVENDER;
    [self.controlV addSubview:btnSplitV];
    [btnSplitV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.centerX.equalTo(self.controlV);
        make.top.bottom.equalTo(self.controlV);
        make.width.equalTo(@1);
    }];
    
    _weak(btnSplitV);
    self.upBtn = [[UIButton alloc] init];
    [self.upBtn setImage:[UIImage imageNamed:@"wl_share_up_btn"] forState:UIControlStateNormal];
    [self.upBtn setImage:[UIImage imageNamed:@"wl_share_up_btn_h"] forState:UIControlStateDisabled];
    self.upBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    self.upBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    self.upBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.upBtn setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
    [self.upBtn setTitleColor:k_COLOR_LAVENDER forState:UIControlStateHighlighted];
    [self.upBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
        _strong(self);
        GCBlockInvoke(self.likeActionBlock, self.share);
    }];
    [self.controlV addSubview:self.upBtn];
    [self.upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        _strong(btnSplitV);
        make.top.equalTo(self.controlV).with.offset(1);
        make.left.bottom.equalTo(self.controlV);
        make.right.equalTo(btnSplitV.mas_left);
    }];
    
    self.commentBtn = [[UIButton alloc] init];
    [self.commentBtn setImage:[UIImage imageNamed:@"wl_share_sub_btn"] forState:UIControlStateNormal];
    self.commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    self.commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    self.commentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.commentBtn setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:k_COLOR_LAVENDER forState:UIControlStateHighlighted];
    [self.commentBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
        _strong(self);
        GCBlockInvoke(self.commentActionBlock, self.share);
    }];
    [self.controlV addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        _strong(btnSplitV);
        make.top.equalTo(self.controlV).with.offset(1);
        make.right.bottom.equalTo(self.controlV);
        make.left.equalTo(btnSplitV.mas_right);
    }];
    
    
    self.contentV = [[UIView alloc] init];
    self.contentV.backgroundColor = k_COLOR_CLEAR;
    [self.contentView addSubview:self.contentV];
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.userView.mas_bottom);
        make.left.equalTo(self.contentView).with.offset(66);
        make.right.equalTo(self.contentView).with.offset(-34);
        make.bottom.equalTo(self.controlV.mas_top);
    }];
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.numberOfLines = 0;
    [self.contentV addSubview:self.contentL];
    
    UICollectionViewFlowLayout *picLayout = [[UICollectionViewFlowLayout alloc] init];
    picLayout.minimumLineSpacing = 5;
    picLayout.minimumInteritemSpacing = 5;
    picLayout.headerReferenceSize = ccs(0, 0);
    picLayout.footerReferenceSize = ccs(0, 0);
    picLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat picWH = [[self class] _picHeightWithScreenWidth:[[UIScreen mainScreen] bounds].size.width];
    picLayout.itemSize = ccs(picWH, picWH);
    self.picsV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:picLayout];
    [self.picsV registerClass:[WLSharePicCell class] forCellWithReuseIdentifier:[WLSharePicCell reuseIdentify]];
    self.picsV.showsHorizontalScrollIndicator = NO;
    self.picsV.showsVerticalScrollIndicator = NO;
    [self.picsV setScrollEnabled:NO];
    self.picsV.backgroundColor = k_COLOR_WHITE;

    [self.picsV withBlockForSectionNumber:^NSInteger(UICollectionView *view) {
        return 1;
    }];
    [self.picsV withBlockForItemNumber:^NSInteger(UICollectionView *view, NSInteger section) {
        _strong(self);
        return [self.picUrlVArray count];
    }];
    [self.picsV withBlockForItemCell:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *path) {
        _strong(self);
        WLSharePicCell *cell = [view dequeueReusableCellWithReuseIdentifier:[WLSharePicCell reuseIdentify] forIndexPath:path];
        if (!cell) {
            cell = [[WLSharePicCell alloc] init];
        }
        _weak(cell);
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.picUrlVArray[path.row]] placeholderImage:[UIImage imageNamed:@"default_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                _strong(cell);
                cell.imgV.contentMode = UIViewContentModeScaleToFill;
                cell.imgV.image = image;
            }
        }];
        
        return cell;
    }];
    [self.picsV withBlockForItemDidSelect:^(UICollectionView *view, NSIndexPath *path) {
        _strong(self);
        GCBlockInvoke(self.picShowBlock, self.picUrlVArray, path.item);
    }];
    
    [self.contentV addSubview:self.picsV];
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"share" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.avatarV sd_setImageWithURL:[WLAPIAddressGenerator urlOfPictureWith:42 height:42 urlString:self.share.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.nameL.text = self.share.nickName;
        self.time2L.text = [self.share.createDate dateTimeSplitByMinus];
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
@end
