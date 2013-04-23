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
    CGDirectDisplayID displayID = [[displays objectAtIndex:1] displayID];
    NSLog(@"%@", [[displays objectAtIndex:1] name]);
    NSOpenGLPixelFormat *pixelFormat = [AppDelegate getPixelFormat:displayID];
    if (pixelFormat == nil) {
        NSLog(@"pf is nil");
    }
    NSOpenGLContext *context = (NSOpenGLContext *)[[NSOpenGLContext alloc] initWithFormat:pixelFormat shareContext:nil];
    if (context == nil) {
        NSLog(@"context is nil");
    }
    CGError error = CGDisplayCapture(displayID);
    [context setFullScreen];
    [context makeCurrentContext];
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.6, 0.0);
        glVertex3f( -0.2, -0.3, 0.0);
        glVertex3f(  0.2, -0.3 ,0.0);
    }
    glEnd();
    NSLog(@"origin:%@", [NSScreen mainScreen].deviceDescription);
    NSLog(@"displayinfo:%i", [[displays objectAtIndex:0] displayID]);
}

+ (NSOpenGLPixelFormat *)getPixelFormat:(CGDirectDisplayID)displayID {
    NSOpenGLPixelFormatAttribute attributes [] = {
        NSOpenGLPFAScreenMask, (NSOpenGLPixelFormatAttribute) CGDisplayIDToOpenGLDisplayMask(displayID),
        NSOpenGLPFADoubleBuffer,
        (NSOpenGLPixelFormatAttribute)nil };
    return (NSOpenGLPixelFormat *)[[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
}

@end
