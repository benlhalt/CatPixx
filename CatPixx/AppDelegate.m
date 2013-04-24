//
//  AppDelegate.m
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "AppDelegate.h"
#import "Display.h"
#import "StimulusView.h"
#include <OpenGL/gl.h>
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSArray *displays = [Display getCurrentDisplayList];
    Display *display = [displays objectAtIndex:0];
    NSLog(@"%@", display.name);
    NSRect mainDisplayRect = [display.screen frame];
    NSLog(@"x %g, y %g, w %g, h %g", mainDisplayRect.origin.x, mainDisplayRect.origin.y, mainDisplayRect.size.width,mainDisplayRect.size.height);
    NSWindow *fullScreenWindow = [[NSWindow alloc] initWithContentRect: mainDisplayRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
    self.fullScreenWindow = fullScreenWindow;
    [fullScreenWindow setLevel:NSMainMenuWindowLevel+1];
    [fullScreenWindow setOpaque:YES];
    [fullScreenWindow setHidesOnDeactivate:YES];
    StimulusView *fullScreenView = [[StimulusView alloc] initWithDisplay:display];
    self.view = fullScreenView;
    [fullScreenWindow setContentView: fullScreenView];
    [fullScreenWindow makeKeyAndOrderFront:self];
    
}

@end
