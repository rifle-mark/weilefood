//
//  MarketIndexPageVC.m
//  Weilefood
//
//  Created by kelei on 15/7/26.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "MarketIndexPageVC.h"
#import "MarketChildChannelView.h"
#import "MarketProductCell.h"

#import "MarketSearchVC.h"
#import "ProductInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface MarketIndexPageVC ()

@property (nonatomic, strong) UIBarButtonItem *searchButtonItem;

@property (nonatomic, strong) UIView                 *channelsView;
@property (nonatomic, strong) UIButton               *channelButton1;
@property (nonatomic, strong) UIButton               *channelButton2;
@property (nonatomic, strong) UIButton               *channelButton3;

@property (nonatomic, strong) MarketChildChannelView *childChannelsView;

@property (nonatomic, strong) UITableView            *tableView;

@property (nonatomic, assign) kChannelID selectChanneID;
@property (nonatomic, assign) BOOL       isShowChildChannelsView;
@property (nonatomic, strong) NSArray    *productList;

@end

static NSString *const kCellIdentifier = @"MYCELL";
static NSInteger const kPageSize = 10;

@implementation MarketIndexPageVC

- (id)init {
    if (self = [super init]) {
        _isShowChildChannelsView = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"集市";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[[self.navigationController createUserBarButtonItem], self.searchButtonItem];
    
    [self.channelsView addSubview:self.channelButton1];
    [self.channelsView addSubview:self.channelButton2];
    [self.channelsView addSubview:self.channelButton3];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.childChannelsView];
    [self.view addSubview:self.channelsView];
    
    [self _addObserve];
    self.selectChanneID = kChannelID_YX;
    [self.tableView.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.channelsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view).insets(UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0));
        make.height.equalTo(@37);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelsView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.childChannelsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@([MarketChildChannelView viewHeight]));
        if (self.isShowChildChannelsView) {
            make.top.equalTo(self.channelsView.mas_bottom);
        }
        else {
            make.bottom.equalTo(self.channelsView);
        }
    }];
    
    [self.channelButton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelsView).offset(1);
        make.left.bottom.equalTo(self.channelsView);
    }];
    [self.channelButton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.channelButton1);
        make.left.equalTo(self.channelButton1.mas_right);
    }];
    [self.channelButton3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.channelButton2);
        make.left.equalTo(self.channelButton2.mas_right);
        make.right.equalTo(self.channelsView);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"productList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? [NSDate dateWithTimeIntervalSince1970:0] : ((WLProductModel *)[self.productList lastObject]).createDate;
    [[WLServerHelper sharedInstance] product_getListWithChannelId:self.selectChanneID maxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.productList = isLatest ? apiResult : [self.productList arrayByAddingObjectsFromArray:apiResult];
        self.tableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

- (void)_setTextColorWithChannelButton:(UIButton *)button isSelected:(BOOL)isSelected {
    [button setTitleColor:isSelected ? k_COLOR_THEME_NAVIGATIONBAR_TEXT : k_COLOR_TEAL forState:UIControlStateNormal];
}

- (UIButton *)_createChannelButton {
    return ({
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.backgroundColor = k_COLOR_THEME_NAVIGATIONBAR;
        v.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        v;
    });
}

#pragma mark - private property methons

- (void)setIsShowChildChannelsView:(BOOL)isShowChildChannelsView animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.isShowChildChannelsView = isShowChildChannelsView;
            self.channelButton1.imageView.transform = isShowChildChannelsView ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }];
    }
    else {
        self.isShowChildChannelsView = isShowChildChannelsView;
        self.channelButton1.imageView.transform = isShowChildChannelsView ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
        [self.view setNeedsLayout];
    }
}

- (void)setSelectChanneID:(kChannelID)selectChanneID {
    _selectChanneID = selectChanneID;
    self.childChannelsView.selectChanneID = selectChanneID;
    [self _setTextColorWithChannelButton:self.channelButton1 isSelected:[self.childChannelsView supportThisChannelID:selectChanneID]];
    [self _setTextColorWithChannelButton:self.channelButton2 isSelected:self.channelButton2.tag == selectChanneID];
    [self _setTextColorWithChannelButton:self.channelButton3 isSelected:self.channelButton3.tag == selectChanneID];
}

