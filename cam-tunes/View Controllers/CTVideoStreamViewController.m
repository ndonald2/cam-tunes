//
//  CTVideoStreamViewController.m
//  cam-tunes
//
//  Created by Nick Donaldson on 5/31/13.
//  Copyright (c) 2013 flatline. All rights reserved.
//

#import "CTVideoStreamViewController.h"
#import "SimpleVideoCapture.h"

#import <AVFoundation/AVFoundation.h>


@interface CTVideoStreamViewController ()

@property (nonatomic, strong) AVCaptureVideoPreviewLayer * vidLayer;

@end

@implementation CTVideoStreamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.vidLayer = [[SimpleVideoCapture sharedInstance] createVideoPreviewLayer];
    [self.view.layer setFrame:self.view.bounds];
    [self.view.layer insertSublayer:self.vidLayer atIndex:0];
    
    // start right away for now
    [[SimpleVideoCapture sharedInstance] startCapture];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.vidLayer.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
