//
//  ReplyMeVC.m
//  Weilefood
//
//  Created by kelei on 15/9/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ReplyMeVC.h"
#import "MyShareVC.h"
#import "ShareDetailVC.h"
#import "ProductInfoVC.h"
#import "ActivityInfoVC.h"
#import "ForwardBuyInfoVC.h"
#import "NutritionInfoVC.h"
#import "VideoInfoVC.h"
#import "DoctorInfoVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

#import "MyCommentCell.h"

@interface ReplyMeVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *commentList;

@end

static NSInteger    kPageSize = 20;

@implementation ReplyMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回复我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    
    [self _setupObserver];
    [self.tableView.header beginRefreshing];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

#pragma mark - private

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"commentList" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong_check(self);
        [self.tableView reloadData];
    }];
}

- (void)_loadDataWithIsLatest:(BOOL)isLatest {
    _weak(self);
    NSDate *maxDate = isLatest ? nil : ((WLCommentModel *)[self.commentList lastObject]).createDate;
    [[WLServerHelper sharedInstance] comment_getReplyMeListWithMaxDate:maxDate pageSize:kPageSize callback:^(WLApiInfoModel *apiInfo, NSArray *apiResult, NSError *error) {
        _strong_check(self);
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
        ServerHelperErrorHandle;
        self.commentList = isLatest ? apiResult : [self.commentList arrayByAddingObjectsFromArray:apiResult];
        self.tableView.footer.hidden = !apiResult || apiResult.count < kPageSize;
    }];
}

#pragma mark - property
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = k_COLOR_WHITE;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delaysContentTouches = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[MyCommentCell class] forCellReuseIdentifier:[MyCommentCell reuseIdentify]];
        
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
            return [self.commentList count];
        }];
        
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            _strong_check(self,0);
            if ([self.commentList count] <= path.row) {
                return 0;
            }
            WLCommentModel *comment = self.commentList[path.row];
            return [MyCommentCell heightOfCellWithComment:comment mode:MyCommentCellModeReplyMe];
        }];
        
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            if ([self.commentList count] <= path.row) {
                return nil;
            }
            MyCommentCell *cell = [view dequeueReusableCellWithIdentifier:[MyCommentCell reuseIdentify]];
            if (!cell) {
                cell = [[MyCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyCommentCell reuseIdentify]];
            }
            [cell setComment:self.commentList[path.row] mode:MyCommentCellModeReplyMe];
            cell.subjectClickBlock = ^(WLCommentModel* comment){
                switch (comment.type) {
                    case WLCommentTypeShare: {
                        [[WLServerHelper sharedInstance] share_getShareInfoWithShareId:(NSUInteger)comment.refId callback:^(WLApiInfoModel *apiInfo, WLShareModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            ShareDetailVC *vc = [[ShareDetailVC alloc] init];
                            vc.share = apiResult;
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    case WLCommentTypeProduct: {
                        [[WLServerHelper sharedInstance] product_getInfoWithProductId:(NSUInteger)comment.refId callback:^(WLApiInfoModel *apiInfo, WLProductModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            ProductInfoVC *vc = [[ProductInfoVC alloc] initWithProduct:apiResult];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    case WLCommentTypeActivity: {
                        [[WLServerHelper sharedInstance] activity_getInfoWithActivityId:(NSUInteger)comment.refId callback:^(WLApiInfoModel *apiInfo, WLActivityModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            ActivityInfoVC *vc = [[ActivityInfoVC alloc] initWithActivity:apiResult];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    case WLCommentTypeForwardBuy: {
                        [[WLServerHelper sharedInstance] forwardBuy_getInfoWithForwardBuylId:(NSUInteger)comment.refId callback:^(WLApiInfoModel *apiInfo, WLForwardBuyModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            ForwardBuyInfoVC *vc = [[ForwardBuyInfoVC alloc] initWithForwardBuy:apiResult];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    case WLCommentTypeNutrition: {
                        [[WLServerHelper sharedInstance] nutrition_getInfoWithNutritionId:comment.refId callback:^(WLApiInfoModel *apiInfo, WLNutritionModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            NutritionInfoVC *vc = [[NutritionInfoVC alloc] initWithNutrition:apiResult];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    case WLCommentTypeVideo: {
                        [[WLServerHelper sharedInstance] video_getInfoWithVideoId:(NSUInteger)comment.refId callback:^(WLApiInfoModel *apiInfo, WLVideoModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            VideoInfoVC *vc = [[VideoInfoVC alloc] initWithVideo:apiResult];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    case WLCommentTypeDoctor: {
                        [[WLServerHelper sharedInstance] doctor_getInfoWithDoctorId:comment.refId callback:^(WLApiInfoModel *apiInfo, WLDoctorModel *apiResult, NSError *error) {
                            _strong_check(self);
                            ServerHelperErrorHandle;
                            DoctorInfoVC *vc = [[DoctorInfoVC alloc] initWithDoctor:apiResult];
                            [self.navigationController pushViewController:vc animated:YES];
                        }];
                    }
                        break;
                    default:
                        break;
                }
            };
            cell.userClickBlock = ^(WLCommentModel* comment){
                _strong_check(self);
                MyShareVC *vc = [[MyShareVC alloc] init];
                vc.userId = (NSUInteger)comment.toUserId;
                [self.navigationController pushViewController:vc animated:YES];
            };
            
            return cell;
        }];
    }
    
    return _tableView;
}

@end
