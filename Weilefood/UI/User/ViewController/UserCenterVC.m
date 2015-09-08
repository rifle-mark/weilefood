//
//  UserCenterVC.m
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "UserCenterVC.h"

#import "UserCenterUserInfoCell.h"
#import "UserCenterMiddleCell.h"
#import "UserCenterListCell.h"

#import "WLDatabaseHelperHeader.h"
#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

#import "LoginVC.h"
#import "UserOrderListVC.h"
#import "MyShareVC.h"
#import "MyMessageVC.h"
#import "ShoppingCartVC.h"
#import "MyFavoriteVC.h"
#import "MyCommentVC.h"
#import "FeedBackVC.h"
#import "SettingVC.h"
#import "UserPointVC.h"

@interface UserCenterVC ()

@property(nonatomic,strong)UITableView      *tableView;
@end

static NSInteger const kSectionInfo   = 0;
static NSInteger const kSectionMiddle = 1;
static NSInteger const kSectionList   = 2;

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的帐户";
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(_openSetting:)];
    settingItem.tintColor = k_COLOR_WHITE;
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem createNavigationFixedItem], settingItem];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.superview).with.offset(self.topLayoutGuide.length);
        make.left.right.bottom.equalTo(self.tableView.superview);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _weak(self);
    WLUserModel *user = [WLDatabaseHelper user_find];
    if (user) {
        [[WLServerHelper sharedInstance] user_getUserBaseInfoWithUserId:user.userId callback:^(WLApiInfoModel *apiInfo, WLUserModel *apiResult, NSError *error) {
            _strong_check(self);
            if (!error && apiInfo.isSuc) {
                user.nickName = apiResult.nickName;
                user.avatar = apiResult.avatar;
                user.points = apiResult.points;
                [WLDatabaseHelper user_save:user];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kSectionInfo] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }
}

#pragma mark - private method
- (void)_openSetting:(id)sender {
    _weak(self);
    [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
        _strong_check(self);
        SettingVC *vc = [[SettingVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - Propertys
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = k_COLOR_WHITESMOKE;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UserCenterUserInfoCell class] forCellReuseIdentifier:[UserCenterUserInfoCell reuseIdentify]];
        [_tableView registerClass:[UserCenterMiddleCell class] forCellReuseIdentifier:[UserCenterMiddleCell reuseIdentify]];
        [_tableView registerClass:[UserCenterListCell class] forCellReuseIdentifier:[UserCenterListCell reuseIdentify]];
        
        _weak(self);
        [_tableView withBlockForSectionNumber:^NSInteger(UITableView *view) {
            return kSectionList+1;
        }];
        
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            switch (path.section) {
                case kSectionInfo:
                    return 170;
                    break;
                case kSectionMiddle:
                    return 73;
                    break;
                case kSectionList:
                    if (path.row == 0 || path.row == 2 || path.row == 3) {
                        return 70;
                    }
                    else {
                        return 60;
                    }
                    break;
                default:
                    return 0;
                    break;
            }
        }];
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            switch (section) {
                case kSectionInfo:
                    return 1;
                    break;
                case kSectionMiddle:
                    return 1;
                    break;
                case kSectionList:
                    return 4;
                    break;
                default:
                    return 0;
                    break;
            }
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            switch (path.section) {
                case kSectionInfo: {
                    UserCenterUserInfoCell *cell = [view dequeueReusableCellWithIdentifier:[UserCenterUserInfoCell reuseIdentify]];
                    cell.user = [WLDatabaseHelper user_find];
                    [cell onImageClickBlock:^(){
                        _strong_check(self);
                        if ([WLDatabaseHelper user_find]) {
                            [self _openSetting:nil];
                        }
                        else {
                            [LoginVC needsLoginWithLoggedBlock:nil];
                        }
                    }];
                    [cell onPointClickBlock:^(){
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            _strong_check(self);
                            UserPointVC *vc = [[UserPointVC alloc] init];
                            vc.myPoint = [[WLDatabaseHelper user_find] points];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }];
                    return cell;
                }
                    break;
                case kSectionMiddle: {
                    UserCenterMiddleCell *cell = [view dequeueReusableCellWithIdentifier:[UserCenterMiddleCell reuseIdentify]];
                    [cell onShareClickBlock:^(){
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            _strong_check(self);
                            MyShareVC *vc = [[MyShareVC alloc] init];
                            vc.userId = user.userId;
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }];
                    [cell onMsgClickBlock:^(){
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            _strong_check(self);
                            MyMessageVC *vc = [[MyMessageVC alloc] init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }];
                    [cell onShopCarClickBlock:^(){
                        [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                            _strong_check(self);
                            ShoppingCartVC *vc = [[ShoppingCartVC alloc] init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }];
                    return cell;
                }
                    break;
                default: {
                    UserCenterListCell *cell = [view dequeueReusableCellWithIdentifier:[UserCenterListCell reuseIdentify]];
                    cell.itemType = (UserCenterListItemType)path.row;
                    return cell;
                }
                    break;
            }
        }];
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            if (path.section != kSectionList) {
                return;
            }
            UserCenterListCell *cell = (UserCenterListCell*)[view cellForRowAtIndexPath:path];
            if (!cell) {
                return;
            }
            [view deselectRowAtIndexPath:path animated:YES];
            
            if (cell.itemType == FeedBack) {
                FeedBackVC *vc = [[FeedBackVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                _strong_check(self);
                switch (cell.itemType) {
                    case MyOrder: {
                        UserOrderListVC *vc = [[UserOrderListVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case MyFavorite: {
                        MyFavoriteVC *vc = [[MyFavoriteVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case MyComment: {
                        MyCommentVC *vc = [[MyCommentVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    default:
                        break;
                }
            }];
        }];
    }
    return _tableView;
}

@end
