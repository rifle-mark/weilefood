//
//  PictureShowVC.m
//  Sunflower
//
//  Created by makewei on 15/6/22.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "PictureShowVC.h"
#import "GCDefaultPageView.h"
#import "GCPageViewCell.h"

@interface PictureViewCell : GCPageViewCell

@property(nonatomic,strong)UIImageView  *picV;
@property(nonatomic,strong)NSString     *picUrl;

+ (NSString *)reuseIdentify;
@end

@implementation PictureViewCell

+ (NSString *)reuseIdentify {
    return @"PictureViewCellIdentify";
}

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = k_COLOR_BLACK;
        self.picV = [[UIImageView alloc] init];
        self.picV.backgroundColor = k_COLOR_BLACK;
        [self addSubview:self.picV];
        _weak(self);
        [self.picV mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.left.top.right.bottom.equalTo(self);
        }];
        self.picV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self _setupObserver];
    }
    return self;
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"picUrl" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.picV sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:[UIImage imageNamed:@"default_top_width"]];
    }];
}
@end

@interface PictureShowVC ()

@property(nonatomic,strong)GCDefaultPageView    *picView;
@property(nonatomic,assign)BOOL                 isDidAppear;

@end

@implementation PictureShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self _setupObserver];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = k_COLOR_BLACK;
    [self _loadCodingViews];
    
    _weak(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UIGestureRecognizer *gesture) {
        _strong_check(self);
        [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    }];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self _layoutCodingViews];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.picView reloadData];
    [self.picView showPageAtIndex:self.currentIndex animation:NO];
    self.isDidAppear = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Coding Views
- (void)_loadCodingViews {
    if (self.picView) {
        return;
    }
    
    self.picView = ({
        GCDefaultPageView *p = [[GCDefaultPageView alloc] initWithMode:GCPageModeDefault];
        [p registClass:[PictureViewCell class] withCellIdentifer:[PictureViewCell reuseIdentify]];
        
        _weak(self);
        [p withBlockForPageViewCellCount:^NSUInteger(GCPageView *pageView) {
            _strong(self);
            return [self.picUrlArray count];
        }];
        [p withBlockForPageViewCell:^GCPageViewCell *(GCPageView *pageView, NSUInteger index) {
            _strong(self);
            PictureViewCell *cell = [pageView dequeueReusableCellWithIdentifer:[PictureViewCell reuseIdentify]];
            if (!cell) {
                cell = [[PictureViewCell alloc] initWithFrame:CGRectMake(0, 0, V_W_(self.view), V_H_(self.view)-self.topLayoutGuide.length-self.bottomLayoutGuide.length) reuseIdentifier:[PictureViewCell reuseIdentify]];
            }
            
            cell.picUrl = self.picUrlArray[index];
            return cell;
        }];
        [p withBlockForPageViewCellDidEndDisplay:^(GCPageView *pageView, NSUInteger index, GCPageViewCell *cell) {
            _strong(self);
            if (self.isDidAppear)
                self.currentIndex = pageView.currentPageIndex;
        }];
        [p withLeftBorderAction:^{
            _strong(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        p;
    });
}

- (void)_layoutCodingViews {
    if ([self.picView superview]) {
        return;
    }
    _weak(self);
    UIView *topTmp = [[UIView alloc] init];
    topTmp.backgroundColor = k_COLOR_CLEAR;
    [self.view addSubview:topTmp];
    [topTmp mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(self.topLayoutGuide.length));
    }];
    UIView *botTmp = [[UIView alloc] init];
    botTmp.backgroundColor = k_COLOR_CLEAR;
    [self.view addSubview:botTmp];
    [botTmp mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(self.bottomLayoutGuide.length));
    }];
    
    _weak(topTmp);
    _weak(botTmp);
    [self.view addSubview:self.picView];
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        _strong(topTmp);
        _strong(botTmp);
        make.left.right.equalTo(self.view);
        make.top.equalTo(topTmp.mas_bottom);
        make.bottom.equalTo(botTmp.mas_top);
    }];
    
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"picUrlArray" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        [self.picView reloadData];
    }];
}
@end
