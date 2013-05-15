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
@class GLShader;
@class GLProgram;
@class DriftingGrating;
@class DriftingGratingParameterControl;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
}

@property (assign) IBOutlet NSWindow *window;
@property (strong) NSWindow *fullScreenWindow;
@property (strong) StimulusView *view;
@property (strong) GLProgram *program;
@property (strong) GLShader *vshader;
@property (strong) GLShader *fshader;
@property (weak) IBOutlet NSButton *showStimulusButton;
@property (strong) DriftingGrating *stimulus;
@property (weak) IBOutlet DriftingGratingParameterControl *stimulusControl;

- (IBAction)showStimulus:(id)sender;
- (IBAction)setStimulusOrientationAndRadius:(DriftingGratingParameterControl *)sender;
- (IBAction)setStimulusTemporalFrequency:(id)sender;

@end
