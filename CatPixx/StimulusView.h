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

@interface StimulusView : NSOpenGLView {
    CVDisplayLinkRef displayLink;
    GLfloat screenRatio;
    GLuint displayListID;
}

@property (weak, readonly) Display *display;

- (id)initWithDisplay:(Display *)display;

- (void)startDisplayLink;

- (void)makeDisplayList;

- (CVReturn) drawFrameForTime:(const CVTimeStamp *)outputTime;

- (NSOpenGLPixelFormat *)defaultPixelFormat;

- (void)useProgram:(GLProgram *)program;

@end
