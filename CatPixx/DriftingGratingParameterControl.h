//
//  DriftingGratingParameterControl.h
//  CatPixx
//
//  Created by Ben Halterman on 5/14/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DriftingGratingParameterControl : NSControl

@property double theta;
@property double radius;
@property (strong) NSTrackingArea *trackingArea;

//- (void)mouseEvent:(NSEvent *)theEvent;
//
//- (void)mouseMoved:(NSEvent *)theEvent;

@end
