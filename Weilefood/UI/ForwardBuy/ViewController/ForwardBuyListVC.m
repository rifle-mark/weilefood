//
//  ForwardBuyListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/30.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ForwardBuyListVC.h"
#import "ForwardBuyCell.h"

#import "ForwardBuyInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface ForwardBuyListVC ()

@property (nonatomic, strong) UIView   *channelsView;
@property (nonatomic, strong) UIButton *channelButton1;
@property (nonatomic, strong) UIButton *channelButton2;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) kChannelID selectChanneID;
@property (nonatomic, strong) NSArray    *forwardBuyList;

@end

static NSString *const kCellIdentifier = @"MYCELL";
static NSInteger const kPageSize       = 10;

@implementation ForwardBuyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预购";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], [UIBarButtonItem createUserBarButtonItemWithVC:self]];
    
    [self.channelsView addSubview:self.channelButton1];
    [self.channelsView addSubview:self.channelButton2];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.channelsView];
    
    [self _addObserve];
    
    self.selectChanneID = kChannelID_SFC;
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
    
    [self.channelButton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelsView).offset(1);
        make.left.bottom.equalTo(self.channelsView);
        make.width.equalTo(self.channelButton2);
    }];
    [self.channelButton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.channelButton1);
        make.left.equalTo(self.channelButton1.mas_right);
        make.right.equalTo(self.channelsView);
    }];
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private methons

- (void)_addObserve {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"forwardBuyList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? nil : ((WLForwardBuyModel *)[self.forwardBuyList lastObject]).createDate;
    [[WLServerHelper sharedInstance] forwardBuy_getListWithChannelId:self.selectChanneID maxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.forwardBuyList = isLatest ? apiResult : [self.forwardBuyList arrayByAddingObjectsFromArray:apiResult];
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

- (void)setSelectChanneID:(kChannelID)selectChanneID {
    _selectChanneID = selectChanneID;
    [self _setTextColorWithChannelButton:self.channelButton1 isSelected:self.channelButton1.tag == selectChanneID];
    [self _setTextColorWithChannelButton:self.channelButton2 isSelected:self.channelButton2.tag == selectChanneID];
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
        _channelButton1.tag = kChannelID_SFC;
        [_channelButton1 setTitle:@"私房菜" forState:UIControlStateNormal];
        _weak(self);
        [_channelButton1 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectChanneID = control.tag;
            [self.tableView.header beginRefreshing];
        }];
    }
    return _channelButton1;
}

- (UIButton *)channelButton2 {
    if (!_channelButton2) {
        _channelButton2 = [self _createChannelButton];
        _channelButton2.tag = kChannelID_JJXSP;
        [_channelButton2 setTitle:@"季节性商品" forState:UIControlStateNormal];
        _weak(self);
        [_channelButton2 addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong_check(self);
            self.selectChanneID = control.tag;
            [self.tableView.header beginRefreshing];
        }];
    }
    return _channelButton2;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = [ForwardBuyCell cellHeight];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ForwardBuyCell class] forCellReuseIdentifier:kCellIdentifier];
        _weak(self);
        [_tableView headerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:YES];
        }];
        [_tableView footerWithRefreshingBlock:^{
            _strong_check(self);
            [self _loadDataWithIsLatest:NO];
        }];
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.forwardBuyList ? self.forwardBuyList.count : 0;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            ForwardBuyCell *cell          = [view dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:path];
            WLForwardBuyModel *forwardBuy = self.forwardBuyList[path.row];
            cell.imageUrl     = forwardBuy.banner;
            cell.beginDate    = forwardBuy.startDate;
            cell.endDate      = forwardBuy.endDate;
            cell.state        = forwardBuy.state;
            cell.name         = forwardBuy.title;
            cell.price        = forwardBuy.price;
            cell.actionCount  = forwardBuy.actionCount;
            cell.commentCount = forwardBuy.commentCount;
            return cell;
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            WLForwardBuyModel *forwardBuy = self.forwardBuyList[path.row];
            [self.navigationController pushViewController:[[ForwardBuyInfoVC alloc] initWithForwardBuy:forwardBuy] animated:YES];
        }];
    }
    return _tableView;
}

@end
