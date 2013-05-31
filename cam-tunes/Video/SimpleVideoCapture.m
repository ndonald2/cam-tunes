//
//  SimpleVideoCapture.m
//  CameraSound
//
//  Created by Nick Donaldson on 11/2/12.
//  Copyright (c) 2012 Nick Donaldson. All rights reserved.
//

#import "SimpleVideoCapture.h"
#import <CoreMedia/CoreMedia.h>

static dispatch_queue_t _videoQueue = nil;
static char * const _videoQueueName = "com.flatline.videoSessionQueue";

@interface SimpleVideoCapture ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;

@end

@implementation SimpleVideoCapture

#pragma mark - Init

+ (SimpleVideoCapture*)sharedInstance
{
    static SimpleVideoCapture * s_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[SimpleVideoCapture alloc] init];
    });
    return s_sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self){
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _videoQueue = dispatch_queue_create(_videoQueueName, NULL);
        });
        
        // Get the camera
        AVCaptureDevice *backCamera = nil;
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in devices)
        {
            if ([device position] == AVCaptureDevicePositionBack)
            {
                backCamera = device;
            }
        }   

        // set auto-exposure mode
        NSError *err = nil;
        if ([backCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]){
            [backCamera lockForConfiguration:&err];
            [backCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            [backCamera unlockForConfiguration];
        }
        
        // Create the capture session
        self.captureSession = [[AVCaptureSession alloc] init];
        
        // Add the video input
        NSError *error = nil;
        self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:backCamera error:&error];
        if ([self.captureSession canAddInput:self.videoInput])
        {
            [self.captureSession addInput:self.videoInput];
        }
        
        // Add the video frame output
        self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
        [self.videoOutput setAlwaysDiscardsLateVideoFrames:YES];
        
        // Use RGB frames instead of YUV for easier color processing
        [self.videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];

        [self.videoOutput setSampleBufferDelegate:self queue:_videoQueue];
        
        if ([self.captureSession canAddOutput:self.videoOutput])
        {
            [self.captureSession addOutput:self.videoOutput];
        }
        else
        {
            NSLog(@"Couldn't add video output");
        }
        
        // Low-res by default
        [self.captureSession setSessionPreset:AVCaptureSessionPreset640x480];
    }
    return self;
}

- (void)startCapture
{
    if (![self.captureSession isRunning])
    {
        [self.captureSession startRunning];
    };
}

- (void)stopCapture
{
    if ([self.captureSession isRunning])
    {
        [self.captureSession stopRunning];
    };
}

- (AVCaptureVideoPreviewLayer*)createVideoPreviewLayer
{
    AVCaptureVideoPreviewLayer * videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    return videoPreviewLayer;
}


#pragma mark - Property override


- (dispatch_queue_t)videoSessionQueue
{
    return _videoQueue;
}

#pragma mark - Sample buffer delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [self.delegate videoCapture:self didReceivePixelFrame:pixelBuffer];
}

@end
