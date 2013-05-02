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

- (id)initWithDisplay:(Display *)display
{
    self = [super initWithFrame:display.screen.frame pixelFormat:[self defaultPixelFormat]];
    if (self) {
        _display = display;
        CGLLockContext([self.openGLContext CGLContextObj]);
        [self.openGLContext makeCurrentContext];
//        glEnableClientState(GL_VERTEX_ARRAY);
//        glMatrixMode(GL_PROJECTION);
//        glLoadIdentity();
        screenRatio =  (GLfloat)display.screen.frame.size.width/(GLfloat)display.screen.frame.size.height;
        NSLog(@"ratio : %f", screenRatio);
//        glOrtho(-(GLdouble)screenRatio, (GLdouble)screenRatio, -1.0, 1.0, -1.0, 1.0);
//        glMatrixMode(GL_MODELVIEW);
        CGLUnlockContext([self.openGLContext CGLContextObj]);
      //  [self makeGLDisplayList];
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

GLint contrastPreMultiplicatorID;
GLint radiusID;
GLint centerID;
GLint offsetID;
GLint phaseAL;

GLfloat modulateColor[] = {1.0, 1.0, 1.0, 1.0};
GLfloat auxParameters[] = {45.0, 5.0, 1.0, 0.0}; // {degrees, Hz, contrast, unused}
GLuint modulateColorID, auxParametersID;
GLint modulateColorAL, auxParametersAL;

GLfloat vertexArray[] = {
    -3.2, -2.0,
    -3.2,  2.0,
     3.2, -2.0,
     3.2,  2.0
};

GLfloat textureArray[] = {
    -1.6, -1.0,
    -1.6,  1.0,
     1.6, -1.0,
     1.6,  1.0
};

GLuint vao=666, vertexBO=666, textureBO=666;
GLint vertexAL=666, textureAL=666;

- (void)makeGLDisplayList {
    CGLLockContext([self.openGLContext CGLContextObj]);
    [self.openGLContext makeCurrentContext];
//    glEnableClientState(GL_VERTEX_ARRAY);
    
//    contrastPreMultiplicatorID = glGetUniformLocation(self.program.programID, "contrastPreMultiplicator");
//    radiusID = glGetUniformLocation(self.program.programID, "Radius");
//    centerID = glGetUniformLocation(self.program.programID, "Center");
    phaseAL = glGetUniformLocation(self.program.programID, "Phase");
    
//    glUniform1f(contrastPreMultiplicatorID, 1.0);
//    glUniform1f(radiusID, 0.5);
//    glUniform2f(centerID, 0.0, 1.0);
//    glUniform4f(offsetID, 0.0, 0.0, 0.0, 0.0);


   
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    
    glGenBuffers(1, &vertexBO);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexArray), vertexArray, GL_STATIC_DRAW);
    
    vertexAL = glGetAttribLocation(self.program.programID, "position2d");
    glEnableVertexAttribArray(vertexAL);
    glVertexAttribPointer(vertexAL, 2, GL_FLOAT, GL_FALSE, 0, 0);
    
//    glGenBuffers(1, &textureBO);
//    glBindBuffer(GL_ARRAY_BUFFER, textureBO);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(textureArray), textureArray, GL_DYNAMIC_READ);
//    
//    textureAL = glGetAttribLocation(self.program.programID, "texture2d");
//    glEnableVertexAttribArray(textureAL);
//    glVertexAttribPointer(textureAL, 2, GL_FLOAT, GL_FALSE, 0, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    
    CGLUnlockContext([self.openGLContext CGLContextObj]);
}
GLfloat phase = 0.0;
- (void)drawRect:(NSRect)dirtyRect
{
    CGLLockContext([self.openGLContext CGLContextObj]);
    [self.openGLContext makeCurrentContext];
    glClearColor(0.5, 0.5, 0.5, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glUniform1f(phaseAL, phase++/5);
    glBindVertexArray(vao);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glBindVertexArray(0);
    glSwapAPPLE();
    CGLUnlockContext([self.openGLContext CGLContextObj]);
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
    CGLLockContext([self.openGLContext CGLContextObj]);
    _program = program;
    [self.openGLContext makeCurrentContext];
    glUseProgram(program.programID);
    CGLUnlockContext([self.openGLContext CGLContextObj]);
}

@end
