//
//  DriftingGratingParameterControl.m
//  CatPixx
//
//  Created by Ben Halterman on 5/14/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "DriftingGratingParameterControl.h"
#import "Carbon/Carbon.h"

@implementation DriftingGratingParameterControl


@synthesize theta = _theta;
@synthesize radius = _radius;
@synthesize trackingArea = _trackingArea;
@synthesize apertureRadius = _apertureRadius;
@synthesize temporalFrequency = _temporalFrequency;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self translateOriginToPoint:NSMakePoint(self.bounds.size.width/2.0, self.bounds.size.height/2.0)];
        NSPoint origin = {.x = -self.bounds.size.width/2.0, .y = -self.bounds.size.height/2.0};
        _square.origin = origin;
        CGFloat sideLength = MIN(self.bounds.size.width, self.bounds.size.height);
        _square.size.width = sideLength;
        _square.size.height = sideLength;
        [self.class setCellClass:[NSActionCell class]];
        self.cell = [[NSActionCell alloc] init];
        _trackingArea = [[NSTrackingArea alloc] initWithRect:_square
                                                    options:NSTrackingActiveWhenFirstResponder|NSTrackingMouseMoved|NSTrackingEnabledDuringMouseDrag
                                                    owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
        _circlePath = [NSBezierPath bezierPathWithOvalInRect:_square];
        _frozen = YES;
        _apertureRadius = 0.5;
        _temporalFrequency = 2.0;
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [[NSColor greenColor] setFill];
    [_circlePath fill];
    [_circlePath stroke];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)mouseEvent:(NSEvent *)theEvent {
    NSPoint location = [self convertPoint:theEvent.locationInWindow fromView:nil];
    if (!_frozen && [_circlePath containsPoint:location]) {
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
}

- (void)mouseMoved:(NSEvent *)theEvent {
    [self mouseEvent:theEvent];
}

- (void)mouseDown:(NSEvent *)theEvent {
    _frozen = !_frozen;
    [self mouseEvent:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    [self mouseEvent:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent {
    [self mouseEvent:theEvent];
}

- (void)keyDown:(NSEvent *)theEvent {
    unichar key = [theEvent.charactersIgnoringModifiers characterAtIndex:0];
    if (key == NSUpArrowFunctionKey) {
        _apertureRadius *= 1.05;
    } else if (key == NSDownArrowFunctionKey && _apertureRadius > 0.02) {
        _apertureRadius *= 0.95;
    } else if (key == NSRightArrowFunctionKey) {
        _temporalFrequency *= 1.1;
    } else if (key == NSLeftArrowFunctionKey) {
        _temporalFrequency *= 0.9;
    }
    [self sendAction:self.action to:self.target];
}

@end
