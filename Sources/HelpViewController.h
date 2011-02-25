//
//  HelpViewController.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Declare a delegate protocol for the help view.
 */
@protocol HelpViewControllerDelegate;

/** Help View controller.
 */
@interface HelpViewController : UIViewController {
	id <HelpViewControllerDelegate> delegate;
}

/** Declare a "done" method to trigger the view to "close".
 */
@property (nonatomic, assign) id <HelpViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
@end

/** Define the delegate protocol for the help view.
 */
@protocol HelpViewControllerDelegate
- (void)helpViewControllerDidFinish:(HelpViewController *)controller;
@end

