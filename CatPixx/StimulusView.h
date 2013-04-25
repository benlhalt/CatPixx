//
//  StimulusView.h
//  CatPixx
//
//  Created by Ben Halterman on 4/24/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Display;

@interface StimulusView : NSOpenGLView {
    NSRecursiveLock *lock;
    CVDisplayLinkRef displayLink;
    CVImageBufferRef currentFrame;
    
    int frameCount;
    int frameRate;
    CVTimeStamp frameCountTimeStamp;
    double timebaseRatio;
}

@property (weak, readonly) Display *display;

- (id) initWithDisplay:(Display *)display;

- (CVReturn) drawFrameForTime:(const CVTimeStamp *)outputTime;

- (NSOpenGLPixelFormat *)defaultPixelFormat;

@end
