//
//  VideoInfoVC.m
//  Weilefood
//
//  Created by kelei on 15/8/12.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "VideoInfoVC.h"

#import "CommentListVC.h"
#import "LoginVC.h"
#import "ShareOnPlatformVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoInfoVC ()

@property (nonatomic, strong) UIView   *statusBarView;
@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *contentView;
@property (nonatomic, strong) UIImageView  *videoImageView;
@property (nonatomic, strong) UIButton     *playButton;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UILabel      *pointsLabel;
@property (nonatomic, strong) UIView       *lineView;
@property (nonatomic, strong) UIWebView    *webView;

@property (nonatomic, strong) WLVideoModel *video;

@end

@implementation VideoInfoVC

- (id)init {
    NSAssert(NO, @"请使用initWithVideo:方法来初始化本界面");
    return nil;
}

- (instancetype)initWithVideo:(WLVideoModel *)video {
    if (self= [super init]) {
        self.video = video;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_COLOR_WHITE;
    
    NSArray *barItems = @[self.shareButton,
                          self.commentButton,
                          self.actionButton,
                          self.favoriteButton];
    NSMutableArray *rightItems = [NSMutableArray array];
    [rightItems addObject:[UIBarButtonItem createNavigationFixedItem]];
    for (UIView *view in barItems) {
        [rightItems addObject:[[UIBarButtonItem alloc] initWithCustomView:view]];
    }
    self.navigationItem.rightBarButtonItems = rightItems;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.videoImageView];
    [self.contentView addSubview:self.playButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.pointsLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.webView];
    
    [self _showData];
    [self _loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(self.scrollView);
    }];
    [self.videoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        if (self.videoImageView.hidden) {
            make.height.equalTo(@0);
        }
        else {
            make.height.equalTo(self.videoImageView.mas_width).offset(3.0 / 4.0);
        }
    }];
    [self.playButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.videoImageView);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        make.top.equalTo(self.videoImageView.mas_bottom).offset(20);
    }];
    [self.pointsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.pointsLabel.mas_baseline).offset(18);
        make.height.equalTo(@k1pxWidth);
    }];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lineView);
        make.top.equalTo(self.lineView).offset(20);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@(self.webView.scrollView.contentSize.height ?: 10));
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = k_COLOR_ORANGE;
    self.navigationController.navigationBar.backgroundColor = [k_COLOR_WHITESMOKE colorWithAlphaComponent:0.9];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar addSubview:self.statusBarView];
    self.statusBarView.backgroundColor = self.navigationController.navigationBar.backgroundColor;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.statusBarView removeFromSuperview];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = k_COLOR_THEME_NAVIGATIONBAR_TEXT;
    self.navigationController.navigationBar.backgroundColor = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

#pragma mark - private methods

- (void)_showData {
    self.favoriteButton.highlighted = self.video.isFav;
    self.actionButton.enabled = !self.video.isLike;
    [self.actionButton setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)self.video.actionCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)self.video.commentCount] forState:UIControlStateNormal];
    self.videoImageView.hidden = !self.video.videoUrl || self.video.videoUrl.length <= 0;
    self.playButton.hidden = self.videoImageView.hidden;
    if (!self.videoImageView.hidden) {
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:self.video.images]];
    }
    self.titleLabel.text = self.video.title;
    self.pointsLabel.text = [NSString stringWithFormat:@"观看积分 %lu", (unsigned long)self.video.points];
    [self.webView loadHTMLString:self.video.desc baseURL:nil];
}

- (void)_loadData {
    _weak(self);
    [[WLServerHelper sharedInstance] video_getInfoWithVideoId:self.video.videoId callback:^(WLApiInfoModel *apiInfo, WLVideoModel *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        self.video = apiResult;
        [self _showData];
    }];
}

#pragma mark - private property methods

- (UIView *)statusBarView {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    }
    return _statusBarView;
}

