//
//  StimulusView.m
//  CatPixx
//
//  Created by Ben Halterman on 4/24/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//


#import "StimulusView.h"
#import "Stimulus.h"
#import "GLProgram.h"
#import "Display.h"
#import "OpenGL/gl3.h"
#import "OpenGL/gl3ext.h"

static CVReturn stimulusDisplayLinkCallback( CVDisplayLinkRef displayLink,
                                             const CVTimeStamp *inNow,
                                             const CVTimeStamp *inOutputTime,
                                             CVOptionFlags flagsIn,
                                             CVOptionFlags *flagsOut,
                                             void *displayLinkContext ) {
    CVReturn result = kCVReturnError;
    @autoreleasepool {
        StimulusView *view = (__bridge StimulusView *)displayLinkContext;
        result = [view drawFrameForTime:inOutputTime];
    }
    return result;
}

@implementation StimulusView

@synthesize display = _display;
@synthesize program = _program;
@synthesize stimulus = _stimulus;

- (id)initWithDisplay:(Display *)display
{
    self = [super initWithFrame:display.screen.frame pixelFormat:[self defaultPixelFormat]];
    if (self) {
        _display = display;
        CGLLockContext([self.openGLContext CGLContextObj]);
        [self.openGLContext makeCurrentContext];
        screenRatio =  (GLfloat)display.screen.frame.size.width/(GLfloat)display.screen.frame.size.height;
        NSLog(@"ratio : %f", screenRatio);        CGLUnlockContext([self.openGLContext CGLContextObj]);        CVReturn error = CVDisplayLinkCreateWithCGDisplay(display.displayID, &displayLink);
        if(error) {
            NSLog(@"DisplayLink created with error:%d", error);
            displayLink = NULL;
        } else {
            error = CVDisplayLinkSetOutputCallback(displayLink, stimulusDisplayLinkCallback, (__bridge void *)self);
            if (error) {
                NSLog(@"StimulusView initWithDisplay: set displaylink callback failed with error %i", error);
            }
        }
    }
    return self;
}

- (void)startDisplayLink {
    CVReturn error = CVDisplayLinkStart(displayLink);
    if (error != kCVReturnSuccess) {
        NSLog(@"StimulusView startDisplayLink: Error: %i", error);
    }
}

- (CVReturn) drawFrameForTime:(const CVTimeStamp *)outputTime {
    [self lockAndMakeCurrent];
    [self.stimulus updateScreenForTime:outputTime];
    
    glClearColor(0.5, 0.5, 0.5, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glBindVertexArray(vao);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glBindVertexArray(0);
    glSwapAPPLE();
    
    [self unlock];
    return kCVReturnSuccess;
}

GLfloat vertexArray[] = {
    -3.2, -2.0,
    -3.2,  2.0,
     3.2, -2.0,
     3.2,  2.0
};

GLuint vao=666, vertexBO=666;
GLint vertexAL=666;

- (void)makeVAO {
    [self lockAndMakeCurrent];

    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    
    glGenBuffers(1, &vertexBO);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexArray), vertexArray, GL_STATIC_DRAW);
    
    vertexAL = glGetAttribLocation(self.program.programID, "position2d");
    glEnableVertexAttribArray(vertexAL);
    glVertexAttribPointer(vertexAL, 2, GL_FLOAT, GL_FALSE, 0, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    
    [self unlock];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

- (NSOpenGLPixelFormat *)defaultPixelFormat
{
    NSOpenGLPixelFormatAttribute attributes [] = {
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core,
        NSOpenGLPFAScreenMask, (NSOpenGLPixelFormatAttribute) CGDisplayIDToOpenGLDisplayMask(_display.displayID),
        NSOpenGLPFADoubleBuffer,
        (NSOpenGLPixelFormatAttribute)nil };
    return (NSOpenGLPixelFormat *)[[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
}

- (void)useProgram:(GLProgram *)program {
    [self lockAndMakeCurrent];
    _program = program;
    [self.openGLContext makeCurrentContext];
    glUseProgram(program.programID);
    [self unlock];
}

- (void)lockAndMakeCurrent {
    CGLLockContext([self.openGLContext CGLContextObj]);
    [self.openGLContext makeCurrentContext];
}

- (void)unlock {
    CGLUnlockContext([self.openGLContext CGLContextObj]);
}

@end
