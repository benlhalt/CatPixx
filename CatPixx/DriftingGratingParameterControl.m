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

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self.class setCellClass:[NSActionCell class]];
        self.cell = [[NSActionCell alloc] initImageCell:[NSImage imageWithSize:self.frame.size flipped:NO drawingHandler:^(NSRect dst){ return YES; }]];
        [self translateOriginToPoint:NSMakePoint(self.frame.size.width/2.0, self.frame.size.height/2.0)];
    }
    return self;
}

- (void)awakeFromNib {
    [self.window setAcceptsMouseMovedEvents:YES];
    [self setContinuous:YES];
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
    
    NSLog(@"x: %f, y: %f, dx: %f, dy: %f", location.x, location.y, theEvent.deltaX, theEvent.deltaY);

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
    NSLog(@"here");
}

@end