- (UIButton *)favoriteButton {
    if (!_favoriteButton) {
        _favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _favoriteButton.frame = CGRectMake(0, 0, 45, 25);
        [_favoriteButton setImage:[UIImage imageNamed:@"videoinfo_icon_favorite_n"] forState:UIControlStateNormal];
        [_favoriteButton setImage:[UIImage imageNamed:@"videoinfo_icon_favorite_h"] forState:UIControlStateHighlighted];
        _weak(self);
        [_favoriteButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                if (self.video.isFav) {
                    [[WLServerHelper sharedInstance] action_deleteFavoriteWithObjectType:WLActionTypeVideo objectId:self.video.videoId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                        _strong_check(self);
                        ServerHelperErrorHandle;
                        self.video.isFav = NO;
                        [self _showData];
                    }];
                }
                else {
                    [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeFavorite objectType:WLActionTypeVideo objectId:self.video.videoId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                        _strong_check(self);
                        ServerHelperErrorHandle;
                        self.video.isFav = YES;
                        [self _showData];
                    }];
                }
            }];
        }];
    }
    return _favoriteButton;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _actionButton.frame = CGRectMake(0, 0, 40, 25);
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_actionButton setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_actionButton setImage:[UIImage imageNamed:@"videoinfo_icon_action_n"] forState:UIControlStateNormal];
        [_actionButton setImage:[UIImage imageNamed:@"videoinfo_icon_action_h"] forState:UIControlStateHighlighted];
        [_actionButton setImage:[UIImage imageNamed:@"videoinfo_icon_action_h"] forState:UIControlStateDisabled];
        _weak(self);
        [_actionButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                [[WLServerHelper sharedInstance] action_addWithActType:WLActionActTypeApproval objectType:WLActionTypeVideo objectId:self.video.videoId callback:^(WLApiInfoModel *apiInfo, NSError *error) {
                    _strong_check(self);
                    ServerHelperErrorHandle;
                    self.video.actionCount++;
                    self.video.isLike = YES;
                    [self _showData];
                }];
            }];
        }];
    }
    return _actionButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _commentButton.frame = CGRectMake(0, 0, 40, 25);
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_commentButton setTitleColor:k_COLOR_DARKGRAY forState:UIControlStateNormal];
        [_commentButton setImage:[UIImage imageNamed:@"videoinfo_icon_comment"] forState:UIControlStateNormal];
        _weak(self);
        [_commentButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [CommentListVC showWithType:WLCommentTypeVideo refId:self.video.videoId];
        }];
    }
    return _commentButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CGRectMake(0, 0, 35, 28);
        [_shareButton setImage:[UIImage imageNamed:@"videoinfo_bg_share"] forState:UIControlStateNormal];
        _weak(self);
        [_shareButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            NSString *url = [[WLServerHelper sharedInstance] getShareUrlWithType:WLServerHelperShareTypeVideo objectId:self.video.videoId];
            [ShareOnPlatformVC shareWithImageUrl:self.video.images title:self.video.title shareUrl:url];
        }];
    }
    return _shareButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = self.view.backgroundColor;
        _scrollView.clipsToBounds = NO;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView  *)videoImageView {
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
    }
    return _videoImageView;
}

- (UIButton  *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
        _weak(self);
        [_playButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            NSURL *url = [NSURL URLWithString:self.video.videoUrl];
            MPMoviePlayerViewController *pvc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
            pvc.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
            [self presentViewController:pvc animated:YES completion:nil];
        }];
    }
    return _playButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:22];
        _titleLabel.textColor = k_COLOR_MAROOM;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)pointsLabel {
    if (!_pointsLabel) {
        _pointsLabel = [[UILabel alloc] init];
        _pointsLabel.font = [UIFont systemFontOfSize:13];
        _pointsLabel.textColor = k_COLOR_GOLDENROD;
        _pointsLabel.numberOfLines = 2;
    }
    return _pointsLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = k_COLOR_DARKGRAY;
    }
    return _lineView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scrollView.scrollEnabled = NO;
        _webView.scalesPageToFit = YES;
        _weak(self);
        [_webView withBlockForDidFinishLoad:^(UIWebView *view) {
            _strong_check(self);
            [self.view setNeedsLayout];
        }];
    }
    return _webView;
}

@end
