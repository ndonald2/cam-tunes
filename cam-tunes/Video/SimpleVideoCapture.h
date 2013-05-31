//
//  SimpleVideoCapture.h
//  CameraSound
//
//  Created by Nick Donaldson on 11/2/12.
//  Copyright (c) 2012 Nick Donaldson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol SimpleVideoCaptureDelegate;

@interface SimpleVideoCapture : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

+ (SimpleVideoCapture*)sharedInstance;

@property (nonatomic, readonly) dispatch_queue_t videoSessionQueue;
@property (nonatomic, weak) id<SimpleVideoCaptureDelegate> delegate;

- (AVCaptureVideoPreviewLayer*)createVideoPreviewLayer;

- (void)startCapture;
- (void)stopCapture;

@end

@protocol SimpleVideoCaptureDelegate <NSObject>

- (void)videoCapture:(SimpleVideoCapture*)simpleVideoCapture didReceivePixelFrame:(CVImageBufferRef)pixelBufferRef;

@end
