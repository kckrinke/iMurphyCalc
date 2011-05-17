//
//  iMurphyCalcAppDelegate.m
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import "iMurphyCalcAppDelegate.h"
#import "MainViewController.h"
#import "Config.h"

@implementation iMurphyCalcAppDelegate

@synthesize window;
@synthesize mainViewController;
@synthesize settingsMonitor;

#pragma mark - Application lifecycle

- (void)settingsChanged:(NSNotification *)notification
{
    BOOL use = [[NSUserDefaults standardUserDefaults] boolForKey:@"use_orig_formula"];
    [mainViewController set_use_orig_formula:use];
}

- (void)initialize:(UIApplication *)application
{
    NSDictionary *reg = nil;
    [reg setValue:[NSNumber numberWithBool:false] forKey:@"use_orig_formula"];
    [reg setValue:[NSString stringWithString:APP_VERSION] forKey:@"app_version"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:reg];
    [application setStatusBarHidden:true];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DEBUG_DEVICE_INFO();

    // Override point for customization after application launch.
    // Add the main view controller's view to the window and display.
    [self setSettingsMonitor:[[SettingsMonitor alloc] initWithDelegate:self]];
    [self.window addSubview:mainViewController.view];
    [self.window makeKeyAndVisible];
    [application setStatusBarHidden:true];
    [mainViewController set_use_orig_formula:[[NSUserDefaults standardUserDefaults] boolForKey:@"use_orig_formula"]];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [settingsMonitor release];
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
