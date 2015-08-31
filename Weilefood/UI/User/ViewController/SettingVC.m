//
//  SettingVC.m
//  Weilefood
//
//  Created by makewei on 15/8/29.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "SettingVC.h"

#import "SettingAvatarCell.h"
#import "SettingNicknameCell.h"
#import "SettingClearCacheCell.h"
#import "SettingLogOutCell.h"

#import "AGImagePickerController.h"
#import "UIImage+AdjustmentSize.h"
#import "NickNameVC.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"
#import "WLDatabaseHelperHeader.h"

@interface SettingVC () <UIActionSheetDelegate>

@property(nonatomic,strong)UITableView      *tableView;

@end

static NSString* pickerAlbum = @"相册";
static NSString* pickerCamera = @"拍照";

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    
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

#pragma mark - propertys
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[SettingAvatarCell class] forCellReuseIdentifier:[SettingAvatarCell reuseIdentify]];
        [_tableView registerClass:[SettingNicknameCell class] forCellReuseIdentifier:[SettingNicknameCell reuseIdentify]];
        [_tableView registerClass:[SettingClearCacheCell class] forCellReuseIdentifier:[SettingClearCacheCell reuseIdentify]];
        [_tableView registerClass:[SettingLogOutCell class] forCellReuseIdentifier:[SettingLogOutCell reuseIdentify]];
        
        _weak(self);
        [_tableView withBlockForRowNumber:^NSInteger(UITableView *view, NSInteger section) {
            return 4;
        }];
        [_tableView withBlockForRowHeight:^CGFloat(UITableView *view, NSIndexPath *path) {
            if (path.row == 0) {
                return 100;
            }
            if (path.row == 3) {
                return 100;
            }
            return 50;
        }];
        [_tableView withBlockForRowCell:^UITableViewCell *(UITableView *view, NSIndexPath *path) {
            if (path.row == 0) {
                SettingAvatarCell *cell = [view dequeueReusableCellWithIdentifier:[SettingAvatarCell reuseIdentify]];
                if (!cell) {
                    cell = [[SettingAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingAvatarCell reuseIdentify]];
                }
                return cell;
            }
            if (path.row == 1) {
                SettingNicknameCell *cell = [view dequeueReusableCellWithIdentifier:[SettingNicknameCell reuseIdentify]];
                if (!cell) {
                    cell = [[SettingNicknameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingNicknameCell reuseIdentify]];
                }
                return cell;
            }
            if (path.row == 2) {
                SettingClearCacheCell *cell = [view dequeueReusableCellWithIdentifier:[SettingClearCacheCell reuseIdentify]];
                if (!cell) {
                    cell = [[SettingClearCacheCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingClearCacheCell reuseIdentify]];
                }
                return cell;
            }
            if (path.row == 3) {
                SettingLogOutCell *cell = [view dequeueReusableCellWithIdentifier:[SettingLogOutCell reuseIdentify]];
                if (!cell) {
                    cell = [[SettingLogOutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SettingLogOutCell reuseIdentify]];
                    }
                cell.logOutBlock = ^(){
                    _strong_check(self);
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogout object:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                };
                return cell;
            }
            return nil;
        }];
        
        [_tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            _strong_check(self);
            [view deselectRowAtIndexPath:path animated:YES];
            if (path.row == 0) {
                UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
                
                BOOL canShow = NO;
                NSArray* cameraTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
                if ([cameraTypes containsObject:(__bridge NSString *)kUTTypeImage]) {
                    [action addButtonWithTitle:pickerCamera];
                    canShow = YES;
                }
                
                NSArray* AlbumTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                if ([AlbumTypes containsObject:(__bridge NSString *)kUTTypeImage]) {
                    [action addButtonWithTitle:pickerAlbum];
                    canShow = YES;
                }
                
                if (canShow) {
                    [action showInView:self.view];
                }
                else {
                    GCAlertView *alert = [[GCAlertView alloc] initWithTitle:nil andMessage:@"无可用图片"];
                    [alert show];
                }
                
                return;
            }
            if (path.row == 1) {
                NickNameVC *vc = [[NickNameVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (path.row == 2) {
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [(SettingClearCacheCell*)[view cellForRowAtIndexPath:path] calculateAndRefreshCacheSize];
                }];
            }
        }];
    }
    return _tableView;
}

#pragma mark - private
- (void)_uploadAndSaveAvatarWithImg:(UIImage *)avatar {
    [MBProgressHUD showLoadingWithMessage:@"正在上传图片..."];
    
    NSData *imageDate = UIImageJPEGRepresentation(avatar, 1);
    [[WLServerHelper sharedInstance] uploadAvatarWithImageData:imageDate callback:^(WLUploadImageModel *apiInfo, NSError *error) {
        if (error) {
            DLog(@"%@", error);
            [MBProgressHUD hideLoading];
            return;
        }
        if (apiInfo.error != 0) {
            [MBProgressHUD hideLoading];
            [MBProgressHUD showErrorWithMessage:apiInfo.message];
            return;
        }
        [MBProgressHUD hideLoading];
        WLUserModel *user = [WLDatabaseHelper user_find];
        user.avatar = apiInfo.url;
        [WLDatabaseHelper user_save:user];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserInfoUpdate object:nil];
    }];
}

#pragma mark - delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:pickerAlbum]) {
        // 打开相册
        _weak(self);
        AGImagePickerController *ipc = [[AGImagePickerController alloc] init];
        ipc.maximumNumberOfPhotosToBeSelected = 1;
        ipc.toolbarItemsForManagingTheSelection = @[];
        ipc.didFailBlock = ^(NSError *error) {
            _strong_check(self);
            if (error == nil) {
                DLog(@"User has cancelled.");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                DLog(@"Fail. Error: %@", error);
                // We need to wait for the view controller to appear first.
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    _strong_check(self);
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
        };
        ipc.didFinishBlock = ^(NSArray *info) {
            _strong_check(self);
            __block UIImage *image = nil;
            for (ALAsset *asset in info) {
                image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                image = [image adjustedToStandardSize];
                if (image) {
                    break;
                }
            }
            [self dismissViewControllerAnimated:YES completion:^(void){
                _strong_check(self);
                [self _uploadAndSaveAvatarWithImg:image];
            }];
        };
        [self.navigationController presentViewController:ipc animated:YES completion:nil];
    }
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:pickerCamera]) {
        // 拍照
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = @[(__bridge NSString*)kUTTypeImage];
        _weak(self);
        [picker withBlockForDidFinishPickingMedia:^(UIImagePickerController *picker, NSDictionary *info) {
            _strong_check(self);
            __block UIImage *img = nil;
            if (picker.allowsEditing) {
                img = info[UIImagePickerControllerEditedImage];
            }
            else {
                img = info[UIImagePickerControllerOriginalImage];
            }
            img = [img adjustedToStandardSize];
            if (!img) {
                [MBProgressHUD showErrorWithMessage:@"图片不可用" completeBlock:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return;
                }];
            }
            [self dismissViewControllerAnimated:YES completion:^(void){
                _strong_check(self);
                [self _uploadAndSaveAvatarWithImg:img];
            }];
        }];
        [self presentViewController:picker animated:YES completion:nil];
    }
}

@end
