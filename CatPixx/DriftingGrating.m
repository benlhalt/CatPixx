//
//  DriftingGrating.m
//  CatPixx
//
//  Created by Ben Halterman on 5/6/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "DriftingGrating.h"
#import "GLUniformAttribute.h"
#import "GLProgram.h"
#import "StimulusView.h"

@implementation DriftingGrating

@synthesize contrast = _contrast;
@synthesize center = _center;
@synthesize radius = _radius;
@synthesize orientation = _orientation;
@synthesize temporalFrequency = _temporalFrequency;
@synthesize spatialFrequency = _spatialFrequency;

- (id)initWithProgram:(GLProgram *)program {
    self = [super initWithProgram:program];
    if (self) {
        [self setUniformKey:@"contrast" withValue:@1.0];
        [self setUniformKey:@"center" withValue:@[@0.0, @0.0]];
        [self setUniformKey:@"radius" withValue:@1.5];
        [self setUniformKey:@"orientation" withValue:@(0*M_PI)];
        [self setUniformKey:@"spatialFrequency" withValue:@20.0];
        [self setUniformKey:@"phase" withValue:@0.0];
        _temporalFrequency = 2.0;
        _lastDrawTime = 0;
    }
    return self;
}

- (void)updateScreenForTime:(const CVTimeStamp *)outputTimeStamp {
    if (_lastDrawTime == 0) {
        _phase = 0.0;
    }  else {
        float timeSinceLastDraw = ((double)(outputTimeStamp->videoTime - _lastDrawTime))/((double)(outputTimeStamp->videoTimeScale));
        _phase = fmod(_phase + 2.0 * M_PI * timeSinceLastDraw * self.temporalFrequency, 2.0 * M_PI);
        ((GLUniformAttribute *)(self.uniformAttributes[@"phase"])).value = [NSNumber numberWithFloat:_phase];
    }
    _lastDrawTime = outputTimeStamp->videoTime;
    [super updateScreenForTime:outputTimeStamp];
}

- (float)contrast {
    return _contrast;
}

- (void)setContrast:(float)contrast {
    _contrast = contrast;
    [self setUniformKey:@"contrast" withValue:@(contrast)];
}

- (NSPoint)center {
    return _center;
}

- (void)setCenter:(NSPoint)center {
    _center = center;
    [self setUniformKey:@"center" withValue:@[@(center.x), @(center.y)]];
}

- (float)radius {
    return _radius;
}

- (void)setRadius:(float)radius {
    _radius = radius;
    [self setUniformKey:@"radius" withValue:@(radius)];
}

- (float)orientation {
    return _orientation;
}

- (void)setOrientation:(float)orientation {
    _orientation = orientation;
    [self setUniformKey:@"orientation" withValue:@(orientation)];
}

- (float)temporalFrequency {
    return _temporalFrequency;
}

- (void)setTemporalFrequency:(float)temporalFrequency {
    _temporalFrequency = temporalFrequency;
}

- (float)spatialFrequency {
    return _spatialFrequency;
}

- (void)setSpatialFrequency:(float)spatialFrequency {
    _spatialFrequency = spatialFrequency;
    [self setUniformKey:@"spatialFrequency" withValue:@(spatialFrequency)];
}

@end
