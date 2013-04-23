//
//  AppDelegate.m
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "AppDelegate.h"
#import "Display.h"
#include <OpenGL/gl.h>
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSArray *displays = [Display getCurrentDisplayList];
    CGDirectDisplayID displayID = [[displays objectAtIndex:0] displayID];
    NSOpenGLPixelFormat *pixelFormat = [AppDelegate getPixelFormat:displayID];
    NSOpenGLContext *context = (NSOpenGLContext *)[[NSOpenGLContext alloc] initWithFormat:pixelFormat shareContext:nil];
    [context makeCurrentContext];
    [context setFullScreen];
    
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.6, 0.0);
        glVertex3f( -0.2, -0.3, 0.0);
        glVertex3f(  0.2, -0.3 ,0.0);
    }
    glEnd();
}

+ (NSOpenGLPixelFormat *)getPixelFormat:(CGDirectDisplayID)displayID {
    NSOpenGLPixelFormatAttribute attributes [] = {
        (NSOpenGLPixelFormatAttribute) CGDisplayIDToOpenGLDisplayMask(displayID),
        NSOpenGLPFADoubleBuffer,
        (NSOpenGLPixelFormatAttribute)nil };
    return (NSOpenGLPixelFormat *)[[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
}

@end
