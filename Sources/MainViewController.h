//
//  MainViewController.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import "HelpViewController.h"
#import "AboutViewController.h"

/** MainViewController.
 This is the primary view for the application. All of the slider, tips and
 visual cues that actually make this app do something happen here.
 */
@interface MainViewController : UIViewController <AboutViewControllerDelegate,HelpViewControllerDelegate> {
   IBOutlet UILabel *formula_label; ///< UI out let for displaying the specific formula being used
   IBOutlet UILabel *tips_label; ///< UI outlet for the per-slider tips
   IBOutlet UILabel *result_label; ///< UI outlet for the percentage result text
   IBOutlet UILabel *suggest_label; ///< UI outlet for a tip on how to proceed with a task given the current slider states
   IBOutlet UIImageView *therm_image; ///< UI outlet for the thermometer image view
   float urgency; ///< stores the currently set urgency
   float complexity; ///< stores the currently set complexity
   float importance; ///< stores the currently set importance
   float skill; ///< stores the currently set skill level
   float frequency; ///< stores the currently set frequency
    int use_orig_formula;
    NSMutableArray *plist_therm_img;
    NSMutableArray *plist_suggestion;
    NSMutableArray *plist_tips_urgency;
    NSMutableArray *plist_tips_complexity;
    NSMutableArray *plist_tips_importance;
    NSMutableArray *plist_tips_skill;
    NSMutableArray *plist_tips_frequency;
}

@property (nonatomic, retain) UILabel *formula_label;
@property (nonatomic, retain) UILabel *tips_label;
@property (nonatomic, retain) UILabel *result_label;
@property (nonatomic, retain) UILabel *suggest_label;
@property (nonatomic, retain) UIImageView *therm_image;
@property (nonatomic) float urgency;
@property (nonatomic) float complexity;
@property (nonatomic) float importance;
@property (nonatomic) float skill;
@property (nonatomic) float frequency;
@property (nonatomic) int use_orig_formula;
@property (nonatomic, retain) NSMutableArray *plist_therm_img;
@property (nonatomic, retain) NSMutableArray *plist_suggestion;
@property (nonatomic, retain) NSMutableArray *plist_tips_urgency;
@property (nonatomic, retain) NSMutableArray *plist_tips_complexity;
@property (nonatomic, retain) NSMutableArray *plist_tips_importance;
@property (nonatomic, retain) NSMutableArray *plist_tips_skill;
@property (nonatomic, retain) NSMutableArray *plist_tips_frequency;

- (void)loadAllPlistData;

/** Method to show the help view.
 */
- (IBAction)showHelp:(id)sender;

/** Hide the help view and show the main view again.
 */
- (void)helpViewControllerDidFinish:(HelpViewController *)controller;

/** Method to show the about view.
 */
- (IBAction)showAbout:(id)sender;

/** Hide the about view and show the main view again.
 */
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller;

/** Helper method that performs the Sod's Law calculation.
 */
- (float)calculate_sod_factor;

/** Method that updates all of the UI elements after re-calculating the current
 Sod's Law value
 */
- (void)update_results;

/** Method that helps abstract the setting of all the different labels.
 */
- (IBAction)update_labels:(id)sender;

/** Method for clearing the per-slider tips label.
 
 Currently this will simply blank out the text. This should probably give some
 general tips on how to deal with various stressors like over-complexity or
 lack of skill.
 */
- (IBAction)reset_tips_label:(id)sender;

/** Update the currently used formula (and UI) when the settings are changed.
 */
- (void)set_use_orig_formula:(BOOL)state;

/** Initialze the main view as it has just been loaded.
 */
- (void)viewDidLoad;

/** Unload any cached data as the main view is going away.
 */
- (void)viewDidUnload;

/** Deallocate any stored objects etc.
 */
- (void)dealloc;

@end
