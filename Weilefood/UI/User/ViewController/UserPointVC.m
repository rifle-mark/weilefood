//
//  UserPointVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UserPointVC.h"
#import "PointRulerCell.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface UserPointVC ()

@property(nonatomic,strong)UIView           *topView;
@property(nonatomic,strong)UILabel          *myPointL;
@property(nonatomic,strong)UITableView      *tableView;

@property(nonatomic,strong)NSArray          *rulerList;

@end

@implementation UserPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"积分规则";
    
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.myPointL];
    [self.view addSubview:self.tableView];
    
    [self _setupObserver];
    [self _loadPointRulers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.superview).with.offset(self.topLayoutGuide.length);
        make.left.right.equalTo(self.topView.superview);
        make.height.equalTo(@50);
    }];
    [self.myPointL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.myPointL.superview);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.bottom.equalTo(self.tableView.superview);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private 
- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"myPoint" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        self.myPointL.text = [NSString stringWithFormat:@"我的积分: %ld", (long)self.myPoint];
    }];
    [self startObserveObject:self forKeyPath:@"rulerList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        if (self.rulerList && [self.rulerList count] > 0) {
            [self.tableView reloadData];
        }
    }];
}

- (void)_loadPointRulers {
    _weak(self);
    [[WLServerHelper sharedInstance] points_getRulerListCallback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        ServerHelperErrorHandle;
        
        self.rulerList = apiResult;
    }];
}

#pragma mark - propertys
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = k_COLOR_WHITESMOKE;
    }
    return _topView;
}

- (UILabel *)myPointL {
    if (!_myPointL) {
        _myPointL = [[UILabel alloc] init];
        _myPointL.font = [UIFont boldSystemFontOfSize:17];
        _myPointL.textColor = k_COLOR_MEDIUMTURQUOISE;
        _myPointL.text = [NSString stringWithFormat:@"我的积分: %ld", (long)self.myPoint];
    }
    return _myPointL;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = k_COLOR_WHITE;
        [_tableView registerClass:[PointRulerCell class] forCellReuseIdentifier:[PointRulerCell reuseIdentify]];
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            _strong_check(self, 0);
            return self.rulerList.count;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            return 50;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            PointRulerCell *cell = [view dequeueReusableCellWithIdentifier:[PointRulerCell reuseIdentify]];
            if (!cell) {
                cell = [[PointRulerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PointRulerCell reuseIdentify]];
            }
            cell.ruler = self.rulerList[path.row];
            return cell;
        }];
    }
    return _tableView;
}

@end
