//
//  AppDelegate.m
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "AppDelegate.h"
#import "Display.h"
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSArray *displays = [Display getCurrentDisplayList];
}

@end
