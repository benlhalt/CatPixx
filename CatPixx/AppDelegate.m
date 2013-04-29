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
#include <OpenGL/gl.h>
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
   
}

- (IBAction)showStimulus:(id)sender {
    NSArray *displays = [Display getCurrentDisplayList];
    Display *display = [displays objectAtIndex:0];
    NSLog(@"Using display: %@", display.name);
    NSRect mainDisplayRect = [display.screen frame];
    NSWindow *fullScreenWindow = [[NSWindow alloc] initWithContentRect: mainDisplayRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
    self.fullScreenWindow = fullScreenWindow;
    [fullScreenWindow setLevel:NSMainMenuWindowLevel+1];
    [fullScreenWindow setOpaque:YES];
    [fullScreenWindow setHidesOnDeactivate:YES];
    StimulusView *fullScreenView = [[StimulusView alloc] initWithDisplay:display];
    self.view = fullScreenView;
    [fullScreenWindow setContentView: fullScreenView];
    [fullScreenWindow makeKeyAndOrderFront:self];
   // [self.view.openGLContext makeCurrentContext];
    self.program = [[GLProgram alloc] initWithView:self.view];
    self.vshader = [[GLShader alloc] initWithFile:@"vert_test.vs" forShaderType:GL_VERTEX_SHADER];
    self.fshader = [[GLShader alloc] initWithFile:@"frag_test.fs" forShaderType:GL_FRAGMENT_SHADER];
    [self.program attachShader:self.vshader];
    [self.program attachShader:self.fshader];
    [self.program linkProgram];
    [self.view useProgram:self.program];
//    glEnable(GL_TEXTURE_2D);
//    GLuint textureID = 0;
//    glGenTextures(1, &textureID);
    [self.view startDisplayLink];
    GLsizei length = 0;
    glGetProgramiv(self.program.programID, GL_INFO_LOG_LENGTH, &length);
    GLchar *info = calloc(length+1, sizeof(GLchar));
    glGetProgramInfoLog(self.program.programID, length, &length, info);
    NSLog(@"length: %i %s", length, info);
    free(info);
}

@end
