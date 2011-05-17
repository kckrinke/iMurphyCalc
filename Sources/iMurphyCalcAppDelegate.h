//
//  iMurphyCalcAppDelegate.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "SettingsMonitor.h"

/** This is the primary delegate class which handles the main view controller.
 */
@class MainViewController;

/** iMurphyCalc Application Delegate declaration.
 */
@interface iMurphyCalcAppDelegate : NSObject <UIApplicationDelegate,SettingsMonitorDelegate>
{
    UIWindow *window; ///< The main window object.
    MainViewController *mainViewController; ///< Main view controller object
    SettingsMonitor *settingsMonitor;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;
@property (nonatomic, retain) SettingsMonitor *settingsMonitor;

- (void)settingsChanged:(NSNotification *)notification;
@end

