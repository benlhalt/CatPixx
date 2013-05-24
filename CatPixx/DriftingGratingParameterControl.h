//
//  DriftingGratingParameterControl.h
//  CatPixx
//
//  Created by Ben Halterman on 5/14/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DriftingGratingParameterControl : NSControl {
    NSRect _square;
    NSBezierPath *_circlePath;
    BOOL _frozen;
}

@property double theta;
@property double radius;
@property double apertureRadius;
@property double temporalFrequency;
@property (strong) NSTrackingArea *trackingArea;

@end
