//
//  CompictureVC.m
//  MyWork
//
//  Created by 赵大成 on 2017/11/8.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "CompictureVC.h"

#import "MWHeader.pch"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CompictureVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIButton * getImgBtn;
@property (nonatomic, strong) UIButton * nextBtn;

@property (nonatomic, strong) UIImagePickerController *pickerVC;

@property (nonatomic, strong) NSMutableArray * compictures;
@property (nonatomic, assign) NSInteger index;//当前第几张照片

@end

@implementation CompictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的相册";
    
    self.index = 0;
    self.compictures = @[].mutableCopy;
    [self setMainView];
}

- (void)setMainView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    
    self.getImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getImgBtn setTitle:@"照片" forState:UIControlStateNormal];
    [self.getImgBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.getImgBtn addTarget:self action:@selector(getImages) forControlEvents:UIControlEventTouchUpInside];
    self.getImgBtn.backgroundColor = [UIColor lightTextColor];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.getImgBtn];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takeCamera)];
    self.navigationItem.rightBarButtonItems = @[item1, item2];
    
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setTitle:@"下一张" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextCompicture) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.nextBtn];
    
    [self.imageView autoSetDimension:ALDimensionWidth toSize:200];
    [self.imageView autoSetDimension:ALDimensionHeight toSize:200];
    [self.imageView autoCenterInSuperview];
    
    [self.nextBtn autoSetDimension:ALDimensionWidth toSize:100];
    [self.nextBtn autoSetDimension:ALDimensionHeight toSize:50];
    [self.nextBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:40];
    [self.nextBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
}

- (UIView *)cameraView
{
    // 拍照界面容器
    UIView * customCameraView = [[UIView alloc] initWithFrame:[UIScreen  mainScreen].bounds];
    
    // 开始摄像按钮（如果是拍照，则不需要此按钮）
    UIButton * start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setTitle:@"录像" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchDown];
    start.backgroundColor = [UIColor whiteColor];
    [customCameraView addSubview:start];
    
    // 停止摄像按钮（如果是拍照，则不需要此按钮）
    UIButton * stop = [UIButton buttonWithType:UIButtonTypeCustom];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchDown];
    stop.backgroundColor = [UIColor whiteColor];
    [customCameraView addSubview:stop];
    
    // 拍照按钮（如果是摄像，则不需要此按钮）
    UIButton * takePicture = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePicture setTitle:@"照相" forState:UIControlStateNormal];
    [takePicture setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [takePicture addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchDown];
    takePicture.backgroundColor = [UIColor whiteColor];
    [customCameraView addSubview:takePicture];
    
    [takePicture autoSetDimension:ALDimensionWidth toSize:80];
    [takePicture autoSetDimension:ALDimensionHeight toSize:50];
    
    [start autoSetDimension:ALDimensionWidth toSize:80];
    [start autoSetDimension:ALDimensionHeight toSize:50];
    
    [stop autoSetDimension:ALDimensionWidth toSize:80];
    [stop autoSetDimension:ALDimensionHeight toSize:50];
    
    [takePicture autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [takePicture autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:70];
    
    [start autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:takePicture withOffset:30];
    [start autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:70];
    
    [stop autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:70];
    [stop autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:takePicture withOffset:-30];
    
    return customCameraView;
}

- (void)getImages
{
    self.pickerVC = [[UIImagePickerController alloc] init];
    self.pickerVC.delegate = self;
    self.pickerVC.allowsEditing = YES;
    [self presentViewController:self.pickerVC animated:YES completion:^{
        NSLog(@"进来了");
    }];
}

- (void)takeCamera
{
    self.pickerVC = [[UIImagePickerController alloc] init];
    self.pickerVC.delegate = self;
    self.pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    self.pickerVC.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
    self.pickerVC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    self.pickerVC.allowsEditing = YES;
    self.pickerVC.videoMaximumDuration = 10;
    self.pickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
    self.pickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.pickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.pickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    self.pickerVC.showsCameraControls = NO;
    self.pickerVC.cameraOverlayView = [self cameraView];
    
    [self presentViewController:self.pickerVC animated:YES completion:nil];
}

- (void)nextCompicture
{
    if (self.compictures.count == 0) {
        return;
    }
    if (self.index == self.compictures.count) {
        
        self.index = 0;
    }
    self.imageView.image = [self.compictures objectAtIndex:self.index];
    
    self.index++;
}

- (void)start {
    // 开始摄像
    [self.pickerVC startVideoCapture];
}

- (void)stop {
    // 停止摄像
    [self.pickerVC stopVideoCapture];
}

- (void)takePicture {
    // 拍照
    [self.pickerVC takePicture];
    
}

#pragma mark _ UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"出去了");
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"info=%@", info);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image) {
        [self.compictures addObject:image];
        [self.imageView setImage:image];
    }
    
    [self imagePickerControllerDidCancel:picker];
    
}

@end
