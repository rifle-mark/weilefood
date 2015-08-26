//
//  WeiCommentEditVC.m
//  Sunflower
//
//  Created by makewei on 15/6/2.
//  Copyright (c) 2015年 MKW. All rights reserved.
//

#import "ShareEditVC.h"

#import "AGImagePickerController.h"
#import "UIImage+AdjustmentSize.h"

#import "WLServerHelperHeader.h"
#import "WLModelHeader.h"

@interface ShareEditPicCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView      *imgV;
@property(nonatomic,strong)UIButton         *deleteBtn;
@property(nonatomic,strong)UIButton         *pickBtn;

@property(nonatomic,assign)BOOL             hasImg;

@property(nonatomic,copy)void(^imageDeleteBlock)(NSString *imgUrl, UIImage *img);
@property(nonatomic,copy)void(^imagePickBlock)(ShareEditPicCell *cell);

+ (NSString *)reuseIdentify;

@end

@implementation ShareEditPicCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imgV = [[UIImageView alloc] init];
        self.imgV.contentMode = UIViewContentModeScaleAspectFill;
        self.imgV.clipsToBounds = YES;
        [self.contentView addSubview:self.imgV];
        _weak(self);
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.left.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).with.offset(8);
            make.right.equalTo(self.contentView).with.offset(-8);
        }];
        self.deleteBtn = [[UIButton alloc] init];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"share_edit_img_delete_btn"] forState:UIControlStateNormal];
        [self.deleteBtn addControlEvents:UIControlEventTouchDown action:^(UIControl *control, NSSet *touches) {
            _strong(self);
            GCBlockInvoke(self.imageDeleteBlock, @"", self.imgV.image);
        }];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.centerX.equalTo(self.imgV.mas_right);
            make.centerY.equalTo(self.imgV.mas_top);
            make.width.height.equalTo(@16);
        }];
        
        self.pickBtn = [[UIButton alloc] init];
        [self.pickBtn setBackgroundImage:[UIImage imageNamed:@"share_edit_img_add_btn"] forState:UIControlStateNormal];
        [self.pickBtn addControlEvents:UIControlEventTouchUpInside action:^(UIControl *control, NSSet *touches) {
            _strong(self);
            GCBlockInvoke(self.imagePickBlock, self);
        }];
        [self.contentView addSubview:self.pickBtn];
        [self.pickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            _strong(self);
            make.left.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).with.offset(8);
            make.right.equalTo(self.contentView).with.offset(-8);
        }];
        
        [self.imgV setHidden:YES];
        [self.deleteBtn setHidden:YES];
        
        [self _setupObserver];
    }
    
    return self;
}

- (void)prepareForReuse {
    [self.pickBtn setHidden:NO];
    [self.imgV setHidden:YES];
    [self.deleteBtn setHidden:YES];
    self.hasImg = NO;
}

- (void)_setupObserver {
    _weak(self);
    [self startObserveObject:self forKeyPath:@"hasImg" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        _strong(self);
        if (self.hasImg) {
            [self.imgV setHidden:NO];
            [self.deleteBtn setHidden:NO];
            [self.pickBtn setHidden:YES];
        }
        else {
            [self.pickBtn setHidden:NO];
            [self.imgV setHidden:YES];
            [self.deleteBtn setHidden:YES];
        }
    }];
}

+ (NSString *)reuseIdentify {
    return @"WeiCommentEditPicCellIdentify";
}

@end

@interface ShareEditVC () <UIActionSheetDelegate>

@property(nonatomic,strong)UIScrollView     *scrollV;
@property(nonatomic,strong)UIView           *contentV;
@property(nonatomic,strong)UITextView       *editV;
@property(nonatomic,strong)UICollectionView *picsV;

@property(nonatomic,strong)NSMutableArray   *picUrlArray;
@property(nonatomic,strong)NSMutableArray   *images;

@end

static NSString* pickerAlbum = @"相册";
static NSString* pickerCamera = @"拍照";

