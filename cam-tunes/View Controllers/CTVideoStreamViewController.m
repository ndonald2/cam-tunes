//
//  CTVideoStreamViewController.m
//  cam-tunes
//
//  Created by Nick Donaldson on 5/31/13.
//  Copyright (c) 2013 flatline. All rights reserved.
//

#import "CTVideoStreamViewController.h"
#import "GPUImage.h"

@interface CTVideoStreamViewController ()

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *videoOutputView;

@end

@implementation CTVideoStreamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    self.videoOutputView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.videoOutputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.videoOutputView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.view addSubview:self.videoOutputView];
    
//    GPUImageLuminosity *luminosity = [[GPUImageLuminosity alloc] init];
//    [luminosity setLuminosityProcessingFinishedBlock:^(CGFloat luminosity, CMTime time) {
//        
//    }];
//    
//    [self.videoCamera addTarget:luminosity];
    
//    GPUImagePolkaDotFilter *dotFilter = [[GPUImagePolkaDotFilter alloc] init];
//    
//    [self.videoCamera addTarget:dotFilter];
//    [dotFilter addTarget:self.videoOutputView];
    
    [self.videoCamera addTarget:self.videoOutputView];
    
    [self.videoCamera startCameraCapture];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
