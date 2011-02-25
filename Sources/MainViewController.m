//
//  MainViewController.m
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-02-03.
//  Copyright 2011  Kevin C. Krinke. All rights reserved.
//

#import "MainViewController.h"
#include "sodmath.h"

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


- (NSString*)get_indice_by_result:(NSString*)plist_name:(float)result {
   NSString *path = [[NSBundle mainBundle] pathForResource:plist_name ofType:@"plist"];
   NSMutableArray *plist_data = [[NSMutableArray alloc] initWithContentsOfFile:path];
   int idx = array_index_by_custom_perc(result,0.0f,1.0f,plist_data.count);
   return [plist_data objectAtIndex:idx];
}

- (void)update_results {
   float result = [self calculate_sod_factor];
   NSString *img = [self get_indice_by_result:@"therm_img":result];
   [self.therm_image setImage:[UIImage imageNamed:img]];
   NSString *txt = [self get_indice_by_result:@"suggestion":result];
   self.suggest_label.text = txt;
   int percentage = mClampI((int)(result * 100),0,100);
   NSString *text = [[NSString alloc] initWithFormat:@"%d%%",percentage];
   self.result_label.text = text;
}

- (IBAction)reset_tips_label:(id)sender {
   self.tips_label.text = @"";
}

- (void)set_tips_label_text:(NSString*)plist_name:(float)slider_value {
   NSString *path = [[NSBundle mainBundle] pathForResource:plist_name ofType:@"plist"];
   NSMutableArray *tips = [[NSMutableArray alloc] initWithContentsOfFile:path];
   int idx = array_index_by_custom_perc(slider_value,1.0f,9.0f,tips.count);
   self.tips_label.text = [tips objectAtIndex:idx];
}

- (IBAction)update_labels:(id)sender {
   UISlider *slider = (UISlider *)sender;
   switch (slider.tag) {
      case 100: {
         [self set_tips_label_text:@"tips_urgency":slider.value];
         self.urgency = slider.value;
         break;
      }
      case 200: {
         [self set_tips_label_text:@"tips_complexity":slider.value];
         self.complexity = slider.value;
         break;
      }
      case 300: {
         [self set_tips_label_text:@"tips_importance":slider.value];
         self.importance = slider.value;
         break;
      }
      case 400: {
         [self set_tips_label_text:@"tips_skill":slider.value];
         self.skill = slider.value;
         break;
      }
      case 500: {
         [self set_tips_label_text:@"tips_frequency":slider.value];
         self.frequency = slider.value;
         break;
      }
   }
   [self update_results];
}


- (IBAction)showHelp:(id)sender {    
	
	HelpViewController *controller = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
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
	
	AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
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
    [super dealloc];
}


@end