@implementation ShareEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发布分享";
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(_cancelShare:)];
    cancelItem.tintColor = k_COLOR_WHITE;
    self.navigationItem.leftBarButtonItem = cancelItem;
    UIBarButtonItem *submitItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(_submitShare:)];
    submitItem.tintColor = k_COLOR_WHITE;
    self.navigationItem.rightBarButtonItem = submitItem;
    
    self.picUrlArray = [[NSMutableArray alloc] init];
    self.images = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.scrollV];
    [self.scrollV addSubview:self.contentV];
    [self.contentV addSubview:self.editV];
    [self.contentV addSubview:self.picsV];
    
    [self _setupObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.scrollV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollV.superview);
        make.top.equalTo(self.scrollV.superview).with.offset(self.topLayoutGuide.length);
        make.bottom.equalTo(self.scrollV.superview).with.offset(-self.bottomLayoutGuide.length);
    }];
    
    [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(self.contentV.superview);
    }];
    
    [self.editV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.editV.superview);
        make.height.equalTo(@145);
    }];
    
    [self.picsV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editV.mas_bottom);
        make.left.equalTo(self.picsV.superview).with.offset(15);
        make.right.equalTo(self.picsV.superview).with.offset(-15);
        make.bottom.equalTo(self.picsV.superview);
        CGFloat picw = ([[UIScreen mainScreen] bounds].size.width-60)/4;
        int rowcount = [self.images count] <= 4 ? 1 : ([self.images count] <=8 ? 2 : 3);
        rowcount = rowcount + ([self.images count]%4==0&&[self.images count]!=0?1:0);
        make.height.equalTo(@((picw+10)*rowcount+20));
    }];
    
    FixesViewDidLayoutSubviewsiOS7Error;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}*/

#pragma mark - Coding Views

- (UIScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] init];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.backgroundColor = k_COLOR_WHITE;
    }
    
    return _scrollV;
}

- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.backgroundColor = k_COLOR_WHITE;
        _contentV.clipsToBounds =YES;
    }
    
    return _contentV;
}

- (UITextView *)editV {
    if (!_editV) {
        _editV = [[UITextView alloc] init];
        _editV.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _editV.backgroundColor = k_COLOR_CLEAR;
        _editV.textColor = k_COLOR_SLATEGRAY;
        _editV.font = [UIFont boldSystemFontOfSize:15];
        _editV.textContainerInset = UIEdgeInsetsMake(15, 20, 15, 20);
        _editV.text = @"此时此地，想说点啥~";
        _weak(self);
        [_editV withBlockForDidBeginEditing:^(UITextView *view) {
            _strong_check(self);
            if ([self.editV.text isEqualToString:@"此时此地，想说点啥~"]) {
                self.editV.text = @"";
            }
        }];
        
        UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_inputViewDone)];
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
        toolBar.items = @[fixItem, doneItem];
        _editV.inputAccessoryView = toolBar;
    }
    return _editV;
}

- (UICollectionView *)picsV {
    if (!_picsV) {
        _weak(self);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(2, 0, 10, 0);
        CGFloat picWH = ([[UIScreen mainScreen] bounds].size.width-60)/4;
        layout.itemSize = ccs(picWH, picWH);
        _picsV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _picsV.backgroundColor = k_COLOR_CLEAR;
        [_picsV registerClass:[ShareEditPicCell class] forCellWithReuseIdentifier:[ShareEditPicCell reuseIdentify]];
        [_picsV withBlockForSectionNumber:^NSInteger(UICollectionView *view) {
            return 1;
        }];
        [_picsV withBlockForItemNumber:^NSInteger(UICollectionView *view, NSInteger section) {
            _strong_check(self, 0);
            if ([self.images count] == 9) {
                return 9;
            }
            return [self.images count]+1;
        }];
        [_picsV  withBlockForItemCell:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *path) {
            _strong_check(self, nil);
            ShareEditPicCell *cell = [view dequeueReusableCellWithReuseIdentifier:[ShareEditPicCell reuseIdentify] forIndexPath:path];
            if (!cell) {
                cell = [[ShareEditPicCell alloc] init];
            }
            if (path.row < [self.images count]) {
                cell.imgV.image = self.images[path.row];
                cell.hasImg = YES;
            }
            cell.imageDeleteBlock = ^(NSString *imgUrl, UIImage *img) {
                [self.images removeObject:img];
                [self _refreshPicView];
            };
            cell.imagePickBlock = ^(ShareEditPicCell *cell) {
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
            };
            return cell;
        }];
    }
    
    return _picsV;
}

