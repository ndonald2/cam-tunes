//
//  CTAppDelegate.h
//  cam-tunes
//
//  Created by Nick Donaldson on 5/31/13.
//  Copyright (c) 2013 flatline. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTViewController;

@interface CTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CTViewController *viewController;

@end
