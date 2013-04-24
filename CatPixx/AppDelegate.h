//
//  AppDelegate.h
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Display;
@class StimulusView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property NSWindow *fullScreenWindow;
@property StimulusView *view;

@end
