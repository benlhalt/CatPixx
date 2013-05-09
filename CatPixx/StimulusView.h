//
//  StimulusView.h
//  CatPixx
//
//  Created by Ben Halterman on 4/24/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Display;
@class GLProgram;
@class Stimulus;

@interface StimulusView : NSOpenGLView {
    CVDisplayLinkRef displayLink;
    GLfloat screenRatio;
    GLuint displayListID;
}

@property (weak, readonly) Display *display;
@property (strong, readonly) GLProgram *program;
@property (weak) Stimulus *stimulus;

- (id)initWithDisplay:(Display *)display;

- (void)startDisplayLink;

- (void)makeVAO;

- (CVReturn) drawFrameForTime:(const CVTimeStamp *)outputTime;

- (NSOpenGLPixelFormat *)defaultPixelFormat;

- (void)useProgram:(GLProgram *)program;

- (void)lockAndMakeCurrent;

- (void)unlock;

@end
