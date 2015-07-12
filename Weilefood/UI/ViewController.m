//
//  ViewController.m
//  Weilefood
//
//  Created by kelei on 15/7/10.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "ViewController.h"
#import "AGImagePickerController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *selectPhotoButton;

@end

@implementation ViewController

#pragma mark - selectPhotoButton

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.selectPhotoButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.selectPhotoButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.selectPhotoButton.superview);
        make.centerY.equalTo(@0);
    }];
}

#pragma mark - property getter setter

- (UIButton *)selectPhotoButton {
    if (!_selectPhotoButton) {
        _selectPhotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_selectPhotoButton setTitle:@"选择照片" forState:UIControlStateNormal];
        _weak(self);
        [_selectPhotoButton addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong(self);
            AGImagePickerController *ipc = [[AGImagePickerController alloc] init];
            ipc.toolbarItemsForManagingTheSelection = @[];
            ipc.shouldShowSavedPhotosOnTop = NO;
            ipc.shouldChangeStatusBarStyle = YES;
            ipc.maximumNumberOfPhotosToBeSelected = 5;
            ipc.didFailBlock = ^(NSError *error) {
                _strong(self);
                if (error == nil) {
                    NSLog(@"User has cancelled.");
                }
                else {
                    NSLog(@"Error: %@", error);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            };
            ipc.didFinishBlock = ^(NSArray *info) {
                _strong(self);
                for (ALAsset *item in info) {
                    UIImage *image = [UIImage imageWithCGImage:item.defaultRepresentation.fullScreenImage];
                    NSLog(@"image size: %@", [NSValue valueWithCGSize:image.size]);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            };
            [self presentViewController:ipc animated:YES completion:nil];
            [ipc showFirstAssetsController];
        }];
    }
    return _selectPhotoButton;
}

@end
