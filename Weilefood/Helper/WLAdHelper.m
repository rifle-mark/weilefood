//
//  WLAdHelper.m
//  Weilefood
//
//  Created by kelei on 15/9/11.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLAdHelper.h"
#import "WLModelHeader.h"

#import "LoginVC.h"
#import "ProductInfoVC.h"
#import "ForwardBuyInfoVC.h"
#import "ActivityInfoVC.h"
#import "VideoInfoVC.h"
#import "NutritionInfoVC.h"
#import "DoctorInfoVC.h"
#import "WebVC.h"

@implementation WLAdHelper

+ (void)openWithAd:(WLAdModel *)ad {
    UIViewController *currentVC = [[UIApplication sharedApplication] currentViewController];
    switch (ad.type) {
        case WLAdTypeShare: {
            break;
        }
        case WLAdTypeProduct: {
            WLProductModel *product = [[WLProductModel alloc] init];
            product.productId = ad.refId;
            [currentVC.navigationController pushViewController:[[ProductInfoVC alloc] initWithProduct:product] animated:YES];
            break;
        }
        case WLAdTypeActivity: {
            WLActivityModel *activity = [[WLActivityModel alloc] init];
            activity.activityId = ad.refId;
            [currentVC.navigationController pushViewController:[[ActivityInfoVC alloc] initWithActivity:activity] animated:YES];
            break;
        }
        case WLAdTypeForwardBuy: {
            WLForwardBuyModel *forwardBuy = [[WLForwardBuyModel alloc] init];
            forwardBuy.forwardBuyId = ad.refId;
            [currentVC.navigationController pushViewController:[[ForwardBuyInfoVC alloc] initWithForwardBuy:forwardBuy] animated:YES];
            break;
        }
        case WLAdTypeNutrition: {
            WLNutritionModel *nutrition = [[WLNutritionModel alloc] init];
            nutrition.classId = ad.refId;
            [currentVC.navigationController pushViewController:[[NutritionInfoVC alloc] initWithNutrition:nutrition] animated:YES];
            break;
        }
        case WLAdTypeVideo: {
            [LoginVC needsLoginWithLoggedBlock:^(WLUserModel *user) {
                WLVideoModel *video = [[WLVideoModel alloc] init];
                video.videoId = ad.refId;
                [currentVC.navigationController pushViewController:[[VideoInfoVC alloc] initWithVideo:video] animated:YES];
            }];
            break;
        }
        case WLAdTypeUrl: {
            WebVC *vc = [[WebVC alloc] initWithTitle:ad.name URL:ad.url];
            [currentVC.navigationController pushViewController:vc animated:YES];
            break;
        }
        case WLAdTypeNoUrl: {
            break;
        }
        case WLAdTypeDoctor: {
            WLDoctorModel *doctor = [[WLDoctorModel alloc] init];
            doctor.doctorId = ad.refId;
            [currentVC.navigationController pushViewController:[[DoctorInfoVC alloc] initWithDoctor:doctor] animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
