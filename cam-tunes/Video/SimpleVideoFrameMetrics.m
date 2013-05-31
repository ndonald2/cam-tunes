//
//  SimpleVideoFrameMetrics.m
//  CameraSound
//
//  Created by Nick Donaldson on 11/2/12.
//  Copyright (c) 2012 Nick Donaldson. All rights reserved.
//

NSString* const kSimpleVideoFrameMetricsUpdateNotification = @"SimpleVideoFrameMetricsUpdated";

#import "SimpleVideoFrameMetrics.h"
#import <CoreMedia/CoreMedia.h>
#import <Accelerate/Accelerate.h>

#import "CSColorUtils.h"

@interface SimpleVideoFrameMetrics ()

@end

@implementation SimpleVideoFrameMetrics

#pragma mark - Video pixel capture delegate

- (void)videoCapture:(SimpleVideoCapture *)simpleVideoCapture didReceivePixelFrame:(CVImageBufferRef)pixelBufferRef
{
	CVPixelBufferLockBaseAddress(pixelBufferRef, 0);
	int frameHeight = CVPixelBufferGetHeight(pixelBufferRef);
	int frameWidth = CVPixelBufferGetWidth(pixelBufferRef);
    int bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBufferRef);
    
    unsigned char *rowBase = (unsigned char *)CVPixelBufferGetBaseAddress(pixelBufferRef);
    
    int avgR = 0.0f;
    int avgG = 0.0f;
    int avgB = 0.0f;
    
    // loop through pixels and calculate avg metrics
    for (int y=0; y<frameHeight; y++){
        for (int x=0; x<frameWidth; x++){
            
            unsigned char *pixel = rowBase + (y * bytesPerRow) + (x * 4);
            avgR += pixel[2];
            avgG += pixel[1];
            avgB += pixel[0];
        }
    }
    
    CVPixelBufferUnlockBaseAddress(pixelBufferRef, 0);
    
    int nPixels = frameWidth*frameHeight;
    avgR /= nPixels;
    avgG /= nPixels;
    avgB /= nPixels;
    
}

@end
