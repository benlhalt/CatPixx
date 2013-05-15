//
//  DriftingGratingParameterControl.m
//  CatPixx
//
//  Created by Ben Halterman on 5/14/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "DriftingGratingParameterControl.h"

@implementation DriftingGratingParameterControl


@synthesize theta = _theta;
@synthesize radius = _radius;
@synthesize trackingArea = _trackingArea;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        NSPoint origin = {.x = -self.bounds.size.width/2.0, .y = -self.bounds.size.height/2.0};
        NSRect area = {.origin = origin, .size = self.bounds.size};
        [self.class setCellClass:[NSActionCell class]];
        self.cell = [[NSActionCell alloc] initImageCell:[[NSImage alloc] initWithSize:self.bounds.size]];
        _trackingArea = [[NSTrackingArea alloc] initWithRect:area
                                                    options:NSTrackingActiveAlways|NSTrackingMouseMoved
                                                    owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
        [self translateOriginToPoint:NSMakePoint(self.frame.size.width/2.0, self.frame.size.height/2.0)];
    }
    return self;
}

- (void)awakeFromNib {
//    [self setContinuous:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)mouseEvent:(NSEvent *)theEvent {
    NSPoint location = [self convertPoint:theEvent.locationInWindow fromView:nil];
    double correction = 0.0; // quadrant I
    BOOL upper = location.y >= 0.0;
    BOOL right = location.x >= 0.0;
    if (!right) {           // quadrant II & III
        correction = M_PI;
    } else if (!upper){     // quadrant IV
        correction = 2.0*M_PI;
    }
    _theta = atan(location.y/location.x) + correction;
    _radius = hypot(location.x, location.y);
    [self sendAction:self.action to:self.target];
    [super mouseMoved:theEvent];
}

- (void)mouseMoved:(NSEvent *)theEvent {
    [self mouseEvent:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent { //not working?
    [self mouseEvent:theEvent];
}

@end
