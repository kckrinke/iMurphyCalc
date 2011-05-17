//
//  SettingsMonitor.h
//  Netel
//
//  Created by Kevin C. Krinke on 11-05-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@protocol SettingsMonitorDelegate;
@interface SettingsMonitor : NSObject
{
    id delegate;
}
@property (nonatomic,assign) id delegate;
- (void)settingsChanged:(NSNotification *)notification;
- (id)initWithDelegate:(id)dlgt;
@end

@protocol SettingsMonitorDelegate <NSObject>
- (void)settingsChanged:(NSNotification*)notification;
@end
