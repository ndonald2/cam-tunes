//
//  SimpleVideoFrameMetrics.h
//  CameraSound
//
//  Created by Nick Donaldson on 11/2/12.
//  Copyright (c) 2012 Nick Donaldson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleVideoCapture.h"

extern NSString* const kSimpleVideoFrameMetricsUpdateNotification;

@interface SimpleVideoFrameMetrics : NSObject <SimpleVideoCaptureDelegate>

@end
