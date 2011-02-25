//
//  AboutViewController.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Declare a delegate protocol for the about view.
 */
@protocol AboutViewControllerDelegate;

/** About view controller.
 */
@interface AboutViewController : UIViewController {
	id <AboutViewControllerDelegate> delegate;
}

/** Declare a "done" method to trigger the view to "close".
 */
@property (nonatomic, assign) id <AboutViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
@end

/** Define the delegate protocol for the about view.
 */
@protocol AboutViewControllerDelegate
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller;
@end

