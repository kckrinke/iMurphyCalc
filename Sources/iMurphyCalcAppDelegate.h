//
//  iMurphyCalcAppDelegate.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import <UIKit/UIKit.h>

/** This is the primary delegate class which handles the main view controller.
 */
@class MainViewController;

/** iMurphyCalc Application Delegate declaration.
 */
@interface iMurphyCalcAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window; ///< The main window object.
    MainViewController *mainViewController; ///< Main view controller object
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

