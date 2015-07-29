//
//  SharedAllListVC.m
//  Weilefood
//
//  Created by kelei on 15/7/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SharedAllListVC.h"

@implementation SharedAllListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"美食圈"
                                                    image:[UIImage imageNamed:@"shared_baritem_icon_n"]
                                            selectedImage:[UIImage imageNamed:@"shared_baritem_icon_h"]];
}

@end
