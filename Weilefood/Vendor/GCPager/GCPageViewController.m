//
//  GCPageViewController.m
//  GCPagerExtension
//
//  Created by zhoujinqiang on 15/1/28.
//  Copyright (c) 2015年 njgarychow. All rights reserved.
//

#import "GCPageViewController.h"
#import "GCPageViewCell.h"

@interface GCPageViewController ()

@property (nonatomic, strong) GCPageView* pageView;
@property (nonatomic, strong) NSMutableDictionary* controllerCacheDic;
@property (nonatomic, assign) NSUInteger totalPageCount;

@property (nonatomic, copy) NSUInteger (^blockForPageControllerCount)(GCPageViewController* controller);
@property (nonatomic, copy) UIViewController* (^blockForPageController)(GCPageViewController* controller, NSUInteger index);
@property (nonatomic, copy) void (^blockForPageControllerDidEndDisplay)(GCPageViewController* controller, NSUInteger index);

@end

@implementation GCPageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSAssert(NO, @"use |initWithMode:| instead");
    return nil;
}
- (instancetype)initWithMode:(GCPageMode)mode {
    if (self = [super initWithNibName:nil bundle:nil]) {
        __weak typeof(self) weakSelf = self;
        
        self.controllerCacheDic = [NSMutableDictionary dictionary];
        
        self.pageView = ({
            
            void (^UninstallViewController)(NSNumber* index) = ^(NSNumber* index) {
                typeof(weakSelf) self = weakSelf;
                NSMutableArray* vcs = self.controllerCacheDic[index];
                for (UIViewController* vc in vcs) {
                    [vc.view removeFromSuperview];
                    [vc removeFromParentViewController];
                }
                [self.controllerCacheDic removeObjectForKey:index];
            };
            void (^InstallViewController)(UIViewController* controller, NSNumber* index) = ^(UIViewController* controller, NSNumber* index) {
                typeof(weakSelf) self = weakSelf;
                NSMutableArray* vcs = self.controllerCacheDic[index];
                if (!vcs) {
                    vcs = [NSMutableArray array];
                    self.controllerCacheDic[index] = vcs;
                }
                [vcs addObject:controller];
                [self addChildViewController:controller];
            };
            
            GCPageView* view = [[GCPageView alloc] initWithMode:mode];
            [view withBlockForPageViewCellCount:^NSUInteger(GCPageView *pageView) {
                typeof(weakSelf) self = weakSelf;
                self.totalPageCount = self.blockForPageControllerCount(self);
                return self.totalPageCount;
            }];
            [view withBlockForPageViewCell:^GCPageViewCell *(GCPageView *pageView, NSUInteger index) {
                typeof(weakSelf) self = weakSelf;
                
                for (NSNumber* num in [[self.controllerCacheDic allKeys] copy]) {
                    if (([num integerValue] != ((NSInteger)index + 1) % self.totalPageCount) &&
                        ((([num integerValue] + 1) % self.totalPageCount) != (NSInteger)index)) {
                        UninstallViewController(num);
                    }
                }
                UninstallViewController(@(index));
                
                UIViewController* vc = self.blockForPageController(self, index);
                InstallViewController(vc, @(index));
                
                GCPageViewCell* cell = [[GCPageViewCell alloc] initWithFrame:self.pageView.bounds reuseIdentifier:nil];
                vc.view.frame = cell.bounds;
                [cell addSubview:vc.view];
                return cell;
            }];
            [view withBlockForPageViewCellDidEndDisplay:^(GCPageView *pageView, NSUInteger index, GCPageViewCell *cell) {
                typeof(weakSelf) self = weakSelf;
                
                for (NSNumber* num in [[self.controllerCacheDic allKeys] copy]) {
                    if ([num unsignedIntegerValue] != index) {
                        UninstallViewController(num);
                    }
                }
                if (self.blockForPageControllerDidEndDisplay) {
                    self.blockForPageControllerDidEndDisplay(self, index);
                }
            }];
            [view withPagingEnabled:YES];
            [view withBounces:NO];
            view;
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageView.frame = self.view.bounds;
    self.pageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pageView];
}



- (instancetype)withBlockForPageControllerCount:(NSUInteger (^)(GCPageViewController *))block {
    self.blockForPageControllerCount = block;
    return self;
}
- (instancetype)withBlockForPageController:(UIViewController *(^)(GCPageViewController *, NSUInteger))block {
    self.blockForPageController = block;
    return self;
}
- (instancetype)withBlockForPageControllerDidEndDisplay:(void (^)(GCPageViewController *, NSUInteger))block {
    self.blockForPageControllerDidEndDisplay = block;
    return self;
}
- (instancetype)withLeftBorderAction:(void (^)())leftBorderAction {
    [self.pageView withLeftBorderAction:leftBorderAction];
    return self;
}
- (instancetype)withRightBorderAction:(void (^)())rightBorderAction {
    [self.pageView withRightBorderAction:rightBorderAction];
    return self;
}

- (void)reloadData {
    [self.pageView reloadData];
}

- (void)showPageAtIndex:(NSUInteger)index animation:(BOOL)animation {
    [self.pageView showPageAtIndex:index animation:animation];
}

@end
