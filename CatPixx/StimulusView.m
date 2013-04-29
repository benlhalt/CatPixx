//
//  StimulusView.m
//  CatPixx
//
//  Created by Ben Halterman on 4/24/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//


#import "StimulusView.h"
#import "GLProgram.h"
#import "Display.h"

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

- (id)initWithDisplay:(Display *)display
{
    self = [super initWithFrame:display.screen.frame pixelFormat:[self defaultPixelFormat]];
    if (self) {
        _display = display;
        CGLLockContext([self.openGLContext CGLContextObj]);
        [self.openGLContext makeCurrentContext];
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        screenRatio =  (GLfloat)display.screen.frame.size.width/(GLfloat)display.screen.frame.size.height;
        glOrtho(-(GLdouble)screenRatio, (GLdouble)screenRatio, -1.0, 1.0, -1.0, 1.0);
        glMatrixMode(GL_MODELVIEW);
        CGLUnlockContext([self.openGLContext CGLContextObj]);
        [self makeDisplayList];
        CVReturn error = CVDisplayLinkCreateWithCGDisplay(display.displayID, &displayLink);
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
//    currentFrame = [self.stimulus.getFrameForTime:outputTime];
    [self drawRect:NSZeroRect];
    return kCVReturnSuccess;
}

- (void)makeDisplayList {
    CGLLockContext([self.openGLContext CGLContextObj]);
    displayListID = glGenLists(1);
    glNewList(displayListID, GL_COMPILE);
    glColor3f(0.5, 0.5, 0.5);
    glBegin(GL_QUADS);
    {
        glTexCoord2f(0.0, 0.0); glVertex3f( -0.4, -0.4, 0.0);
        glTexCoord2f(0.0, 1.0); glVertex3f( -0.4, 0.4, 0.0);
        glTexCoord2f(1.0, 1.0); glVertex3f(  0.4, 0.4 ,0.0);
        glTexCoord2f(1.0, 0.0); glVertex3f(  0.4, -0.4 ,0.0);
    }
    glEnd();
    glEndList();
    CGLUnlockContext([self.openGLContext CGLContextObj]);
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGLLockContext([self.openGLContext CGLContextObj]);
    [self.openGLContext makeCurrentContext];
    glClearColor(0.5, 0.5, 0.5, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glCallList(displayListID);
    glSwapAPPLE();
    CGLUnlockContext([self.openGLContext CGLContextObj]);
}

- (NSOpenGLPixelFormat *)defaultPixelFormat
{
    NSOpenGLPixelFormatAttribute attributes [] = {
        NSOpenGLPFAScreenMask, (NSOpenGLPixelFormatAttribute) CGDisplayIDToOpenGLDisplayMask(_display.displayID),
        NSOpenGLPFADoubleBuffer,
        (NSOpenGLPixelFormatAttribute)nil };
    return (NSOpenGLPixelFormat *)[[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
}

- (void)useProgram:(GLProgram *)program {
    CGLLockContext([self.openGLContext CGLContextObj]);
    [self.openGLContext makeCurrentContext];
    glUseProgram(program.programID);
    CGLUnlockContext([self.openGLContext CGLContextObj]);
}

@end