- (void)_refreshPicView {
    _weak(self);
    [self.picsV mas_remakeConstraints:^(MASConstraintMaker *make) {
        _strong(self);
        make.top.equalTo(self.editV.mas_bottom);
        make.left.equalTo(self.contentV).with.offset(15);
        make.right.equalTo(self.contentV).with.offset(-15);
        make.bottom.equalTo(self.picsV.superview);
        CGFloat picw = ([[UIScreen mainScreen] bounds].size.width-60)/4;
        int rowcount = [self.images count] <= 4 ? 1 : ([self.images count] <=8 ? 2 : 3);
        rowcount = rowcount + ([self.images count]%4==0?1:0);
        make.height.equalTo(@((picw+10)*rowcount+20));
    }];
    [self.picsV reloadData];
}

- (void)_setupObserver {
}

#pragma mark - UIControl Action

- (void)_cancelShare:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_uploadImageWithIndex:(NSInteger)index successUploadImages:(NSMutableArray *)successUploadImages completeBlock:(void (^)())completeBlock {
    if (index == 0) {
        [MBProgressHUD showLoadingWithMessage:@"正在上传图片..."];
    }
    
    UIImage *image = self.images[index];
    NSData *imageDate = UIImageJPEGRepresentation(image, 1);
    [[WLServerHelper sharedInstance] uploadImageWithImageData:imageDate callback:^(WLUploadImageModel *apiInfo, NSError *error) {
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
        [successUploadImages addObject:apiInfo.url];
        if (successUploadImages.count < self.images.count) {
            [self _uploadImageWithIndex:(index + 1) successUploadImages:successUploadImages completeBlock:completeBlock];
        }
        else {
            [MBProgressHUD hideLoading];
            GCBlockInvoke(completeBlock);
        }
    }];
}
- (void)_submitShare:(id)sender {
    
    _weak(self);
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self.editV resignFirstResponder];
    NSString *content = [self.editV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([content isEqualToString:@"此时此地，想说点啥~"] || [NSString isNilEmptyOrBlankString:content]) {
        [MBProgressHUD showErrorWithMessage:@"请输入内容"];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        return;
    }
    
    void (^saveBlock)(NSString *content, NSString *images) = ^(NSString *content, NSString *images){
        [[WLServerHelper sharedInstance] share_addWithContent:content images:images callback:^(WLApiInfoModel *apiInfo, WLShareModel *apiResult, NSError *error) {
            _strong_check(self);
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
            ServerHelperErrorHandle;
            
            [self.navigationController popViewControllerAnimated:YES];
            GCBlockInvoke(self.addSuccessBlock);
        }];
    };
    
    if ([self.images count] > 0) {
        __block NSMutableArray *successUploadImages = [@[] mutableCopy];
        [self _uploadImageWithIndex:0 successUploadImages:successUploadImages completeBlock:^{
            _strong_check(self);
            NSMutableString *imgStr = [@"" mutableCopy];
            for (NSString *url in successUploadImages) {
                [imgStr appendString:url];
                [imgStr appendString:@","];
            }
            NSString *imgs = [imgStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            
            GCBlockInvoke(saveBlock, self.editV.text, imgs);
        }];
    }
    else {
        GCBlockInvoke(saveBlock, self.editV.text, @"");
    }
    
}

- (void)_inputViewDone {
    [self.editV resignFirstResponder];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clicked index %ld", buttonIndex);
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:pickerAlbum]) {
        // 打开相册
        _weak(self);
        AGImagePickerController *ipc = [[AGImagePickerController alloc] init];
        ipc.maximumNumberOfPhotosToBeSelected = 9-[self.images count];
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
            NSMutableArray *newImages = [NSMutableArray array];
            for (ALAsset *asset in info) {
                UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                image = [image adjustedToStandardSize];
                [newImages addObject:image];
            }
            if (newImages.count > 0) {
                [self.images addObjectsFromArray:newImages];
                [self _refreshPicView];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self.navigationController presentViewController:ipc animated:YES completion:nil];
    }
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:pickerCamera]) {
        // 拍照
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = @[(__bridge NSString*)kUTTypeImage];
        [picker withBlockForDidFinishPickingMedia:^(UIImagePickerController *picker, NSDictionary *info) {
            UIImage *img = nil;
            if (picker.allowsEditing) {
                img = info[UIImagePickerControllerEditedImage];
            }
            else {
                img = info[UIImagePickerControllerOriginalImage];
            }
            img = [img adjustedToStandardSize];
            [self.images addObjectsFromArray:@[img]];
            [self _refreshPicView];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:picker animated:YES completion:nil];
    }
}
@end