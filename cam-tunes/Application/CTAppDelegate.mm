//
//  CTAppDelegate.m
//  cam-tunes
//
//  Created by Nick Donaldson on 5/31/13.
//  Copyright (c) 2013 flatline. All rights reserved.
//

#import "CTAppDelegate.h"
#import "CTVideoStreamViewController.h"
#import "TonicSynthManager.h"

@implementation CTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // View controller goes here
    CTVideoStreamViewController *vidVC = [[CTVideoStreamViewController alloc] initWithNibName:nil bundle:nil];
    [self.window setRootViewController:vidVC];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[TonicSynthManager sharedManager] endSession];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[TonicSynthManager sharedManager] startSession];
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
