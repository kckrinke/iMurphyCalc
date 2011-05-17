//
//  SettingsMonitor.m
//  Netel
//
//  Created by Kevin C. Krinke on 11-05-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsMonitor.h"


@implementation SettingsMonitor
@synthesize delegate;

- (id)initWithDelegate:(id)dlgt
{
    if ((self = [super init]))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *cur_string = [defaults stringForKey:@"app_version"];
        if (![cur_string isEqualToString:APP_VERSION])
        {
            [defaults setValue:APP_VERSION forKey:@"app_version"];
            NSLog(@"Changed version in settings bundle: %@ -> %@",cur_string,APP_VERSION);
        }
        [self setDelegate:dlgt];
    }
    return self;
}
- (void)settingsChanged:(NSNotification *)notification
{
    [self.delegate settingsChanged:notification];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [delegate release];
    [super dealloc];
}

@end
