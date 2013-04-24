//
//  StimulusView.m
//  CatPixx
//
//  Created by Ben Halterman on 4/24/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "StimulusView.h"
#import "Display.h"

@implementation StimulusView

@synthesize display = _display;

- (id)initWithDisplay:(Display *)display
{
    self = [super initWithFrame:display.screen.frame pixelFormat:[self defaultPixelFormat]];
    if (self) {
        _display = display;
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self.openGLContext makeCurrentContext];
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.6, 0.0);
        glVertex3f( -0.2, -0.3, 0.0);
        glVertex3f(  0.2, -0.3 ,0.0);
    }
    glEnd();
    glSwapAPPLE();
}

- (NSOpenGLPixelFormat *)defaultPixelFormat
{
    NSOpenGLPixelFormatAttribute attributes [] = {
        NSOpenGLPFAScreenMask, (NSOpenGLPixelFormatAttribute) CGDisplayIDToOpenGLDisplayMask(_display.displayID),
        NSOpenGLPFADoubleBuffer,
        (NSOpenGLPixelFormatAttribute)nil };
    return (NSOpenGLPixelFormat *)[[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
}

@end
