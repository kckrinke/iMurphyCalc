//
//  Config.h
//  iMurphyCalc
//
//  Created by Kevin C. Krinke on 11-03-12.
//  Copyright 2011 Kevin C. Krinke. All rights reserved.
//


#import "Config.h"


NSString * const APP_VERSION = @"1.0.4";

void DEBUG_DEVICE_INFO()
{
    UIDevice* thisDevice = [UIDevice currentDevice];
    float systemVersion = [[thisDevice systemVersion] floatValue];
    NSString *model = [thisDevice model];
    NSLog(@"Device Info: %s (iOS %.01f)",[model UTF8String],systemVersion);
}

BOOL IS_IPAD()
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return true;
#endif
    return false;
}