- (UIBarButtonItem *)searchButtonItem {
    if (!_searchButtonItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"market_search_icon_n"] forState:UIControlStateNormal];
        _weak(self);
        [btn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self.navigationController pushViewController:[[MarketSearchVC alloc] init] animated:YES];
        }];
        _searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _searchButtonItem;
}

- (UIView *)channelsView {
    if (!_channelsView) {
        _channelsView = [[UIView alloc] init];
        _channelsView.backgroundColor = k_COLOR_MEDIUMTURQUOISE;
    }
    return _channelsView;
}

- (UIButton *)channelButton1 {
    if (!_channelButton1) {
        _channelButton1 = [self _createChannelButton];
        _channelButton1.adjustsImageWhenHighlighted = NO;
        [_channelButton1 setTitle:@"优选" forState:UIControlStateNormal];
        [_channelButton1 setImage:[UIImage imageNamed:@"market_arrow_down"] forState:UIControlStateNormal];
        [_channelButton1 setImageToRight];
        
        _weak(self);
        [_channelButton1 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            [self setIsShowChildChannelsView:!self.isShowChildChannelsView animated:YES];
        }];
    }
    return _channelButton1;
}

- (UIButton *)channelButton2 {
    if (!_channelButton2) {
        _channelButton2 = [self _createChannelButton];
        _channelButton2.tag = kChannelID_YH;
        [_channelButton2 setTitle:@"洋货" forState:UIControlStateNormal];
        _weak(self);
        [_channelButton2 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectChanneID = control.tag;
            [self setIsShowChildChannelsView:NO animated:YES];
            [self.tableView.header beginRefreshing];
        }];
    }
    return _channelButton2;
}

- (UIButton *)channelButton3 {
    if (!_channelButton3) {
        _channelButton3 = [self _createChannelButton];
        _channelButton3.tag = kChannelID_CJ;
        [_channelButton3 setTitle:@"餐具" forState:UIControlStateNormal];
        _weak(self);
        [_channelButton3 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectChanneID = control.tag;
            [self setIsShowChildChannelsView:NO animated:YES];
            [self.tableView.header beginRefreshing];
        }];
    }
    return _channelButton3;
}

- (MarketChildChannelView *)childChannelsView {
    if (!_childChannelsView) {
        _childChannelsView = [[MarketChildChannelView alloc] init];
        _childChannelsView.backgroundColor = k_COLOR_WHITE;
        _weak(self);
        [_childChannelsView selectBlock:^(MarketChildChannelView *view) {
            _strong_check(self);
            self.selectChanneID = view.selectChanneID;
            [self setIsShowChildChannelsView:NO animated:YES];
            [self.tableView.header beginRefreshing];
        }];
        [_childChannelsView collapseBlock:^(MarketChildChannelView *view) {
            _strong_check(self);
            [self setIsShowChildChannelsView:NO animated:YES];
        }];
    }
    return _childChannelsView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = [MarketProductCell cellHeight];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MarketProductCell class] forCellReuseIdentifier:kCellIdentifier];
        _weak(self);
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:YES];
        }];
        _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:NO];
        }];
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.productList ? self.productList.count : 0;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            MarketProductCell *cell  = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            WLProductModel *produect = self.productList[path.row];
            cell.imageUrl     = produect.images;
            cell.name         = produect.productName;
            cell.price        = produect.price;
            cell.actionCount  = produect.actionCount;
            cell.commentCount = produect.commentCount;
            cell.tagType      = produect.channelId;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLProductModel *produect = self.productList[path.row];
            [self.navigationController pushViewController:[[ProductInfoVC alloc] initWithProduct:produect] animated:YES];
        }];
    }
    return _tableView;
}

@end
