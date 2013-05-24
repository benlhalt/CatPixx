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
#import "GLProgram.h"
#import "GLShader.h"
#import "OpenGL/gl3.h"
#import "OpenGL/gl3ext.h"
#import "DriftingGrating.h"
#import "DriftingGratingParameterControl.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
   
}

- (IBAction)showStimulus:(id)sender {
    NSArray *displays = [Display getCurrentDisplayList];
    Display *display = [displays objectAtIndex:1];
    NSLog(@"Using display: %@", display.name);
    NSRect mainDisplayRect = [display.screen frame];
//    mainDisplayRect.size.width /= 2;
//    mainDisplayRect.size.height /= 2;
    
    NSWindow *fullScreenWindow = [[NSWindow alloc] initWithContentRect: mainDisplayRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
    self.fullScreenWindow = fullScreenWindow;
    [fullScreenWindow setLevel:NSScreenSaverWindowLevel];
    [fullScreenWindow setOpaque:YES];
    StimulusView *fullScreenView = [[StimulusView alloc] initWithDisplay:display];
    self.view = fullScreenView;
    [fullScreenWindow setContentView: fullScreenView];
    
    
    
    [self.view.openGLContext makeCurrentContext];
    NSLog(@"OpenGL version: %s", glGetString(GL_VERSION));
    self.program = [[GLProgram alloc] initWithView:self.view];
    self.vshader = [[GLShader alloc] initWithFile:@"sinegrating.vs" forShaderType:GL_VERTEX_SHADER];
    self.fshader = [[GLShader alloc] initWithFile:@"aperture.fs" forShaderType:GL_FRAGMENT_SHADER];
    [self.program attachShader:self.vshader];
    [self.program attachShader:self.fshader];
    [self.program linkProgram];
    [self.view useProgram:self.program];
    DriftingGrating *grating = [[DriftingGrating alloc] initWithProgram:self.program];
    self.view.stimulus = grating;
    self.stimulus = grating;
    [self.view makeVAO];
    
    GLsizei length = 0;
    glGetProgramiv(self.program.programID, GL_INFO_LOG_LENGTH, &length);
    GLchar *info = calloc(length+1, sizeof(GLchar));
    glGetProgramInfoLog(self.program.programID, length, &length, info);
    NSLog(@"ProgramInfo: %i %s", length, info);
    free(info);
    glGetShaderiv(self.vshader.shaderID, GL_INFO_LOG_LENGTH, &length);
    info = calloc(length+1, sizeof(GLchar));
    glGetShaderInfoLog(self.vshader.shaderID, length, &length, info);
    NSLog(@"vshaderInfo: %i %s", length, info);
    free(info);
    glGetShaderiv(self.fshader.shaderID, GL_INFO_LOG_LENGTH, &length);
    info = calloc(length+1, sizeof(GLchar));
    glGetShaderInfoLog(self.fshader.shaderID, length, &length, info);
    NSLog(@"fshaderInfo: %i %s", length, info);
    free(info);
    [fullScreenWindow makeKeyAndOrderFront:self];
    [self.view startDisplayLink];
}

- (IBAction)setStimulusOrientationAndRadius:(DriftingGratingParameterControl *)sender {
    self.stimulus.orientation = sender.theta;
    self.stimulus.spatialFrequency = sender.radius;
    self.stimulus.radius = sender.apertureRadius;
    self.stimulus.temporalFrequency = sender.temporalFrequency;
}

- (IBAction)setStimulusTemporalFrequency:(id)sender {
    self.stimulus.temporalFrequency = [sender floatValue];
}

@end
