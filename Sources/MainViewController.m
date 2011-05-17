//
//  MainViewController.m
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import "MainViewController.h"
#include "sodmath.h"
#import "Config.h"

@implementation MainViewController
@synthesize formula_label;
@synthesize tips_label;
@synthesize result_label;
@synthesize suggest_label;
@synthesize therm_image;
@synthesize urgency;
@synthesize complexity;
@synthesize importance;
@synthesize skill;
@synthesize frequency;
@synthesize use_orig_formula;
@synthesize plist_therm_img;
@synthesize plist_suggestion;
@synthesize plist_tips_urgency;
@synthesize plist_tips_complexity;
@synthesize plist_tips_importance;
@synthesize plist_tips_skill;
@synthesize plist_tips_frequency;

- (float)calculate_sod_factor {
    if (self.use_orig_formula == 1)
    {
        // 1.0 == 0.01, 9.0 = 0.9
        float U = (100.0f / 8.0f) * (self.urgency - 1.0f) / 100.0f;
        float C = (100.0f / 8.0f) * (self.complexity - 1.0f) / 100.0f;
        float I = (100.0f / 8.0f) * (self.importance - 1.0f) / 100.0f;
        float S = (100.0f / 8.0f) * (self.skill - 1.0f) / 100.0f;
        float F = (100.0f / 8.0f) * (self.frequency - 1.0f) / 100.0f;
        return calculate_sod_factor_orig(U, C, I, S, F);
    }
    return calculate_sod_factor_alt(self.urgency,self.complexity,self.importance,self.skill,self.frequency);
}

- (void)loadAllPlistData {
    self.plist_therm_img = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"therm_img" ofType:@"plist"]];
    self.plist_suggestion = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"suggestion" ofType:@"plist"]];
    self.plist_tips_urgency = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tips_urgency" ofType:@"plist"]];
    self.plist_tips_complexity = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tips_complexity" ofType:@"plist"]];
    self.plist_tips_importance = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tips_importance" ofType:@"plist"]];
    self.plist_tips_skill = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tips_skill" ofType:@"plist"]];
    self.plist_tips_frequency = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tips_frequency" ofType:@"plist"]];
}

- (void)update_results {
    float result = [self calculate_sod_factor];
    
    int idx = array_index_by_custom_perc(result, 0.0f, 1.0f, self.plist_therm_img.count);
    [self.therm_image setImage:[UIImage imageNamed:[self.plist_therm_img objectAtIndex:idx]]];
    
    idx = array_index_by_custom_perc(result, 0.0f, 1.0f, self.plist_suggestion.count);
    self.suggest_label.text = [self.plist_suggestion objectAtIndex:idx];
    
    int percentage = mClampI((int)(result * 100),0,100);
    self.result_label.text = [NSString stringWithFormat:@"%d%%", percentage];
}

- (IBAction)reset_tips_label:(id)sender {
    self.tips_label.text = @"";
}

- (IBAction)update_labels:(id)sender {
    UISlider *slider = (UISlider *)sender;
    switch (slider.tag) {
        case 100: {
            int idx = array_index_by_custom_perc(slider.value, 1.0f, 9.0f, self.plist_tips_urgency.count);
            self.tips_label.text = [self.plist_tips_urgency objectAtIndex:idx];
            self.urgency = slider.value;
            break;
        }
        case 200: {
            int idx = array_index_by_custom_perc(slider.value, 1.0f, 9.0f, self.plist_tips_complexity.count);
            self.tips_label.text = [self.plist_tips_complexity objectAtIndex:idx];
            self.complexity = slider.value;
            break;
        }
        case 300: {
            int idx = array_index_by_custom_perc(slider.value, 1.0f, 9.0f, self.plist_tips_importance.count);
            self.tips_label.text = [self.plist_tips_importance objectAtIndex:idx];
            self.importance = slider.value;
            break;
        }
        case 400: {
            int idx = array_index_by_custom_perc(slider.value, 1.0f, 9.0f, self.plist_tips_skill.count);
            self.tips_label.text = [self.plist_tips_skill objectAtIndex:idx];
            self.skill = slider.value;
            break;
        }
        case 500: {
            int idx = array_index_by_custom_perc(slider.value, 1.0f, 9.0f, self.plist_tips_frequency.count);
            self.tips_label.text = [self.plist_tips_frequency objectAtIndex:idx];
            self.frequency = slider.value;
            break;
        }
    }
    [self update_results];
}


- (IBAction)showHelp:(id)sender {    
	
	HelpViewController *controller;
    if (IS_IPAD())
        controller = [[HelpViewController alloc] initWithNibName:@"HelpView-iPad" bundle:nil];
    else
        controller = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}
- (void)helpViewControllerDidFinish:(HelpViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)aboutViewControllerDidFinish:(AboutViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showAbout:(id)sender {    
	
	AboutViewController *controller;
    if (IS_IPAD())
        controller = [[AboutViewController alloc] initWithNibName:@"AboutView-iPad" bundle:nil];
    else
        controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (void)set_use_orig_formula:(BOOL)state {
    // 1 = yes, 0 = no
    switch (state)
    {
        case false:
        {
            self.formula_label.text = @"((U+C+I) x (10-S))/20 x 0.7 x 1/(1-sin(F/10))";
            self.use_orig_formula = 0;
            break;
        }
        case true:
        default:
        {
            self.formula_label.text = @"(((U+C+I) * (1-S))/2) * A * (1/(1-Sin(F)))";
            self.use_orig_formula = 1;
            break;
        }
    }
    [self update_results];
}

- (void)viewDidLoad {
    [self loadAllPlistData];
    self.formula_label.text = @"";
    self.result_label.text = @"";
    self.tips_label.text = @"";
    self.urgency = 1.0f;
    self.complexity = 1.0f;
    self.importance = 1.0f;
    self.skill = 9.0f;
    self.frequency = 9.0f;
    [self update_results];
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
    self.therm_image = nil;
}


- (void)dealloc {
    [self.plist_therm_img release];
    [self.plist_suggestion release];
    [self.plist_tips_urgency release];
    [self.plist_tips_complexity release];
    [self.plist_tips_importance release];
    [self.plist_tips_skill release];
    [self.plist_tips_frequency release];
    [super dealloc];
}


@end
